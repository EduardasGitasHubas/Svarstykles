# Commit Policy - What Can Be Committed?

**Goal:** Reduce the risk of accidentally committing sensitive, local-only, or framework runtime data to Git.

**How it works:** The agent reads this file before creating a commit and uses it as a safety policy during change review.

---

## [ERROR] Never Commit These

### 1. Internal Working Material

```text
notes/                  # Private notes or rough TODO lists
scratch/                # Temporary drafts and experiments
experiments/            # Throwaway spikes and tests
WIP_*                   # Work-in-progress files
INTERNAL_*              # Internal-only documents
DRAFT_*                 # Draft files not ready for source control
```

### 2. Runtime Logs And Dialog Data

```text
dialog/                 # Agent dialogs may contain sensitive content
.claude/logs/           # Framework execution logs
*.debug.log             # Debug logs
debug/                  # Debug artifacts
reports/                # Local bug reports and migration logs
```

### 3. Local Machine Configuration

```text
*.local.*               # Local-only configuration files
.env.local              # Local environment variables
.vscode/                # Personal IDE settings
.idea/                  # Personal IDE settings
```

### 4. Secrets And Sensitive Data

```text
secrets/                # Secrets
credentials/            # Credentials
*.key                   # Private keys
*.pem                   # Certificates
.production-credentials # Production credentials
backup/                 # Backup files
```

---

## [OK] Usually Safe To Commit

### 1. Source Code

```text
src/                    # Source code
lib/                    # Libraries
tests/                  # Tests
```

### 2. Public Documentation

```text
README.md               # Project overview
CHANGELOG.md            # Version history
LICENSE                 # License file
docs/                   # Shared project documentation
```

### 3. Project Configuration

```text
package.json            # npm config
tsconfig.json           # TypeScript config
.gitignore              # Git ignore rules
pyproject.toml          # Python project config
requirements.txt        # Python dependencies
```

---

## [WARN] Requires Review Before Commit

- New directories that are not covered by the safe lists above
- File names containing `api-key`, `password`, `secret`, or `prod`
- Very large generated files or data exports
- Files that look like logs, backups, or local snapshots

---

## [TOOL] Project-Specific Rules

Add project-specific exclusions below when needed:

```markdown
## [ERROR] Never Commit ({{PROJECT_NAME}})

# Add folders or file patterns specific to this project.
# Example:
# business-plans/
# internal-docs/
```

---

**Edit this file to match the real safety rules of your project before relying on automated commit approval.**
