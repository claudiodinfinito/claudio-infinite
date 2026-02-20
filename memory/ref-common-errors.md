# Common Errors Reference

ID: REF-ERRORS-001
Tags: #errors #troubleshooting #debugging #solutions
Keys: errors, troubleshooting, debug, solutions, 429, timeout, gateway
Last reviewed: 2026-02-20

---

## Rate Limit Errors

### 429 Too Many Requests (GLM-5)
```
Error: "API rate limit reached"
```
**Causa:** GLM-5 permite solo 1 request concurrente
**Solución:**
1. Esperar a que termine request actual
2. O usar Gemini para subagentes

---

### Gemini Quota Exceeded
```
Error: "RESOURCE_EXHAUSTED"
```
**Causa:** Límite de 20 requests/día alcanzado
**Solución:**
1. Esperar reset a 00:00 UTC
2. Usar GLM-5 o Claude Haiku

---

### Brave API Limit
```
Error: "429 from Brave Search API"
```
**Causa:** Límite mensual de 1,500 búsquedas
**Solución:**
1. Verificar `memory/brave-usage.json`
2. Preservar búsquedas para crítico
3. Usar fetch directo si es URL conocida

---

## Gateway Errors

### Gateway Timeout
```
Error: "gateway timeout"
```
**Causa:** Gateway no responde en tiempo esperado
**Solución:**
```bash
openclaw gateway status
systemctl --user restart openclaw-gateway
```

---

### Session Locked
```
Error: "session is locked"
```
**Causa:** Archivo .lock huérfano
**Solución:**
```bash
ls /tmp/openclaw/*.lock
rm /tmp/openclaw/*.lock
```
Ver: `rbk-session-locked.md`

---

### Model Not Found
```
Error: "model not found: glm5/..."
```
**Causa:** Modelo no disponible o mal configurado
**Solución:**
```bash
openclaw models status --probe --json
```

---

## Docker Errors

### Container Exited
```
Status: Exited (1)
```
**Solución:**
```bash
docker logs <container> | tail -50
docker restart <container>
```

---

### Port Already in Use
```
Error: "port is already allocated"
```
**Solución:**
```bash
netstat -tlnp | grep <port>
# Matar proceso o cambiar puerto
```

---

## Telegram Errors

### Bot Not Responding
```
Síntoma: Mensaje enviado, sin respuesta
```
**Checks:**
1. `openclaw gateway status`
2. Token válido en `.env`
3. Ver logs: `tail -50 /tmp/openclaw/*.log`

---

### No Typing Indicator
```
Síntoma: Sin "typing..." cuando proceso
```
**Causa:** Configuración de canal
**Solución:** Ver `ts-telegram-no-reply.md`

---

## File System Errors

### No Space Left
```
Error: "No space left on device"
```
**Solución:**
```bash
df -h /
du -sh /* | sort -rh | head -10
docker system prune -f
```

---

### Permission Denied
```
Error: "Permission denied"
```
**Solución:**
```bash
ls -la <file>
chmod 600 <file>  # para secrets
chmod 755 <dir>   # para directorios
```

---

## Cron Errors

### Cronjob Delivery Failed
```
Error: Cronjob ejecutó pero sin mensaje
```
**Causa común:** Rate limit GLM-5
**Solución:** Ver `ts-cron-delivery-fixed.md`

---

### Cronjob Not Running
```
Síntoma: Job en lista pero no ejecuta
```
**Checks:**
```bash
openclaw cron list
openclaw cron run <job-id>  # test manual
```

---

## Quick Reference

| Error | Archivo | Acción rápida |
|-------|---------|---------------|
| 429 GLM-5 | Esperar | Usar Gemini |
| Gateway timeout | `rbk-gateway-restart.md` | `systemctl restart` |
| Session locked | `rbk-session-locked.md` | `rm *.lock` |
| Container down | `docker logs` | `docker restart` |
| No space | Limpiar | `docker system prune` |

---

_Creado: 2026-02-20 - Micro-tarea 02:20 UTC_
