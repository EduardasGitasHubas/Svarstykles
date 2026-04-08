# ARCHITECTURE NOTES - Svarstykles

*Long-form technical notes that do not fit into ARCHITECTURE.md*

## How To Use

- Capture deeper reasoning, tradeoffs, and implementation notes here.
- Keep `ARCHITECTURE.md` concise and use this file for extended detail.

## Notes

### Framework Runtime

- Context: Current repository contents
- Observation: The repository currently holds framework infrastructure and shared project memory, but no product-specific application code
- Implication: The next meaningful technical decision is stack selection for the real product, not framework repair

### Windows Execution Path

- Context: Local development environment
- Observation: `python` is available directly, while shell-based framework commands work reliably through `C:\Program Files\Git\bin\bash.exe`
- Implication: Follow the documented Windows routing from `AGENTS.md` for consistent command execution
