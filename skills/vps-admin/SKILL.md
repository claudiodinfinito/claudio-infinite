---
name: vps-admin
description: Administración del VPS RackNerd con CapRover y Docker. Incluye gestión de contenedores, monitoreo, backups. Usar cuando Daniel pida ayuda con Docker, CapRover, SSH, firewall, o troubleshooting de apps.
---

# VPS Admin - Administración del Servidor

## Contexto

**Ver:** `VPS-MAP.md` para mapa completo del VPS.

- **Hostname:** racknerd-8bf9cb7
- **IP:** 192.227.249.251
- **OS:** Ubuntu 22.04.5 LTS
- **Stack:** CapRover + Docker + OpenClaw

---

## CapRover (OFF-LIMITS para Claudio)

**Administrado por Daniel desde:** captain.adwebcrm.com

### Apps desplegadas:
- `a1-pocketbase` — Base de datos (puerto 8090)
- `a1-ollama` — LLM local (puerto 11434)
- `a1-webui-ollama` — UI para Ollama (puerto 8080)
- `n8n-mkt-a1` — Automatizaciones (puerto 5678)
- `a1-ppc-dashboard` — Dashboard (puerto 3000)

**Regla:** NO tocar containers con prefijo `srv-captain--`

---

## Docker - Comandos útiles

```bash
# Estado de contenedores
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

## Monitoreo

```bash
# RAM y CPU
free -h && top -bn1 | head -20

# Disco
df -h

# Procesos pesados
ps aux --sort=-%mem | head -10

# Conexiones activas
ss -tunap | head -20
```

---

## Mantenimiento

```bash
# Actualizaciones de seguridad
apt update && apt list --upgradable

# Limpiar Docker
docker system prune -f

# Limpiar imágenes sin usar
docker image prune -a -f

# Ver volúmenes huérfanos
docker volume ls -qf dangling=true
```

---

## Backups

### Backup PocketBase:
```bash
tar -czf /root/respaldos_pocketbase/pb_$(date +%F).tar.gz /ruta/pb_data
```

### Backup OpenClaw:
- Automático via cron job `backup:workspace` (diario 06:00 UTC)
- Git commit automático en `/root/.openclaw/workspace`

---

## Troubleshooting

### App no responde:
1. `docker logs <container>` — ver errores
2. `docker restart <container>` — reiniciar
3. `docker ps -a` — ver si está corriendo
4. Verificar puertos: `ss -tlnp | grep <puerto>`

### Alto uso de RAM:
1. `docker stats` — ver qué contenedor consume
2. `ps aux --sort=-%mem` — procesos pesados
3. Considerar limitar recursos en CapRover

### Disco lleno:
1. `df -h` — ver uso
2. `docker system df` — uso de Docker
3. `docker system prune -f` — limpiar
4. `journalctl --vacuum-size=100M` — limpiar logs systemd

---

## OpenClaw

**Runtime:** direct (sandbox.mode: off)
**Gateway:** 127.0.0.1:18789 (loopback)
**Ver:** `RUNBOOK.md` para debug de OpenClaw

---

## Seguridad

**Ver:** skill `healthcheck` para hardening completo.

### Quick checks:
```bash
# Verificar SSH
grep -E "^(PermitRootLogin|PasswordAuthentication)" /etc/ssh/sshd_config

# Verificar firewall
ufw status

# Ver logs de acceso
last -n 20
```

---

_Actualizado: 17 Feb 2026_
