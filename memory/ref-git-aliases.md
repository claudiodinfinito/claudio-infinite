# Git Aliases Reference

**Propósito:** Aliases útiles para productividad con Git.
**Fuente:** Item #8 de `ref-interests-real-100.md`

---

## Aliases Esenciales

```bash
# Configurar aliases
git config --global alias.co checkout
git config --global alias.br branch
git config --global alias.ci commit
git config --global alias.st status
git config --global alias.unstage 'reset HEAD --'
git config --global alias.last 'log -1 HEAD'
git config --global alias.visual 'log --oneline --graph --all'
git config --global alias.amend 'commit --amend --no-edit'
```

---

## Aliases Avanzados

```bash
# Ver histórico bonito
git config --global alias.lg "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"

# Deshacer último commit (mantiene cambios)
git config --global alias.undo 'reset HEAD~1 --mixed'

# Ver archivos modificados
git config --global alias.changed 'diff --name-only'

# Ver qué cambió en cada commit
git config --global alias.whatsnew 'log --oneline -10'

# Stash con nombre
git config --global alias.stash-list 'stash list'
```

---

## Aliases para OpenClaw

```bash
# Commit rápido
git config --global alias.quick '!f() { git add -A && git commit -m "$1"; }; f'

# Status corto
git config --global alias.s 'status -s'

# Log compacto
git config --global alias.ll 'log --oneline -20'

# Diff compacto
git config --global alias.d 'diff --stat'
```

---

## Archivo de Config Completo

Crear `~/.gitconfig`:

```ini
[alias]
    co = checkout
    br = branch
    ci = commit
    st = status
    unstage = reset HEAD --
    last = log -1 HEAD
    lg = log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit
    undo = reset HEAD~1 --mixed
    s = status -s
    ll = log --oneline -20
    d = diff --stat
```

---

## Uso

| Alias | Comando completo |
|-------|------------------|
| `git co main` | `git checkout main` |
| `git st` | `git status` |
| `git lg` | Log bonito |
| `git undo` | Deshacer último commit |
| `git ll` | Últimos 20 commits |
| `git s` | Status corto |

---

## Alias para Memory

```bash
# Commit con mensaje estándar para docs
alias gdoc='git add memory/ && git commit -m "docs(memory): update"'

# Quick commit
alias gq='git add . && git commit -m "quick update"'
```

---

_Creado: 2026-02-21 02:01 UTC - Micro-tarea (2 min)_
