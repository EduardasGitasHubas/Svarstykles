---
description: Создать Pull Request с правильным описанием
---

Создай Pull Request используя GitHub CLI (`gh`).

**ВАЖНО: Анализируй ВСЕ коммиты, не только последний!**

## Процесс:

### 1. Анализ текущего состояния ветки

Выполни параллельно эти команды:
```bash
# Проверь текущую ветку и статус
git status

# Посмотри unstaged и staged изменения
git diff
git diff --staged

# Проверь remote tracking
git branch -vv

# Посмотри ВСЕ коммиты от base branch (обычно main)
git log main..HEAD --oneline

# Посмотри полный diff от base branch
git diff main...HEAD --stat
```

### 2. Определи base branch
Обычно это `main` или `master`. Проверь:
```bash
git remote show origin | grep "HEAD branch"
```

### 3. Анализируй ВСЕ изменения

**КРИТИЧНО:** Не смотри только последний коммит! Проанализируй:
- Все коммиты с момента divergence от main
- Весь diff между base branch и HEAD
- Все измененные файлы

```bash
# Полный список измененных файлов
git diff main...HEAD --name-status

# Детальный diff всех изменений
git diff main...HEAD
```

### 4. Составь PR описание

**Формат:**
```markdown
## Summary
[1-3 bullet points описывающие ЧТО было сделано]

## Why (Мотивация)
[ПОЧЕМУ эти изменения необходимы - бизнес-контекст]

## What Changed
[Детальное описание изменений по категориям]

### Added
- [Новая функциональность]

### Changed
- [Изменения в существующей функциональности]

### Fixed
- [Исправленные баги]

### Security
- [Изменения связанные с безопасностью]

## Technical Details
[Технические детали для ревьюеров]
- Архитектурные решения
- Важные изменения в API/схеме БД
- Performance implications

## Test Plan
- [ ] Unit tests pass (`make test`)
- [ ] Type checking pass (`make typecheck`)
- [ ] Linting pass (`make lint`)
- [ ] Manual testing: [опиши что протестировал]
- [ ] Security check (`make security`)
- [ ] Tested edge cases: [какие]

## Screenshots/Demo
[Если есть UI изменения - добавь скриншоты]

## Breaking Changes
[Если есть breaking changes - опиши их здесь]
- [ ] Documentation updated
- [ ] Migration guide provided

## Checklist
- [ ] Code follows project style guide
- [ ] Documentation updated (README, ARCHITECTURE, etc.)
- [ ] BACKLOG.md updated with implementation status
- [ ] Security best practices followed (see SECURITY.md)
- [ ] No secrets in code
- [ ] All tests passing

[BOT] Generated with [Claude Code](https://claude.com/claude-code)
```

### 5. Push изменения (если нужно)

Проверь нужно ли push:
```bash
git status
```

Если нужно:
```bash
# Для новой ветки
git push -u origin HEAD

# Для существующей
git push
```

### 6. Создай PR с gh CLI

Используй HEREDOC для правильного форматирования:

```bash
gh pr create --title "<тип>: <краткое описание>" --body "$(cat <<'EOF'
## Summary
- [bullet point 1]
- [bullet point 2]

## Why
[Мотивация изменений]

## What Changed
[Детальное описание]

## Technical Details
[Технические детали]

## Test Plan
- [ ] Unit tests pass
- [ ] Type checking pass
- [ ] Linting pass
- [ ] Manual testing completed

[BOT] Generated with [Claude Code](https://claude.com/claude-code)
EOF
)"
```

**Title format:**
- `feat: Add user authentication`
- `fix: Prevent memory leak in dashboard`
- `refactor: Simplify API error handling`
- `docs: Update deployment guide`

### 7. Проверь результат
```bash
gh pr view --web
```

## [LOCK] Security Checklist (перед созданием PR)
- [ ] Нет hardcoded secrets в коде
- [ ] .env файлы не закоммичены
- [ ] Все секреты в environment variables
- [ ] Input validation на месте
- [ ] Output sanitization реализован
- [ ] SQL queries параметризованы
- [ ] Authentication/Authorization проверены
- [ ] `npm audit` не показывает критических уязвимостей

## [CLIPBOARD] Pre-PR Checklist
- [ ] Все коммиты осмысленные (не "wip", "fix", "update")
- [ ] Squash мелких fixup коммитов (если нужно)
- [ ] Ветка обновлена с main (rebase если нужно)
- [ ] Все тесты проходят локально
- [ ] Документация обновлена
- [ ] BACKLOG.md обновлен

## [NO] НЕ делай:
- [ERROR] Анализировать только последний коммит (смотри ВСЕ коммиты!)
- [ERROR] Создавать PR с failing tests
- [ERROR] Игнорировать TypeScript ошибки
- [ERROR] Забывать обновить документацию
- [ERROR] Force push в shared ветку
- [ERROR] PR с закомментированным кодом
- [ERROR] Расплывчатое описание PR

## [IDEA] Tips:
1. **Для больших PR:** разбей на несколько smaller PRs
2. **Для hotfix:** используй флаг `--label "hotfix"`
3. **Для draft PR:** используй флаг `--draft`
4. **Assign reviewers:** `--reviewer @username`
5. **Add to project:** `--project "Project Name"`

## Примеры хороших PR:

### Пример 1: Feature PR
```bash
gh pr create --title "feat: Add user dashboard with analytics" --body "$(cat <<'EOF'
## Summary
- Implement user dashboard with key metrics
- Add analytics charts for user activity
- Create responsive layout for mobile

## Why
Users requested a centralized view of their activity and statistics.
Dashboard provides better user engagement and data visibility.

## What Changed
### Added
- Dashboard component with metrics cards
- Chart.js integration for analytics
- Mobile-responsive layout
- API endpoints for dashboard data

## Technical Details
- Uses Chart.js for data visualization
- Implements lazy loading for performance
- Adds new /api/dashboard endpoint with proper auth
- All data queries optimized with indexes

## Test Plan
- [x] Unit tests pass (100% coverage on new code)
- [x] Type checking pass
- [x] Tested on mobile (iOS/Android)
- [x] Tested with 1000+ data points (performance OK)
- [x] Security audit completed

[BOT] Generated with [Claude Code](https://claude.com/claude-code)
EOF
)"
```

### Пример 2: Bugfix PR
```bash
gh pr create --title "fix: Resolve memory leak in WebSocket connection" --body "$(cat <<'EOF'
## Summary
- Fix memory leak in WebSocket cleanup
- Add proper event listener cleanup

## Why
Users reported browser slowdown after 30+ minutes of use.
Investigation revealed WebSocket listeners not being cleaned up.

## What Changed
### Fixed
- Add cleanup function to useWebSocket hook
- Remove event listeners on unmount
- Close connections properly

## Technical Details
- Root cause: missing cleanup in useEffect
- Added beforeunload listener cleanup
- Tested with Chrome DevTools memory profiler

## Test Plan
- [x] Memory profiler shows no leaks after 2 hours
- [x] All existing tests pass
- [x] Manually tested reconnection scenarios

[BOT] Generated with [Claude Code](https://claude.com/claude-code)
EOF
)"
```

**После создания PR выведи URL, чтобы пользователь мог его открыть!**
