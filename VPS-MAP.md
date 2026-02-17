# VPS-MAP.md - Mapa Completo del VPS

**Última actualización:** 17 Feb 2026, 05:16 UTC

---

## 🖥️ Hardware

| Recurso | Total | Usado | Disponible |
|---------|-------|-------|------------|
| Disco | 144GB | 42GB (31%) | 96GB |
| RAM | 7.8GB | 1.7GB | 5.7GB disponible |
| Swap | 8GB | 837MB | 7.2GB |

**Estado:** SALUDABLE ✅

---

## 🌐 Puertos Abiertos

| Puerto | Servicio | Exposición | Responsable |
|--------|----------|------------|-------------|
| 22 | SSH | Público ⚠️ | Host |
| 53 | DNS (systemd) | Loopback | Host |
| 80 | HTTP | Público | Docker (nginx) |
| 443 | HTTPS | Público | Docker (nginx) |
| 3000 | CapRover Panel | Público | Docker |
| 7946 | Docker Swarm | Todas | Docker |
| 2377 | Docker Swarm | Todas | Docker |
| 18789 | OpenClaw Gateway | Loopback ✅ | OpenClaw |
| 18792 | OpenClaw Secondary | Loopback | OpenClaw |

**Pendiente de seguridad:** UFW no activado

---

## 🐳 Contenedores Docker

### CapRover (OFF-LIMITS - Daniel administra)
| Nombre | Servicio | Estado | Puerto |
|--------|----------|--------|--------|
| srv-captain--a1-ppc-dashboard | Dashboard PPC | Up 7h | 3000 |
| srv-captain--a1-pocketbase | PocketBase DB | Up 9h | 8090 |
| srv-captain--n8n-mkt-a1 | n8n Automatizaciones | Up 3d | 5678 |
| srv-captain--a1-ollama | Ollama LLM | Up 4d | 11434 |
| srv-captain--a1-webui-ollama | Open WebUI | Up 4d | 8080 |
| captain-certbot | SSL Certs | Up 13d | 80 |
| captain-nginx | Reverse Proxy | Up 13d | 80, 443 |
| captain-captain | CapRover Core | Up 13d | 3000 |

### OpenClaw
| Nombre | Servicio | Estado |
|--------|----------|--------|
| openclaw-sbx-agent-main-0d71ad7a | Sandbox (temporal) | Up 29h |
| naughty_mclean | ? | Up 2d |

**⚠️ NOTA:** CapRover NO es mío. NO tocar.

---

## 📁 Directorios Importantes

### OpenClaw
```
/root/.openclaw/
├── openclaw.json       # Config principal
├── .env                # Secrets (chmod 600)
├── credentials/        # OAuth credentials
├── workspace/          # MI HOGAR - PERSISTENTE
├── cron/               # Cron job data
├── telegram/           # Telegram state
├── logs/               # Logs internos
├── media/              # Archivos media
└── sandboxes/          # Temporal - puede limpiarse
```

### Backups
```
/root/respaldos_pocketbase/
└── pocketbase_backup_20260216_225203.tar.gz (3.2MB)
```

### Logs
```
/tmp/openclaw/
├── openclaw-2026-02-17.log (2.1MB)
└── openclaw-2026-02-16.log (4.6MB)
```

---

## ⏰ Cron Jobs Activos

| ID | Nombre | Horario UTC | Frecuencia | Estado |
|----|--------|-------------|------------|--------|
| 53cc... | healthcheck:vps-daily | 06:00 | Diario | ✅ OK |
| f73f... | backup:workspace | 06:00 | Diario | ✅ OK |
| 1e0a... | claudio:investigacion-1 | 23:00 | Diario | idle |
| c10b... | claudio:investigacion-2 | 05:00 | Diario | skipped |
| ae1d... | healthcheck:security-weekly | 09:00 Lun | Semanal | ✅ OK |
| 379a... | alert:glm5-expiry | 01 Mar 09:00 | One-shot | idle |
| 4370... | alert:glm5-expiry-urgent | 15 Mar 09:00 | One-shot | idle |

**Próximo check:** en 44 minutos (06:00 UTC)

---

## 📧 Credenciales y Tokens

| Servicio | Ubicación | Estado |
|---------|-----------|--------|
| Google OAuth | `/root/.openclaw/credentials/google_client_secret.json` | ✅ Guardado |
| API Keys | `/root/.openclaw/.env` | 🔒 Secreto |
| Gateway Token | `/root/.openclaw/.env` | 🔒 Secreto |
| Telegram Bot | `/root/.openclaw/.env` | 🔒 Secreto |

---

## 🔒 Seguridad - Estado Actual

| Check | Estado | Nota |
|-------|--------|------|
| SSH Password Auth | ⚠️ Activo | Bloqueado hasta Tailscale |
| Root Login | ⚠️ Permitido | Bloqueado hasta Tailscale |
| UFW | ❌ Desactivado | Pendiente Daniel |
| Gateway Loopback | ✅ OK | 127.0.0.1:18789 |
| Secrets protegidos | ✅ OK | chmod 600 .env |
| CapRover aislado | ✅ OK | No toco sus containers |

---

## 🦉 Mi Responsabilidad

**Estos son los servicios que debo cuidar:**

1. **OpenClaw Gateway** - Mi runtime
2. **Docker** - Infraestructura base
3. **Logs** - Monitorear errores
4. **Backups** - Verificar que se ejecutan
5. **Seguridad** - Alertar si algo raro

**NO debo tocar:**
- CapRover containers (srv-captain--*)
- Configuración de nginx/CapRover
- n8n workflows
- PocketBase data

---

_Actualizar cuando cambie algo importante_
