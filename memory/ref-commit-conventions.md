# Commit Message Conventions

ID: REF-COMMIT-001
Tags: #git #commits #conventions #workflow
Keys: git, commit, conventions, workflow, messages
Last reviewed: 2026-02-20

---

## Formato Estándar

```
<tipo>(<scope>): <descripción corta>

[cuerpo opcional]

[footer opcional]
```

---

## Tipos de Commit

| Tipo | Cuándo usar | Ejemplo |
|------|-------------|---------|
| `feat` | Nueva funcionalidad | `feat(memory): add cleanup patterns` |
| `fix` | Corrección de bug | `fix(cron): rate limit handling` |
| `docs` | Documentación | `docs: update daily log` |
| `refactor` | Refactorización | `refactor(agents): extract startup to runbook` |
| `test` | Tests | `test(api): add usage tracking tests` |
| `chore` | Mantenimiento | `chore: update dependencies` |
| `perf` | Performance | `perf: optimize memory lookup` |

---

## Scopes Comunes

| Scope | Qué cubre |
|-------|-----------|
| `memory` | Archivos en memory/ |
| `agents` | AGENTS.md y config de agentes |
| `cron` | Cronjobs y automatización |
| `api` | APIs externas (Brave, Gemini, etc.) |
| `gateway` | OpenClaw Gateway |
| `docs` | Documentación general |
| `vps` | Infraestructura del servidor |

---

## Reglas

1. **Línea de título:** Máximo 50 caracteres
2. **Usar imperativo:** "add" no "added" o "adds"
3. **Sin punto final:** En la línea de título
4. **Cuerpo separado:** Línea en blanco después del título
5. **Cuerpo:** Explicar QUÉ y POR QUÉ, no cómo

---

## Ejemplos

### Micro-tarea simple
```
feat(memory): add troubleshooting decision tree

Maps symptoms to runbooks/TS files for quick resolution.
Includes triage flow and file categories.

Micro-task 01:45 UTC
```

### Bug fix
```
fix(cron): use Gemini for micro-task to avoid GLM-5 rate limit

GLM-5 has 1 concurrent request limit. When main session is active,
spawning GLM-5 subagent causes 429 errors.

Solution: Micro-task cronjob now uses Gemini 3 Flash.
```

### Refactor
```
refactor(agents): extract startup procedure to runbook

AGENTS.md was 478 lines monolithic. Extracted:
- rbk-startup.md: Startup procedure
- rbk-triage.md: Debug loop
- ref-debugging.md: Commands reference
```

---

## Commits por Tipo de Tarea

| Tarea | Prefijo | Ejemplo |
|-------|---------|---------|
| Crear archivo | `feat` | `feat(memory): add ref-cleanup-patterns` |
| Actualizar docs | `docs` | `docs: update daily log` |
| Fix cronjob | `fix` | `fix(cron): delivery rate limit` |
| Refactor | `refactor` | `refactor(index): reorganize sections` |

---

## Micro-Tarea Footer

Para commits de micro-tareas, incluir:
```
Micro-task HH:MM UTC
```

---

## Verificar Commits

```bash
# Últimos 10 commits
git log --oneline -10

# Commits por tipo
git log --oneline | grep -E "^feat|^fix|^docs|^refactor" | cut -d: -f1 | sort | uniq -c

# Commits de hoy
git log --oneline --since="midnight"
```

---

_Creado: 2026-02-20 - Micro-tarea 02:15 UTC_
