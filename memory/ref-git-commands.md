# Comandos Git del Workspace

ID: REF-GIT-001
Tags: #git #commands #workflow
Keys: git, commands, commit, workflow
Last reviewed: 2026-02-19

---

## Comandos Diarios

```bash
# Status rápido
git status --short

# Commit de archivo específico
git add <file> && git commit -m "tipo: descripción"

# Commit todo
git add -A && git commit -m "tipo: descripción"

# Ver últimos commits
git log --oneline -10
```

---

## Tipos de Commit

| Tipo | Uso |
|------|-----|
| `docs:` | Documentación, comentarios |
| `feat:` | Nueva funcionalidad |
| `fix:` | Corrección de bug |
| `refactor:` | Refactorización |
| `chore:` | Mantenimiento |

---

## Flujo de Micro-Tarea

```bash
# 1. Verificar cambios
git status --short

# 2. Si hay cambios, commit
git add <file> && git commit -m "docs: descripción"

# 3. Si no hay cambios, crear/mejorar archivo
# ... editar archivo ...
git add <file> && git commit -m "docs: descripción"
```

---

## Alias Útiles (si se configuran)

```bash
git config --global alias.st "status --short"
git config --global alias.cm "commit -m"
git config --global alias.lo "log --oneline -10"
```

---

_Creado: 2026-02-19 - Referencia rápida de git_
