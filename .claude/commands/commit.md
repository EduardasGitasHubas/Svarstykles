---
description: Создать git commit с правильным сообщением
---

Создай git commit следуя лучшим практикам.

**ВАЖНО: НЕ используй git add . бездумно!**

## Процесс:

### 1. Анализ изменений
Выполни параллельно:
- `git status` - посмотри все измененные файлы
- `git diff` - посмотри unstaged изменения
- `git diff --staged` - посмотри staged изменения
- `git log --oneline -n 5` - посмотри последние коммиты для стиля

### 2. Проверь что коммитить нельзя
[ERROR] НЕ добавляй в коммит:
- `.env` или `.env.local` (секреты!)
- `node_modules/`
- `dist/`, `build/`, `.next/` (build артефакты)
- Файлы с секретами (credentials.json, secrets.yaml и т.д.)
- Временные файлы (*.log, *.tmp, .DS_Store)

[WARN] Если пользователь явно просит закоммитить эти файлы - предупреди его о рисках!

### 3. Добавь нужные файлы
Добавляй файлы **по отдельности** или группами, НЕ `git add .`:
```bash
git add path/to/file1.ts path/to/file2.ts
```

Или по паттерну:
```bash
git add src/**/*.ts
```

### 4. Составь commit message

**Формат:**
```
<type>: <краткое описание> (до 50 символов)

<детальное описание - ПОЧЕМУ, а не ЧТО>
- Причина изменения
- Какую проблему решает
- Важные детали

[BOT] Generated with [Claude Code](https://claude.com/claude-code)

Co-Authored-By: Claude <noreply@anthropic.com>
```

**Types:**
- `feat`: новая функциональность
- `fix`: исправление бага
- `refactor`: рефакторинг без изменения функциональности
- `docs`: документация
- `style`: форматирование, точки с запятой
- `test`: добавление тестов
- `chore`: обновление зависимостей, настройка CI

**Примеры хороших сообщений:**
```
feat: add user authentication with JWT

Implement JWT-based authentication to secure API endpoints.
- Add login/logout endpoints
- Create auth middleware for protected routes
- Store tokens in httpOnly cookies for security

[BOT] Generated with [Claude Code](https://claude.com/claude-code)

Co-Authored-By: Claude <noreply@anthropic.com>
```

```
fix: prevent memory leak in useEffect cleanup

Users reported app slowdown after long sessions. Root cause
was missing cleanup in dashboard useEffect hook.
- Add cleanup function to WebSocket subscription
- Clear intervals on component unmount

[BOT] Generated with [Claude Code](https://claude.com/claude-code)

Co-Authored-By: Claude <noreply@anthropic.com>
```

### 5. Создай коммит
Используй HEREDOC для правильного форматирования:

```bash
git commit -m "$(cat <<'EOF'
<type>: <краткое описание>

<детальное описание>

[BOT] Generated with [Claude Code](https://claude.com/claude-code)

Co-Authored-By: Claude <noreply@anthropic.com>
EOF
)"
```

### 6. Проверь результат
```bash
git log -1 --stat
```

## [WARN] Pre-commit hook
Если коммит провалился из-за pre-commit hook:
1. Посмотри какие изменения сделал hook
2. Если hook только отформатировал код - сделай amend:
   ```bash
   git add <измененные файлы>
   git commit --amend --no-edit
   ```

## [LOCK] Security check
Перед коммитом ВСЕГДА проверь:
- [ ] Нет hardcoded секретов (API keys, passwords, tokens)
- [ ] .env файлы в .gitignore
- [ ] Нет конфиденциальных данных в логах/комментариях
- [ ] Используются environment variables для секретов

## [CLIPBOARD] Checklist
- [ ] `git status` - проверил изменения
- [ ] `git diff` - понимаю что изменил
- [ ] Проверил стиль последних коммитов
- [ ] Добавил ТОЛЬКО нужные файлы (не `git add .`)
- [ ] Проверил на секреты
- [ ] Создал осмысленное сообщение (why, not what)
- [ ] Добавил Co-Authored-By: Claude
- [ ] `git log -1` - проверил результат

## [NO] НЕ делай:
- [ERROR] `git add .` без проверки что добавляешь
- [ERROR] Коммит .env файлов
- [ERROR] Расплывчатые сообщения ("fix", "update", "changes")
- [ERROR] Коммит закомментированного кода
- [ERROR] Коммит TODO комментариев без контекста
- [ERROR] `--no-verify` (пропуск hooks) без явного указания пользователя

**Если пользователь не указал что коммитить - спроси его!**
