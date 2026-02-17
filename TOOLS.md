# TOOLS.md - Configuración del VPS

## Servidor RackNerd

- **Hostname**: racknerd-8bf9cb7
- **IP pública**: 192.227.249.251
- **OS**: Ubuntu 22.04.5 LTS (Jammy)
- **Kernel**: 5.15.0-168-generic
- **RAM**: 7.8GB
- **Disco**: 144GB

## Puertos Abiertos

| Puerto | Servicio | Estado |
|--------|----------|--------|
| 22 | SSH | ⚠️ Inseguro (PasswordAuth yes) |
| 80 | nginx | OK |
| 443 | nginx | OK |
| 3000 | Panel web | OK |
| 8080 | Open WebUI (Ollama) | OK |
| 8090 | PocketBase | OK |
| 11434 | Ollama API | OK |
| 18789 | OpenClaw Gateway | Loopback (seguro) |

## Docker

- **Versión**: Docker 27.x
- **Compose**: v2
- **Socket**: /var/run/docker.sock

### Comandos útiles:
```bash
# Ver estado de contenedores
docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"

# Logs de un contenedor
docker logs -f <container-name>

# Reiniciar contenedor
docker restart <container-name>

# Ver uso de recursos
docker stats --no-stream

# Entrar a contenedor
docker exec -it <container> sh
```

## OpenClaw

- **Config**: `/root/.openclaw/openclaw.json`
- **Env**: `/root/.openclaw/.env`
- **Logs**: `/tmp/openclaw/openclaw-YYYY-MM-DD.log`
- **Gateway**: `http://127.0.0.1:18789`
- **Mi memoria**: `/root/.openclaw/workspace/memory/`

### Comandos útiles:
```bash
# Estado
openclaw status

# Diagnóstico
openclaw doctor

# Reiniciar gateway
systemctl --user restart openclaw-gateway

# Ver logs
tail -f /tmp/openclaw/openclaw-$(date +%Y-%m-%d).log
```

## Seguridad - TODO

- [ ] Desactivar PasswordAuthentication en SSH (bloqueado hasta Tailscale)
- [ ] Desactivar PermitRootLogin (bloqueado hasta Tailscale)
- [ ] Activar UFW (confirmar puertos)
- [ ] Arreglar token de Discord (401)
- [ ] Configurar Gmail para Claudio
- [ ] PocketBase detrás de reverse proxy con HTTPS
- [ ] Backup diario de PocketBase

## ⚠️ IMPORTANTE: NO TOCAR

**CapRover** corre otras apps (n8n, PocketBase, Ollama, etc.)
- Daniel lo administra desde captain.adwebcrm.com
- **NO es donde yo estoy**
- **NO debo tocarlo**
- Containers con prefijo `srv-captain--` = CapRover, NO míos

---

## Backups

- **Docker volumes**: /var/lib/docker/volumes/
- **OpenClaw data**: En el host en `/root/.openclaw/`

## PocketBase - Best Practices

> ⚠️ **NO exponer directo al mundo** en puerto random. Usar reverse proxy con HTTPS.

### Backups (CRÍTICO)
PocketBase vive en `pb_data` (SQLite + archivos).

```bash
# Backup simple
tar -czf /root/pocketbase-backup-$(date +%F-%H%M).tar.gz /ruta/a/pb_data

# Backup pro: detener → backup → arrancar
systemctl stop pocketbase
tar -czf backup.tar.gz /ruta/a/pb_data
systemctl start pocketbase
```

**Rotación**: Diario, conservar 7-14 días, copiar a S3 u otro servidor.

### Seguridad
- Admin UI: password fuerte + 2FA
- NO exponer panel admin al mundo
- Solo IPs confiables o VPN
- Firewall: solo 22, 443, 80 públicos

---

## Skills - Dónde Viven

OpenClaw carga skills desde (en orden de prioridad):
1. **Bundled** (incluidas con OpenClaw)
2. `~/.openclaw/skills` (compartidas)
3. `<workspace>/skills` (por agente) ← tienen prioridad

---

## ClawHub - Registry de Skills

**ClawHub NO es algo que OpenClaw instala por defecto.**

Es un registry (tienda) de skills externo:
- Web: https://clawhub.ai/
- Docs: https://docs.openclaw.ai/tools/clawhub

### Cómo usar:
```bash
npm i -g clawhub
clawhub search "calendar"
clawhub install <skill-slug>
```

### Dónde se instalan:
- `./skills` del directorio actual
- O `<workspace>/skills` si estás dentro del workspace

---

## Skills Maliciosas - Seguridad

**Regla: Tratar skills como "paquetes npm de desconocidos"**

### Antes de usar una skill:
1. ✅ Leer `SKILL.md` completo
2. ✅ Verificar si tiene `exec` en requirements
3. ✅ Si tiene `exec`, revisar QUÉ ejecuta
4. ✅ Si hace `curl`/`wget` a URLs random → NO usar
5. ✅ Si pide API keys en el chat → NO usar
6. ✅ Preferir skills de ClawHub verificadas

### ⚠️ IMPORTANTE:
- **tools.deny NO aplica para mí** → necesito ser sysadmin
- **tools.deny SÍ aplica para skills específicas** → se puede limitar por skill
- **Secrets en ~/.openclaw/.env** → NUNCA dar a skills
- **No pegar API keys en chat** → ninguna skill debería pedirlo

---

## Modo Paranoico (opcional)

Si quisieras máxima seguridad:
1. Agente "daily driver" sin exec
2. Agente "ops" con exec (solo tú lo invocas)
3. `dmPolicy: pairing`
4. Grupos con `requireMention: true`

**Pero para tu caso actual, NO aplica.**
