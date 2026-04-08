# Codex Adapter Entry

## Purpose

This file is the Codex entry orchestrator for projects that use the framework.
It runs Codex workflows on top of shared project memory.

## Shared State

Primary memory files:
- `.claude/SNAPSHOT.md`
- `.claude/BACKLOG.md`
- `.claude/ARCHITECTURE.md`
- `.claude/ROADMAP.md`
- `.claude/DECISIONS.md`
- `.claude/RISKS.md`
- `CHANGELOG.md` (optional, if project tracks release notes)

Codex and Claude use the same state contract.

## Project Memory Ownership

The agent is responsible for maintaining project memory files, including:
- `.claude/SNAPSHOT.md`
- `.claude/BACKLOG.md`
- `.claude/ARCHITECTURE.md`
- `.claude/ROADMAP.md`
- `.claude/IDEAS.md`
- `.claude/DECISIONS.md`
- `.claude/RISKS.md`

The user provides goals, priorities, and business decisions.
The agent updates these files to reflect current project state, progress, architecture, and next steps.

If project memory files conflict with newer user instructions, the latest user instruction takes precedence.

Recommended usage:
- `SNAPSHOT.md` = current state, active focus, blockers, next step
- `BACKLOG.md` = prioritized work items and follow-ups
- `ROADMAP.md` = larger phases and milestones
- `ARCHITECTURE.md` = actual system structure and constraints
- `DECISIONS.md` = important decisions and tradeoffs
- `RISKS.md` = active risks, mitigations, and owners

## Reserved Files

The following root-level files are reserved for framework orchestration and should not be reused for project-specific content:
- `CLAUDE.md`
- `AGENTS.md`
- `FRAMEWORK_GUIDE.md`
- `FRAMEWORK_GUIDE_LT.md`
- `PROJECT_STARTUP_LT.md`

Project-specific documentation should live in:
- `.claude/*.md` for shared project memory and active state
- `docs/` for product, domain, or team documentation
- `README.md` for general project introduction and setup

Recommended project documentation layout:
- `README.md` = project overview and local setup
- `docs/PRODUCT.md` = product goals and scope
- `docs/ARCHITECTURE_NOTES.md` = deeper technical notes
- `docs/AI_CONTEXT.md` = optional extra project context for agents

## Command Routing

### `start`
Run (Windows - use Git Bash to avoid WSL sandbox restriction):
- `& 'C:\Program Files\Git\bin\bash.exe' .codex/commands/start.sh`

Fallback (Linux / macOS):
- `bash .codex/commands/start.sh`

### `/fi`
Run (Windows - use Git Bash to avoid WSL sandbox restriction):
- `& 'C:\Program Files\Git\bin\bash.exe' .codex/commands/fi.sh`

Fallback (Linux / macOS):
- `bash .codex/commands/fi.sh`

### migration detection
Run:
- `& 'C:\Program Files\Git\bin\bash.exe' .codex/commands/migration-router.sh`

### version check
Run:
- `& 'C:\Program Files\Git\bin\bash.exe' .codex/commands/update-check.sh`

## Core Runtime

Shared command entry points:
- `py src/framework-core/main.py cold-start`
- `py src/framework-core/main.py completion`

Output contract:
- `.codex/contracts/core-cli-contract.md`
