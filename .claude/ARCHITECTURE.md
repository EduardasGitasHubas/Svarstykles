# ARCHITECTURE - Pradzia

*Generated from detected project artifacts*

## Detected Stack

- Stack requires manual confirmation

## Top-Level Structure

- `.gitignore`
- `AGENTS.md`
- `CLAUDE.md`
- `FRAMEWORK_GUIDE.md`
- `init-project.sh`
- `security/`
- `src/`

## Key Topics

- Framework Core Dependencies
- Minimal dependencies - use stdlib where possible
- No external dependencies needed!
- All functionality uses Python stdlib:
- - json, subprocess, pathlib, concurrent.futures, etc.

## Notes

- Shared memory is stored in `.claude/`.
- Runtime entry points are in `CLAUDE.md` and `AGENTS.md`.
- Shared execution core is `src/framework-core/`.
