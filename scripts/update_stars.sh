#!/bin/bash
# Update GitHub star counts in all category files.
# Requires: gh (GitHub CLI, authenticated), python3, jq
# Usage: ./scripts/update_stars.sh

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_ROOT="$(dirname "$SCRIPT_DIR")"
CATEGORIES_DIR="$REPO_ROOT/categories"
TMPDIR="${TMPDIR:-/tmp}"

echo "=== Step 1: Extract GitHub repo URLs from category files ==="

grep -rhoP 'github\.com/[^/]+/[^/)\]#\s]+' "$CATEGORIES_DIR"/*.md \
  | sed 's|/$||' \
  | sort -u \
  | sed 's|^github\.com/||' \
  > "$TMPDIR/repos_list.txt"

total=$(wc -l < "$TMPDIR/repos_list.txt")
echo "Found $total unique GitHub repos"

echo "=== Step 2: Fetch star counts via GitHub GraphQL API ==="

> "$TMPDIR/repo_stars_clean.tsv"
BATCH_SIZE=50
offset=0

while [ "$offset" -lt "$total" ]; do
  query="query {"
  declare -a repos_in_batch=()
  i=0

  while IFS= read -r repo && [ "$i" -lt "$BATCH_SIZE" ]; do
    owner="${repo%%/*}"
    name="${repo#*/}"
    alias="r$(echo "${owner}_${name}" | sed 's/[^a-zA-Z0-9]/_/g')"
    query="$query $alias: repository(owner: \"$owner\", name: \"$name\") { stargazerCount }"
    repos_in_batch+=("$alias|$repo")
    i=$((i + 1))
  done < <(tail -n +$((offset + 1)) "$TMPDIR/repos_list.txt" | head -n "$BATCH_SIZE")

  query="$query }"

  if result=$(gh api graphql -f query="$query" 2>/dev/null); then
    for entry in "${repos_in_batch[@]}"; do
      alias="${entry%%|*}"
      repo="${entry#*|}"
      stars=$(echo "$result" | jq -r ".data.${alias}.stargazerCount // empty")
      if [ -n "$stars" ]; then
        printf '%s\t%s\n' "$repo" "$stars" >> "$TMPDIR/repo_stars_clean.tsv"
      fi
    done
  else
    # Fallback to REST API for this batch
    for entry in "${repos_in_batch[@]}"; do
      repo="${entry#*|}"
      stars=$(gh api "repos/$repo" --jq '.stargazers_count' 2>/dev/null || true)
      if [ -n "$stars" ] && [ "$stars" != "null" ]; then
        printf '%s\t%s\n' "$repo" "$stars" >> "$TMPDIR/repo_stars_clean.tsv"
      fi
    done
  fi

  offset=$((offset + BATCH_SIZE))
  echo "  Fetched $offset / $total"
done

found=$(wc -l < "$TMPDIR/repo_stars_clean.tsv")
echo "Got star counts for $found repos"

echo "=== Step 3: Update category files ==="

python3 - "$CATEGORIES_DIR" "$TMPDIR/repo_stars_clean.tsv" << 'PYEOF'
import re, os, sys, glob

categories_dir = sys.argv[1]
stars_file = sys.argv[2]

stars = {}
with open(stars_file) as f:
    for line in f:
        parts = line.strip().split('\t')
        if len(parts) == 2:
            try:
                stars[parts[0].lower()] = int(parts[1])
            except ValueError:
                pass

def format_stars(count):
    if count >= 10000:
        return f"{count // 1000}k"
    elif count >= 1000:
        return f"{count / 1000:.1f}k"
    return str(count)

def update_line(line):
    m = re.search(r'github\.com/([^/]+/[^/)\]#\s]+)', line)
    if not m:
        return line
    repo = m.group(1).rstrip('/').lower()
    if repo not in stars:
        return line
    star_str = format_stars(stars[repo])
    # Remove existing star count
    line = re.sub(r'\s*⭐\s*[\d.]+k?\s*', ' ', line)
    # Insert after link
    line = re.sub(
        r'(\]\(https://github\.com/' + re.escape(m.group(1).rstrip('/')) + r'[^)]*\))',
        lambda x: f"{x.group(1)} ⭐ {star_str}",
        line,
        flags=re.IGNORECASE
    )
    return line

for filepath in sorted(glob.glob(os.path.join(categories_dir, '*.md'))):
    with open(filepath) as f:
        lines = f.readlines()
    in_impl = False
    new_lines = []
    changed = False
    for line in lines:
        if '**Implementations:**' in line:
            in_impl = True
            new_lines.append(line)
            continue
        if in_impl:
            if line.strip() == '' or (line.startswith('**') and 'Implementations' not in line):
                in_impl = False
                new_lines.append(line)
                continue
            new_line = update_line(line)
            if new_line != line:
                changed = True
            new_lines.append(new_line)
        else:
            new_lines.append(line)
    if changed:
        with open(filepath, 'w') as f:
            f.writelines(new_lines)
        print(f"  Updated: {os.path.basename(filepath)}")

PYEOF

echo "=== Done ==="
