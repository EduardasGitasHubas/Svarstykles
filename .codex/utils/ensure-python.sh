#!/bin/bash
# Prepend .codex/bin to PATH so the python shim is always found first.
# The shim handles WSL (python.exe interop) and Git Bash (AppData scan).
_ENSURE_PY_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
export PATH="$_ENSURE_PY_DIR/../bin:$PATH"
