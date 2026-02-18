# Forensic API Leak Analysis

## Description

Analyze accidentally exposed APIs in public repositories (Hex.pm, npm, PyPI, GitHub) to extract internal system information, security insights, and SEO intelligence.

**Use when:**
- Analyzing leaked API documentation
- Comparing API versions to detect removals
- Extracting internal system structures
- Identifying security implications
- Documenting findings for future reference

---

## Skills Required

- web_fetch (read remote documentation)
- exec (download packages, extract files)
- read (analyze source code)
- write (document findings)

---

## Workflow

### Phase 1: Discovery

1. Identify the exposed API package
2. Find all available versions
3. Download oldest and newest versions
4. Extract and analyze structure

### Phase 2: Analysis

1. Count total files/models
2. Identify sensitive systems (abuse, moderation, internal)
3. Extract field definitions
4. Compare versions to find removals
5. Document internal references (go/ links, etc.)

### Phase 3: Documentation

1. Create `memory/ref-[topic]-analysis.md`
2. Update `memory/index.md`
3. Create runbook if process is reusable
4. Update TODO.md with fuzzy progress

---

## Key Patterns to Look For

### SEO Intelligence
- `sourceType` fields (quality classification)
- `weight`, `locality`, `bucket` (ranking signals)
- Spam detection fields
- Anchor processing logic
- Index tier information

### Security Intelligence
- Abuse detection systems
- Moderation workflows
- User restriction logic
- Internal reference links (go/)
- ACL structures

### System Architecture
- Data models structure
- API relationships
- Internal service names
- Undocumented features

---

## Tools

```bash
# Download Hex.pm package
curl -sL "https://repo.hex.pm/tarballs/[package]-[version].tar" -o package.tar
tar -xf package.tar
tar -xzf contents.tar.gz

# Count files
find lib -name "*.ex" | wc -l

# Find sensitive terms
grep -r "abuse\|moderation\|internal" lib/ | wc -l
```

---

## Output Template

```markdown
# [API Name] Leak Analysis

ID: REF-[TOPIC]-001
Status: active
Tags: #leak #api #security #seo
Keys: leak, api, security, seo
Last reviewed: YYYY-MM-DD

## Overview
[What was exposed]

## Systems Found
[List of internal systems]

## SEO Implications
[Anchor quality signals, ranking factors]

## Security Implications
[Abuse detection, moderation workflows]

## Version Differences
[What was removed between versions]

## Sources
[URLs and downloads]
```

---

## Examples

- Google Content Warehouse: `memory/ref-google-leak-*.md`
- Analysis methodology: `memory/ref-atomic-habits-one-minute-coach-agents.md`

---

## Anti-Deuda Rules

1. Always document in `memory/`
2. Always update `memory/index.md`
3. Never leave analysis without creating reference file
4. Use fuzzy progress tracking in TODO.md
