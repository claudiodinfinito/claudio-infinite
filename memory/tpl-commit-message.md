# Template: Git Commit Message

**Creado:** 2026-02-21 16:05 UTC
**Propósito:** Estandarizar mensajes de commit para claridad y automatización

---

## Formato Estándar

```
<type>(<scope>): <subject>

[optional body]

[optional footer]
```

---

## Tipos de Commit

| Tipo | Cuándo usar | Ejemplo |
|------|-------------|---------|
| `feat` | Nueva funcionalidad | feat(dept): add Analytics department |
| `fix` | Bug fix | fix(cron): resolve rate limit issue |
| `docs` | Solo documentación | docs(readme): update installation steps |
| `refactor` | Refactorización sin cambio funcional | refactor(agents): simplify startup procedure |
| `perf` | Mejora de performance | perf(query): optimize database lookup |
| `test` | Añadir/modificar tests | test(api): add endpoint validation |
| `chore` | Mantenimiento, no código | chore(deps): update dependencies |
| `style` | Formato, no lógica | style(fmt): fix indentation |

---

## Scopes Comunes

| Scope | Uso |
|-------|-----|
| `agents` | Config de agentes |
| `memory` | Archivos en memory/ |
| `cron` | Cronjobs |
| `gateway` | OpenClaw gateway |
| `workflows` | n8n workflows |
| `departments` | Departamentos multiagente |
| `runbooks` | Runbooks y troubleshooting |
| `vps` | Sistema y Docker |
| `docs` | Documentación general |

---

## Reglas del Subject

1. **Imperativo:** "add" no "added" o "adds"
2. **Minúsculas:** Sin capitalizar primera letra
3. **Sin punto final:** No terminar con "."
4. **Máximo 50 caracteres**
5. **Explicar QUÉ y POR QUÉ:** No el cómo

---

## Ejemplos

### ✅ Buenos

```
feat(departments): add Analytics department
fix(cron): resolve GLM-5 rate limit conflict
docs(memory): update index with new runbooks
refactor(agents): simplify startup to 4 steps
```

### ❌ Malos

```
Added analytics stuff
fix stuff
update
WIP
asdfasdf
```

---

## Body (Opcional)

Usar cuando:
- El commit es complejo
- Hay múltiples cambios
- Necesita contexto

**Formato:**
```
<type>(<scope>): <subject>

- Bullet 1
- Bullet 2
- Bullet 3

Footer: valor
```

---

## Commits Autónomos

**Formato para autonomía:**
```
feat(scope): descripción corta

- Bullet 1: qué se hizo
- Bullet 2: qué se hizo
- Update TODO.md #X as completed

Autonomy: YYYY-MM-DD HH:MM UTC
```

---

## Prefijos Especiales

| Prefijo | Uso |
|---------|-----|
| `WIP:` | Work in progress |
| `BREAKING:` | Cambio rompe compatibilidad |
| `HOTFIX:` | Fix urgente |

---

## Validación Pre-Commit

```bash
# Verificar último commit
git log -1 --pretty=format:"%s"

# Verificar formato
echo "feat(scope): subject" | grep -E "^(feat|fix|docs|refactor|perf|test|chore|style)\([a-z]+\): .{1,50}$"
```

---

## Referencias

- Conventional Commits: https://www.conventionalcommits.org/
- `memory/ref-commit-conventions.md` — Convenciones detalladas
- `memory/ref-git-commands.md` — Comandos git

---

_Actualizado: 2026-02-21 16:05 UTC_
