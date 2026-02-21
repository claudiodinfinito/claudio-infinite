# GitHub Repository - Claudio Infinito

**URL:** https://github.com/claudiodinfinito/claudio-infinite
**Creado:** 2026-02-21 21:30 UTC
**Owner:** @claudiodinfinito

---

## Configuración

| Variable | Estado |
|----------|--------|
| `GITHUB_TOKEN` | ✅ Configurado en .env |
| `gh` CLI | ✅ Instalado y autenticado |
| Git config | ✅ email: claudiodinfinito@gmail.com |

---

## Estructura del Repo

```bash
/workspace/
├── AGENTS.md          # Reglas operación
├── SOUL.md            # Identidad
├── SECURITY.md        # Seguridad
├── HEARTBEAT.md       # Autonomía
├── MEMORY.md          # Memoria largo plazo
├── README.md          # Este archivo
├── /memory/           # Base conocimiento
├── /skills/           # Habilidades
└── /psych_logs/       # Logs salud mental
```

---

## Comandos Útiles

```bash
# Ver estado
gh repo view

# Push cambios
git add . && git commit -m "mensaje" && git push

# Crear issue
gh issue create --title "Título" --body "Descripción"

# Ver repos
gh repo list

# Clonar en otro lado
gh repo clone claudio-infinite
```

---

## .gitignore

Archivos NO subidos:
- `.env` (tokens, secrets)
- `*.log` (logs)
- `node_modules/`
- `.pocketbase/` (datos locales)

---

_Repo oficial de Claudio Infinito_
