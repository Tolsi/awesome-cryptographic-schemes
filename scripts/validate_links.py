#!/usr/bin/env python3
"""Validate all internal cross-reference links in the awesome-cryptographic-schemes repo."""
import re
import os
import glob

repo_root = '/mnt/HC_Volume_105218442/dev/awesome-cryptographic-schemes'

def slugify(heading):
    """GitHub-style anchor slugification."""
    slug = heading.lower()
    slug = re.sub(r'[^\w\s-]', '', slug)  # remove non-alphanumeric except hyphens and spaces
    slug = re.sub(r'\s+', '-', slug.strip())
    slug = re.sub(r'-+', '-', slug)
    return slug

# Step 1: Build a map of all anchors in all .md files
# file_path -> set of anchors
file_anchors = {}

md_files = glob.glob(os.path.join(repo_root, '*.md')) + glob.glob(os.path.join(repo_root, 'categories', '*.md'))

for filepath in md_files:
    rel_path = os.path.relpath(filepath, repo_root)
    anchors = set()
    with open(filepath) as f:
        for line in f:
            m = re.match(r'^(#{1,6})\s+(.+)', line)
            if m:
                heading_text = m.group(2).strip()
                # Remove markdown formatting from heading
                heading_text = re.sub(r'\[([^\]]+)\]\([^)]+\)', r'\1', heading_text)
                heading_text = re.sub(r'[*`]', '', heading_text)
                slug = slugify(heading_text)
                anchors.add(slug)
    file_anchors[rel_path] = anchors

# Step 2: Find all internal links and validate them
# Link patterns:
# [text](#anchor) - same file
# [text](path#anchor) - cross-file
# [text](path) - file reference without anchor

broken_links = []

for filepath in md_files:
    rel_path = os.path.relpath(filepath, repo_root)
    file_dir = os.path.dirname(rel_path)

    with open(filepath) as f:
        for line_num, line in enumerate(f, 1):
            # Find all markdown links
            for m in re.finditer(r'\[([^\]]*)\]\(([^)]+)\)', line):
                link_text = m.group(1)
                link_target = m.group(2)

                # Skip external links
                if link_target.startswith(('http://', 'https://', 'mailto:')):
                    # But check for double categories/ in GitHub URLs
                    if 'categories/categories/' in link_target:
                        broken_links.append((rel_path, line_num, link_target, "Double 'categories/' in URL"))
                    continue

                # Parse the link
                if '#' in link_target:
                    file_part, anchor = link_target.rsplit('#', 1)
                else:
                    file_part = link_target
                    anchor = None

                # Resolve file path
                if file_part:
                    target_file = os.path.normpath(os.path.join(file_dir, file_part))
                else:
                    target_file = rel_path

                # Check if target file exists
                if target_file not in file_anchors:
                    # Maybe it's a non-.md file or external
                    full_path = os.path.join(repo_root, target_file)
                    if not os.path.exists(full_path):
                        broken_links.append((rel_path, line_num, link_target, f"File not found: {target_file}"))
                    continue

                # Check anchor
                if anchor:
                    anchor_lower = anchor.lower()
                    if anchor_lower not in file_anchors[target_file]:
                        broken_links.append((rel_path, line_num, link_target, f"Anchor '#{anchor}' not found in {target_file}"))

# Step 3: Report
if broken_links:
    print(f"Found {len(broken_links)} broken internal links:\n")
    for filepath, line_num, target, reason in sorted(broken_links):
        print(f"  {filepath}:{line_num}")
        print(f"    Link: {target}")
        print(f"    Error: {reason}")
        print()
else:
    print("All internal links are valid!")
