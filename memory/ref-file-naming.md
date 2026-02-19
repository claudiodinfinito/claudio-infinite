# Nomenclatura de Archivos en Memory/

ID: REF-NAMING-001
Tags: #naming #conventions #organization
Keys: naming, conventions, files, organization
Last reviewed: 2026-02-19

---

## Prefijos

| Prefijo | Uso | Ejemplo |
|---------|-----|---------|
| `ref-` | Referencias, recursos | `ref-git-commands.md` |
| `rbk-` | Runbooks (procedimientos) | `rbk-startup.md` |
| `ts-` | Troubleshooting | `ts-telegram-no-reply.md` |
| `spec-` | Especificaciones | `spec-tareas-autonomas.md` |
| `dec-` | Decisiones | `dec-group-chats.md` |
| `chk-` | Checklists | `chk-optimization.md` |
| `YYYY-MM-DD.md` | Diarios | `2026-02-19.md` |

---

## Formato de ID

```
[Prefijo]-[tema]-[número]
```

Ejemplos:
- `REF-GIT-001`
- `RBK-STARTUP-001`
- `TS-TEL-001`

---

## Reglas

1. **Todo en minúsculas** para nombres de archivo
2. **IDs en mayúsculas** dentro del archivo
3. **Guiones** separan palabras (no espacios ni guiones bajos)
4. **Incluir header estándar**: ID, Tags, Keys, Last reviewed

---

## Header Estándar

```markdown
# Título

ID: [PREFIJO]-[TEMA]-001
Tags: #tag1 #tag2
Keys: key1, key2, key3
Last reviewed: YYYY-MM-DD

---
```

---

_Creado: 2026-02-19 - Convenciones de nomenclatura_
