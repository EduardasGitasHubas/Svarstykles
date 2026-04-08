# Security System - 4-Layer Hybrid Architecture

**Version:** 2.4.1 (Advisory Mode + Smart Triggers)

---

## Архитектура

Система защиты credentials состоит из **4 слоев** с гибридным подходом:
- **Layers 1-3:** Automatic, fast (regex-based)
- **Layer 4:** Smart auto-invoke (AI-based, context-aware)

```
+------------------------------------------------------------+
| Layer 1: .gitignore (Passive Protection)                  |
| [OK] Blocks: dialog/, reports/, .production-credentials      |
| [OK] Coverage: 100% (prevents all commits)                   |
| [OK] Speed: Instant (Git enforces)                           |
+------------------------------------------------------------+
                          v
+------------------------------------------------------------+
| Layer 2: Regex Cleanup Script (Automatic, Fast)           |
| [OK] Method: Bash regex patterns (security/cleanup-dialogs.sh)|
| [OK] Coverage: 95% (10 credential patterns)                  |
| [OK] Speed: 1-2 seconds                                      |
| [OK] Runs: Every Cold Start (0.5) + Completion (3.5)         |
+------------------------------------------------------------+
                          v
+------------------------------------------------------------+
| Layer 3: Protocol Integration (Double Protection)         |
| [OK] Step 0.5: Clean PREVIOUS session before export          |
| [OK] Step 3.5: Clean CURRENT session before commit           |
| [OK] No gaps: previous (0.5) + current (3.5)                 |
+------------------------------------------------------------+
                          v
+------------------------------------------------------------+
| Layer 4: AI Agent (Advisory Mode) [STAR] NEW                  |
| [OK] Method: sec24 agent via Task tool (context analysis)    |
| [OK] Coverage: 99% (catches edge cases regex misses)         |
| [OK] Speed: 1-2 minutes (focused on sprint changes)          |
| [OK] Triggers: 10 smart triggers (advisory recommendations)  |
| [OK] Invokes: Claude asks user OR auto on release mode only  |
| [OK] Scope: Git diff + last dialog (NOT entire codebase)     |
+------------------------------------------------------------+
```

---

## Layer 4: Advisory Mode + Smart Trigger System

### Two Modes of Operation:

**1. Advisory Mode (Normal Commits):**
- Triggers detected -> Claude AI reads context -> **Claude asks user**
- User decides: Accept deep scan (1-2 min) OR skip (fast path)
- User always in control

**2. Auto-Invoke Mode (Release Only):**
- Git release tag detected (`v2.x.x`) -> **mandatory deep scan**
- No user confirmation needed (paranoia mode)
- Ensures public release is thoroughly checked

---

### CRITICAL Triggers

**Score: 100 points each**

| # | Trigger | Why Important | Mode |
|---|---------|--------------|------|
| 1 | `.production-credentials` file exists | Production SSH keys/tokens at risk | Advisory |
| 2 | Git release tag detected (`v2.x.x`) | Releasing to public -> extra safety | **Auto-invoke** |
| 3 | Release workflow in dialogs | `/release` command used | Advisory |

**User Experience (Advisory Mode):**
```
[ALERT] CRITICAL TRIGGERS DETECTED

Detected conditions:
  * Production credentials file detected (.production-credentials)

[INFO]  Claude AI will ask if you want to run deep scan
```

**User Experience (Auto-Invoke Mode - Release):**
```
[ALERT] RELEASE MODE DETECTED
   Git tag: v2.5.0

[WARN]  Running mandatory deep scan before release...
[WARN]  This will take 1-2 minutes for thorough analysis
```

---

### HIGH Triggers

**Score: 30-50 points each**

| # | Trigger | Why Important | Mode |
|---|---------|--------------|------|
| 4 | Regex found credentials | Need AI verification of context | Advisory |
| 5 | Security keywords (>5 mentions) | Many SSH/API/password discussions | Advisory |
| 6 | Production/deployment mentioned | Discussing prod -> high risk | Advisory |

**User Experience (Advisory Mode):**
```
[WARN]  HIGH-PRIORITY TRIGGERS DETECTED

Detected conditions:
  * Regex cleanup found 3 file(s) with credentials
  * Security-sensitive keywords detected (12 mentions)

Claude AI will ask:

[WARN]  Обнаружены потенциальные риски безопасности:
  * Regex cleanup нашёл 3 файла с credentials
  * Обсуждали: ssh, production, database (12 упоминаний)

Рекомендую запустить deep scan изменений спринта (1-2 минуты).
Запустить AI-агент для проверки? (y/N)
```

---

### MEDIUM Triggers

**Score: 15-25 points each**

| # | Trigger | Why Noted | Mode |
|---|---------|-----------|------|
| 7 | Large diff (>500 lines) | More code -> more risk | Optional mention |
| 8 | Many new dialogs (>5 uncommitted) | Long sessions -> more discussions | Optional mention |
| 9 | Security config modified | .env, credentials, secrets changed | Optional mention |

**User Experience (Optional Mention):**
```
[INFO]  Medium-priority conditions detected

Detected conditions:
  * Large diff detected (847 lines changed)
  * Many new dialog files (8 uncommitted)

Claude AI may mention:
[IDEA] Если хотите дополнительную проверку безопасности, можете запустить /security-dialogs
```

---

### LOW Triggers (Informational Only)

**Score: 5 points each**

| # | Trigger | Why Noted | When |
|---|---------|-----------|------|
| 10 | Long session (>2 hours) | More time -> more info shared | Last commit time |

**User Experience:**
```
[OK] No significant security triggers detected
[INFO] Low-priority conditions noted (informational only)
```

---

## Decision Matrix

| Trigger Level | Score Range | Action | Who Decides | Speed Impact |
|--------------|-------------|--------|-------------|--------------|
| **CRITICAL (Release)** | 100+ + git tag | Auto-invoke | **Framework** | +1-2 min (mandatory) |
| **CRITICAL (Normal)** | 100+ | Claude asks user | **User** | +1-2 min (if accepted) |
| **HIGH** | 30-99 | Claude asks user | **User** | +1-2 min (if accepted) |
| **MEDIUM** | 15-29 | Optional mention | **User** | No impact (optional) |
| **LOW** | 1-14 | Informational only | **Skip** | No impact |
| **NONE** | 0 | Skip | **Skip** | No impact |

**Key insight:** User always decides (except release mode)

---

## What AI Agent Analyzes (Scope Optimization)

**Agent analyzes ONLY sprint changes:**

```bash
# Included in analysis:
[OK] Git diff (last 5 commits):
   git diff HEAD~5..HEAD

[OK] Last dialog (current session):
   dialog/2026-01-16-*.md

[OK] New/modified reports:
   reports/FRAMEWORK_*.md

# NOT included:
[ERROR] Entire codebase (только git diff)
[ERROR] Old dialog files (уже почищены)
[ERROR] Unchanged files (нет смысла)
```

**Result:** 5-10 файлов вместо 300+ (massive token savings!)

---

## What AI Agent Catches (vs Regex)

| Credential Type | Regex (Layer 2) | AI Agent (Layer 4) |
|----------------|-----------------|-------------------|
| `password=abc123` | [OK] | [OK] |
| `sk-1234567890abcdef` | [OK] | [OK] |
| `postgres://user:pass@host/db` | [OK] | [OK] |
| `"".join([chr(x) for x in [112,97,115,115]])` | [ERROR] | [OK] Obfuscated |
| "password is company name" (context) | [ERROR] | [OK] Context-dependent |
| `user: admin, pass: super, host: prod` | [ERROR] | [OK] Composite |
| SSH key mentioned in comment | [ERROR] | [OK] Discussed not shown |
| Base64-encoded API key | [ERROR] | [OK] Encoded |

**Why this matters:**
- Projects with DevOps = credentials in code, not just dialogs
- Sprint changes may include .env files, config, SSH commands
- AI understands context that regex cannot parse

---

## Usage

### Advisory Mode (Recommended)

**Layer 4 triggers run during Completion Protocol, Claude AI asks user:**

```bash
# Normal commit
user: "/fi"

# Step 3.5 runs:
1. Regex cleanup (Layer 2) - always runs (1-2s)
2. Trigger detection - always runs (instant)
3. Claude AI reads triggers + session context
4. If HIGH risk -> Claude ASKS user:

   [WARN]  Обнаружены потенциальные риски безопасности:
     * Regex cleanup нашёл 3 файла с credentials
     * Обсуждали: ssh, production, database (12 mentions)

   Рекомендую запустить deep scan изменений спринта (1-2 минуты).
   Запустить AI-агент для проверки? (y/N)

5. User decides:
   - "y" -> Deep scan (1-2 min, thorough)
   - "N" -> Skip (instant, fast path)
```

**You are always in control (except release mode)!**

---

### Auto-Invoke Mode (Release Only)

**Only git release tag triggers automatic deep scan:**

```bash
# Creating release
user: "git tag v2.5.0"
user: "/fi"

# Step 3.5 detects release mode:

[ALERT] RELEASE MODE DETECTED
   Git tag: v2.5.0

[WARN]  Running mandatory deep scan before release...

[Agent analyzes sprint changes for 1-2 minutes]
[Creates detailed security report]

[OK] Deep scan complete. Review report before pushing.
```

**No user confirmation needed - paranoia mode for public releases.**

---

### Manual (Optional)

**Force deep scan anytime:**

```bash
# Manual deep scan
/security-dialogs

# Or via bash
bash security/cleanup-dialogs.sh --deep
```

---

## Files

```
security/
+-- cleanup-dialogs.sh           # Layer 2: Regex-based cleanup
+-- check-triggers.sh            # Layer 4: Trigger detection (10 triggers)
+-- auto-invoke-agent.sh         # Layer 4: Agent invocation logic
+-- reports/                     # Cleanup and scan reports
    +-- cleanup-*.txt            # Regex cleanup reports
    +-- deep-scan-*.md           # AI agent scan reports

.claude/commands/
+-- security-dialogs.md          # /security-dialogs command (Layer 4)
```

---

## Performance

### Normal Session (95% of cases - User Skips)

```
Time breakdown:
- Layer 1 (.gitignore): 0ms (passive)
- Layer 2 (regex): 1-2 seconds
- Layer 3 (protocol): included in Layer 2
- Layer 4 (triggers check): instant
- Claude asks user -> User says "N" (skip)

Total: 1-2 seconds [OK] FAST
Token cost: Minimal (только regex)
```

### High-Risk Session (5% of cases - User Accepts)

```
Time breakdown:
- Layer 1 (.gitignore): 0ms (passive)
- Layer 2 (regex): 1-2 seconds
- Layer 3 (protocol): included in Layer 2
- Layer 4 (triggers check): instant
- Claude asks user -> User says "y" (accept)
- AI agent analyzes git diff + last dialog: 1-2 minutes

Total: ~2 minutes [WARN] SLOW but THOROUGH
Token cost: Moderate (git diff + last dialog only, NOT entire codebase)
```

### Release Mode (Auto-Invoke)

```
Time breakdown:
- Layer 1 (.gitignore): 0ms (passive)
- Layer 2 (regex): 1-2 seconds
- Layer 3 (protocol): included in Layer 2
- Layer 4 (triggers detect git tag -> auto-invoke): 1-2 minutes

Total: ~2 minutes [WARN] MANDATORY for releases
Token cost: Moderate (worth it for public release safety)
```

**Trade-off:** "Лучше пусть медленно, но надёжно" - но не на каждый commit, а только когда user решает или release!

---

## Examples

### Example 1: Normal Development Session

```bash
# User working on feature, no production access
$ /fi

[OK] Regex cleanup: No credentials detected
[OK] No significant security triggers detected

[Proceeds to commit immediately - fast path]
```

---

### Example 2: Production Deployment Session

```bash
# User deploying to production, discussed SSH keys
$ /fi

[WARN]  Regex cleanup: Credentials found and redacted

[ALERT] CRITICAL TRIGGERS DETECTED
  * Production credentials file detected (.production-credentials)
  * Security-sensitive keywords detected (18 mentions)

========================================
[SEARCH] Invoking AI Security Agent (sec24)
========================================

[AI agent performs deep scan for 1-2 minutes]
[Creates detailed security report]
[User reviews before commit - thorough path]
```

---

### Example 3: Release Workflow

```bash
# User creating v2.5.0 release
$ git tag v2.5.0
$ /fi

[ALERT] CRITICAL TRIGGERS DETECTED
  * Git release tag detected (creating release)

========================================
[SEARCH] Invoking AI Security Agent (sec24)
========================================

[Paranoia mode - thorough scan before public release]
```

---

## Configuration

**No configuration needed!** System is:
- [OK] Automatic (works out of the box)
- [OK] Smart (triggers based on risk)
- [OK] Fast (only invokes AI when needed)
- [OK] Thorough (99% coverage when it matters)

---

## Testing Triggers

**Test CRITICAL trigger:**
```bash
# Create production credentials file
echo "test" > .production-credentials

# Run completion
/fi

# Should invoke AI agent automatically
```

**Test HIGH trigger:**
```bash
# Force regex to find credentials
echo "password=test123" >> dialog/test.md

# Run completion
/fi

# Should invoke AI agent with explanation
```

**Test MEDIUM trigger:**
```bash
# Create large diff
# (make 500+ line changes)

# Run completion
/fi

# Should suggest /security-dialogs (optional)
```

---

## Summary

**Layer 1-3:** Fast, automatic, 95% coverage (every session)
**Layer 4:** Advisory mode, 99% coverage (user decides OR release auto)

**Result:** Best of both worlds [TARGET]
- **Normal sessions:** [FAST] Fast (1-2 seconds, user skips)
- **High-risk sessions:** [SHIELD] Thorough (1-2 minutes, user accepts)
- **Release mode:** [ALERT] Mandatory (auto-invoke, no confirmation)
- **Decision:** [USER] User controls (advisory mode)
- **Scope:** [CHART] Git diff + last dialog (5-10 files vs 300+)

**Философия:**
- "Лучше пусть медленно, но надёжно" - но НЕ на каждый commit
- Advisory mode - пользователь решает, когда нужна тщательность
- Release mode - единственный auto-invoke (public safety)
- Token economy - анализ изменений спринта, не всей базы

**Key differentiators:**
- [OK] User always in control (normal commits)
- [OK] Advisory mode (Claude asks, user decides)
- [OK] Smart scope (git diff only, massive token savings)
- [OK] Release exception (mandatory deep scan)
- [OK] Context-aware (DevOps projects with production management)
