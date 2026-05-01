# TianYuanDing (天元鼎) — The Alchemy Furnace

> Turn scattered information "imps" into structured "elixir pills" — a personal knowledge system framework for serious business operators.

---

## What is this

TianYuanDing is a **forkable personal knowledge system template + automation Skills toolkit** that helps you build your own private fact database, enabling any AI tool (Claude, ChatGPT, Gemini…) to work with your real context.

Inspired by the TianYuanDing (Celestial Cauldron) from the animated film *Ne Zha 2* — scattered imps (raw information) are thrown into the cauldron and refined into standardized, high-purity elixir pills (structured facts).

**For whom:** People who analyze documents, manage long-cycle projects, make investment decisions, and weigh cross-domain trade-offs — your pain point isn't that AI isn't smart enough, it's that AI can't remember things.

**Not for:** If you just need AI to write emails, make slides, or generate images — you don't need this system.

## Core Philosophy

```
Signal ocean → [Manual filter] → Imp Storage (01_raw) → [AI processing] → Alchemy Workshop (02_synthesis)
                                                                            ↓
                                                          [Human approval] → Elixir Vault (03_baseline)
                                                                            ↓
                                                          [Any AI consumes] → Consumer Layer (AI tools)
```

Three iron rules:
1. **Raw materials are immutable** — `01_raw/` is never modified, preserving the full evidence chain
2. **Facts require approved writes** — every change to `03_baseline/` must be personally confirmed
3. **AI is a tool, not the master** — AI stokes the furnace, but you decide which pills leave the cauldron

## Project Structure

```
tianyuanding-skills/
├── README.md              ← Chinese version
├── README_EN.md           ← You are here (English)
├── template/              ← Four-layer directory template (fork and fill with your content)
│   ├── 00_system/         ← System governance rules
│   ├── 01_raw/            ← Raw layer (immutable)
│   ├── 02_synthesis/      ← Processing layer (AI work products)
│   ├── 03_baseline/       ← Knowledge layer (core: approved facts)
│   └── 99_workspace/      ← Temporary workspace
├── skills/                ← Cowork automation Skills (installable)
│   ├── daily-brief/       ← Morning daily briefing
│   ├── weekly-sweep/      ← Weekly maintenance scan
│   ├── monthly-audit/     ← Monthly deep audit
│   ├── git-backup/        ← Scheduled Git backup
│   └── dreaming/          ← Nightly review & memory consolidation
└── docs/                  ← Architecture documentation
    ├── ARCHITECTURE.md    ← Four-layer architecture deep dive
    ├── SETUP.md           ← Installation & configuration guide
    └── FAQ.md             ← Frequently asked questions
```

## Quick Start

### 1. Fork and clone

```bash
git clone https://github.com/duanyu119/tianyuanding-skills.git my-brain
cd my-brain
```

### 2. Initialize your knowledge base

```bash
cp -r template/ ~/Documents/MyBrain/
cd ~/Documents/MyBrain/
git init && git add . && git commit -m "init: TianYuanDing skeleton"
```

### 3. Configure AI project instructions

Copy the content from `template/00_system/PROJECT_INSTRUCTIONS.md` into your AI tool's project settings (Claude Desktop → Settings → Projects → Select folder → Project Instructions).

### 4. Install Skills (optional)

Copy skill folders to your Cowork skills directory:

```bash
cp -r skills/* ~/.claude/skills/
```

### 5. Start using

Begin with ONE sub-domain. Do not spread across all areas at once. Suggested flow:
1. Pick your most painful topic (e.g., an ongoing complex project)
2. Drop 3-5 related raw files into `01_raw/`
3. Have AI do the first structured extraction
4. Approve and write to `03_baseline/`
5. Run one cycle of daily brief, experience the effect

## Design Principles

| Principle | Explanation |
|-----------|-------------|
| Local-first | Data physically lives on your machine, no cloud dependency |
| Vendor-agnostic | markdown + git; works with Claude today, GPT tomorrow |
| Human-in-the-loop | AI proposes, human decides. Wrong facts are 100x worse than blanks |
| Boring & stable | No fancy tools. Still works in 20 years |
| Progressive | Start with one domain, expand later. Perfectionism is the enemy |
| Auditable | Full change history, rollback, traceability |

## Four-Layer Architecture

See [docs/ARCHITECTURE.md](docs/ARCHITECTURE.md) for details.

| Layer | Directory | AI writable | Human approval | Purpose |
|-------|-----------|-------------|----------------|---------|
| Raw | `01_raw/` | Forbidden | — | Original evidence, immutable |
| Synthesis | `02_synthesis/` | Yes | No | AI work products, overwritable |
| Baseline | `03_baseline/` | Proposal only | Yes | Approved structured facts |
| System | `00_system/` | Yes | No | Governance rules & status |

## Maintenance Rhythm

| Frequency | Time | What | Skill |
|-----------|------|------|-------|
| Daily | 5 min | Read brief, decide updates | `daily-brief` |
| Weekly | 30 min | Stale fields, new raw files, consistency | `weekly-sweep` |
| Monthly | 1-2 hrs | Coverage, confidence audit, tier tuning | `monthly-audit` |
| Quarterly | Half day | Strategic review, architecture changes | Manual |

## License

MIT License — free to use, modify, and distribute.

## Acknowledgments

Methodology inspired by: PARA method (Tiago Forte), Zettelkasten, audit discipline's "periodic reconciliation" logic, and the TianYuanDing from *Ne Zha 2: The Devil BoyErta the Sea*.

---

> "The furnace can be replaced, but your ingredient library and alchemical expertise are yours to keep."
