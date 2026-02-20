# Commit Message Template Reference

**Propósito:** Template mejorado para commits automáticos.
**Fuente:** Item #99 de ref-interests-real-100.md

---

## Formato Actual

```
type(scope): description
```

Ejemplo: `docs(memory): add commit template reference`

---

## Template Mejorado

```
<type>(<scope>): <action> <subject>

[optional body]

[optional footer]
```

---

## Tipos

| Tipo | Cuándo usar | Ejemplo |
|------|-------------|---------|
| `feat` | Nueva funcionalidad | `feat(cron): add timezone support` |
| `fix` | Bug fix | `fix(gateway): resolve timeout issue` |
| `docs` | Documentación | `docs(memory): add commit template` |
| `refactor` | Refactor sin cambiar behavior | `refactor(agents): simplify startup` |
| `perf` | Mejora performance | `perf(search): optimize query` |
| `test` | Tests | `test(api): add unit tests` |
| `chore` | Mantenimiento | `chore(deps): update packages` |
| `style` | Formateo | `style(code): fix indentation` |

---

## Scopes Disponibles

| Scope | Descripción |
|-------|-------------|
| `memory` | Archivos en memory/ |
| `agents` | AGENTS.md, USER.md, SOUL.md |
| `cron` | Cronjobs |
| `gateway` | OpenClaw gateway |
| `docker` | Containers |
| `vps` | Sistema operativo |
| `api` | APIs externas |
| `docs` | Documentación general |
| `config` | Configuración |

---

## Acciones

| Acción | Cuándo usar |
|--------|-------------|
| `add` | Archivo nuevo |
| `update` | Modificación |
| `remove` | Eliminación |
| `fix` | Corregir |
| `refactor` | Reestructurar |
| `implement` | Implementar feature |

---

## Ejemplos Mejorados

### Antes
```
docs(memory): add commit template reference
```

### Después
```
docs(memory): add commit message template reference

Template mejorado con:
- Tipos: feat, fix, docs, refactor, perf, test, chore, style
- Scopes: memory, agents, cron, gateway, docker, vps, api, docs
- Acciones: add, update, remove, fix, refactor, implement

Relates: ref-interests-real-100.md item #99
```

---

## Generación Automática

### En micro-tareas:
```javascript
const type = "docs";
const scope = "memory";
const action = "add";
const subject = "commit template reference";

commit_msg = `${type}(${scope}): ${action} ${subject}

[detalles opcionales]

Relates: ${fuente}`;
```

### Template corto (para commits simples):
```
type(scope): action subject - brief detail
```

---

## Reglas

1. **Línea 1:** Máximo 72 caracteres
2. **Verbo imperativo:** "add" no "added" o "adds"
3. **Sin punto final:** En línea 1
4. **Cuerpo opcional:** Explicar por qué, no qué

---

## Validación

```bash
# Validar formato
git log --format="%s" | grep -E "^[a-z]+\([^)]+\): .+$"
```

---

_Creado: 2026-02-20 20:26 UTC - Micro-tarea autónoma_
