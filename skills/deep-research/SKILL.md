---
name: deep-research
description: Execute autonomous multi-step deep research on any topic. Searches the web, synthesizes findings, and produces structured reports with citations. Use when asked to research a topic, conduct literature review, market analysis, competitive analysis, or any task requiring comprehensive information gathering. Trigger phrases include "research", "investigate", "literature review", "market analysis", "deep dive", "综述", "调研".
---

# Deep Research Skill

Autonomous multi-step research agent that gathers, synthesizes, and reports findings with citations.

## Workflow

### Step 1: Clarify Scope
- Identify the research question / objective
- Define scope boundaries (time range, domains, depth)
- Determine output format (summary, report, comparison table)

### Step 2: Multi-Source Search
Execute 3-5 parallel web searches with varied queries:
- Broad overview query
- Specific technical/domain query
- Recent developments query (include current year)
- Contrarian/alternative viewpoint query

Use `WebSearch` for each, then `WebFetch` (or `web-to-markdown` skill) to extract key content from the most relevant results.

### Step 3: Synthesize & Cross-Reference
- Extract key findings from each source
- Identify consensus vs. conflicting views
- Note data quality and potential biases
- Build a structured outline

### Step 4: Produce Report
Structure the output as:

```
## Research: [Topic]

### Key Findings
- Finding 1 [Source]
- Finding 2 [Source]

### Analysis
[Synthesized analysis with cross-references]

### Open Questions
- Unresolved areas requiring further investigation

### Sources
- [Title](URL) — relevance note
```

## Guidelines

- **Always cite sources** — every claim must link to a source
- **Distinguish facts from opinions** — clearly label inferences
- **Note recency** — flag if sources are outdated
- **Quantify when possible** — prefer data over anecdotes
- **Acknowledge limitations** — what couldn't be verified

## Research Depth Levels

| Level | Queries | Sources | Output |
|-------|---------|---------|--------|
| Quick | 2-3 | 3-5 | 1-2 paragraphs |
| Standard | 4-6 | 5-10 | Structured report |
| Deep | 8-12 | 10-20+ | Comprehensive report with tables |

Default to **Standard** unless the user specifies otherwise.

## Special Modes

### Literature Review
- Focus on academic/arxiv sources
- Include methodology comparison
- Track citation networks

### Market Analysis
- Include market size, growth rates, key players
- SWOT or competitive matrix
- Recent funding/M&A activity

### Technical Comparison
- Feature matrix table
- Pros/cons for each option
- Recommendation with rationale
