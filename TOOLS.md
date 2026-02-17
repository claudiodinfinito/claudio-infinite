# TOOLS.md - Comandos y Skills

**Para info del VPS ver:** `VPS-MAP.md`

---

## 🐳 Docker

```bash
# Estado contenedores
docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"

# Logs
docker logs -f <container-name>

# Reiniciar
docker restart <container-name>

# Recursos
docker stats --no-stream

# Entrar
docker exec -it <container> sh
```

---

## 🦉 OpenClaw

```bash
# Estado
openclaw status
openclaw gateway status
openclaw doctor

# Reiniciar
systemctl --user restart openclaw-gateway

# Logs
tail -f /tmp/openclaw/openclaw-$(date +%Y-%m-%d).log

# Cron
openclaw cron list
openclaw cron run <job-id>
```

---

## 🔐 Config Paths

| Qué | Dónde |
|-----|-------|
| Config | `/root/.openclaw/openclaw.json` |
| Secrets | `/root/.openclaw/.env` (chmod 600) |
| Mi memoria | `/root/.openclaw/workspace/memory/` |
| Credentials | `/root/.openclaw/credentials/` |

---

## ⚠️ NO TOCAR

**CapRover** = containers con prefijo `srv-captain--`
- Daniel administra desde captain.adwebcrm.com
- NO es donde yo estoy
- NO debo tocarlo

---

## 📦 Skills

OpenClaw carga skills desde:
1. Bundled (incluidas)
2. `~/.openclaw/skills` (compartidas)
3. `<workspace>/skills` (por agente) ← prioridad

### Instalar desde ClawHub:
```bash
npm i -g clawhub
clawhub search "<query>"
clawhub install <skill-slug>
```

### Seguridad Skills:
- Leer SKILL.md antes de usar
- Si pide API keys en chat → NO usar
- Si hace curl/wget a URLs random → NO usar

---

## 💾 Backups

```bash
# PocketBase
tar -czf /root/respaldos_pocketbase/pb_$(date +%F).tar.gz /ruta/pb_data

# Workspace (automático via cron)
# Ver HEARTBEAT.md para configuración
```

---

## 🔧 Debug Checklist

1. `openclaw gateway status`
2. `openclaw doctor`
3. `openclaw models status --probe --probe-provider glm5 --json`
4. `tail -n 200 /tmp/openclaw/openclaw-$(date +%Y-%m-%d).log`
