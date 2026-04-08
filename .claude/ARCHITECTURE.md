# ARCHITECTURE - Svarstykles

*Current architecture based on repository contents as of 2026-04-08*

## System State

- The repository currently contains framework infrastructure only
- No project-specific application modules have been implemented yet
- The codebase is ready for product development but is not yet a finished app

## Detected Stack

- Python 3.13 runtime for `src/framework-core`
- Python standard library only for framework core
- Bash scripts for command routing, updates, migration, security cleanup, and Git hook installation
- Git-based workflow with project memory stored in `.claude/`

## Runtime Entry Points

- `src/framework-core/main.py`
- `.codex/commands/start.sh`
- `.codex/commands/finish.sh`
- `.codex/commands/update-check.sh`
- `.codex/commands/migration-router.sh`

## Top-Level Structure

- `.claude/` shared project memory, runtime state, logs, templates, and scripts
- `.codex/` command wrappers, utilities, hooks, contracts, and adapter files
- `src/framework-core/` Python CLI, tasks, and utilities
- `security/` shell helpers for dialogs and trigger checks
- `docs/` product and architecture notes

## Constraints

- On this machine, framework commands should use `C:\Program Files\Git\bin\bash.exe` on Windows
- `python` is available directly, while `py` launcher is not installed
- Product architecture cannot be finalized until the project goal and target stack are confirmed

## Notes

- Shared memory is stored in `.claude/` and should remain the source of truth for current project state
- The framework itself is operational and can support the next implementation phase immediately
