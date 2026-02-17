# SYSTEM-STATUS.md - Estado del Sistema

**Actualizado:** 17 Feb 2026, 02:45 UTC

---

## 🖥️ VPS (RackNerd Dallas)

| Componente | Valor |
|------------|-------|
| Hostname | `racknerd-8bf9cb7` |
| IP Pública | `192.227.249.251` |
| OS | Ubuntu 22.04.5 LTS |
| Kernel | 5.15.0-168-generic |
| RAM | 7.8GB (22% usado) |
| Disco | 144GB (31% usado) |

---

## 🦀 OpenClaw

| Componente | Estado |
|------------|--------|
| Versión | 2026.2.15 |
| Gateway | ✅ Running (127.0.0.1:18789) |
| Modelo Primario | GLM-5-FP8 (gratis hasta Abril 2026) |
| Fallback | Claude Opus 4-5 |
| Sesiones | 8 activas |
| Heartbeat | 30 min |

---

## 📱 Canales

| Canal | Estado | Nota |
|-------|--------|------|
| Telegram | ✅ OK | @claudioinfinito_bot |
| Discord | ⚠️ SETUP | Sin token - ELIMINAR |

---

## 🧠 Memoria

| Aspecto | Estado |
|---------|--------|
| MEMORY.md | ✅ Existe |
| memory/YYYY-MM-DD.md | ⚠️ Solo hasta 15 Feb |
| Memory Search | ❌ Sin embedding provider |

---

## 🛠️ Skills

| Métrica | Valor |
|---------|-------|
| Total | 51 |
| Listos | 11 |
| Rotos | 40 |

**Skills listos:** clawhub, github, gog, healthcheck, nano-pdf, session-logs, skill-creator, tmux, weather, claudio-infinite, vps-admin

---

## ⏰ Cron Jobs

| Job | Horario | Estado |
|-----|---------|--------|
| healthcheck:vps-daily | 06:00 UTC | ✅ OK |
| backup:workspace | 06:00 UTC | ✅ OK |
| healthcheck:security-weekly | Lun 09:00 UTC | ✅ OK |
| claudio:investigacion-madrugada | 05:00 UTC | Idle |
| claudio:investigacion-nocturna | 23:00 UTC | Idle |
| alert:glm5-expiry | 01 Mar 2026 | Idle |
| alert:glm5-expiry-urgent | 15 Mar 2026 | Idle |

---

## 🐳 Docker / CapRover

| App | Puerto | Estado |
|-----|--------|--------|
| nginx | 80, 443 | ✅ |
| captain | 3000 | ✅ |
| n8n-mkt-a1 | 5678 | ? |
| PocketBase | 8090 | ⚠️ Persistencia |
| Ollama | 11434 | ✅ |
| Open WebUI | 8080 | ✅ |

---

_Actualizar este archivo cuando cambie el estado._
