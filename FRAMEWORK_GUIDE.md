# Working with Claude Code Starter Framework

> This project uses **Claude Code Starter Framework v4.0.2**.

## Quick Start

For a detailed Lithuanian guide, see `FRAMEWORK_GUIDE_LT.md`.

1. Open this project in terminal.
2. Launch your preferred agent:

```bash
# Option A
codex

# Option B
claude
```

3. In agent chat, type:

```text
start
```

4. At the end of your work cycle, type:

```text
/fi
```

## Agent Model

This framework supports both agents in one project:

- `CLAUDE.md` + `.claude/` for Claude Code
- `AGENTS.md` + `.codex/` for Codex

Both agents share the same memory files:

- `.claude/SNAPSHOT.md`
- `.claude/BACKLOG.md`
- `.claude/ARCHITECTURE.md`
- `.claude/ROADMAP.md`
- `.claude/DECISIONS.md`
- `.claude/RISKS.md`

## Project Memory Ownership

The agent is responsible for maintaining project memory files:

- `.claude/SNAPSHOT.md`
- `.claude/BACKLOG.md`
- `.claude/ARCHITECTURE.md`
- `.claude/ROADMAP.md`
- `.claude/IDEAS.md`
- `.claude/DECISIONS.md`
- `.claude/RISKS.md`

The user provides goals, priorities, and business decisions.
The agent keeps these files aligned with the current project state, architecture, and next steps.

If project memory files conflict with newer user instructions, the latest user instruction takes precedence.

Recommended usage:
- `SNAPSHOT.md` = current state, active focus, blockers, next step
- `BACKLOG.md` = prioritized work items and follow-ups
- `ROADMAP.md` = larger phases and milestones
- `ARCHITECTURE.md` = actual system structure and constraints
- `DECISIONS.md` = important decisions and tradeoffs
- `RISKS.md` = active risks, mitigations, and owners

## Reserved Files

The following root-level files are reserved for framework orchestration and should not be repurposed for project-specific content:

- `CLAUDE.md`
- `AGENTS.md`
- `FRAMEWORK_GUIDE.md`
- `FRAMEWORK_GUIDE_LT.md`
- `PROJECT_STARTUP_LT.md`

Use these locations instead:

- `.claude/*.md` for active project memory and current state
- `docs/` for product, domain, and long-form project documentation
- `README.md` for overview, setup, and onboarding

Recommended project documentation layout:
- `README.md` = overview and local setup
- `docs/PRODUCT.md` = goals, scope, and business context
- `docs/ARCHITECTURE_NOTES.md` = deeper technical notes
- `docs/AI_CONTEXT.md` = optional additional AI-facing context

These `docs/` files are part of the recommended starter kit and can be generated as baseline project documentation.

Recommended top-level structure:

```text
Project/
  CLAUDE.md
  AGENTS.md
  README.md
  CHANGELOG.md
  FRAMEWORK_GUIDE.md
  FRAMEWORK_GUIDE_LT.md
  PROJECT_STARTUP_LT.md
  .claude/
  .codex/
  docs/
  src/
  security/
```

## What `start` Does

- Routes migration/upgrade flow on first run if needed
- Executes cold-start protocol via shared Python core
- Checks updates and applies framework update automatically when configured
- Loads shared memory context
- Ensures core project memory files exist and can be refreshed when needed

## What `/fi` Does

- Executes completion protocol via shared Python core
- Runs security/export checks
- Runs git status/diff checks
- Returns structured completion result

## Key Paths

```text
CLAUDE.md                    # Claude adapter entry
AGENTS.md                    # Codex adapter entry
.claude/                     # Shared memory + Claude workflows
.claude/DECISIONS.md         # Decision log
.claude/RISKS.md             # Active risks and mitigations
.codex/                      # Codex workflows
src/framework-core/          # Shared runtime
security/                    # Security scripts
.claude/scripts/quick-update.sh  # Claude updater entry
.codex/commands/quick-update.sh  # Codex updater entry
```

## Notes

- Framework files and project business code are separate concerns.
- Migration and upgrade flows are additive by design.
- The agent should keep `.claude/SNAPSHOT.md`, `.claude/BACKLOG.md`, `.claude/ARCHITECTURE.md`, `.claude/ROADMAP.md`, `.claude/IDEAS.md`, `.claude/DECISIONS.md`, and `.claude/RISKS.md` current as work progresses.

## Troubleshooting

- If protocol reports crash recovery needed: resolve in `start` flow and re-run `start`.
- If update issues occur: run `bash .codex/commands/quick-update.sh` manually.
- If migration was interrupted: check `reports/*MIGRATION_REPORT.md` and rerun `start`.
