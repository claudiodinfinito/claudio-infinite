# Quick Reference: OpenClaw CLI Commands

**Propósito:** Comandos OpenClaw CLI más usados.
**Uso:** Consulta rápida.

---

## Gateway

```bash
# Estado del gateway
openclaw gateway status

# Iniciar/detener
openclaw gateway start
openclaw gateway stop
openclaw gateway restart

# Diagnóstico
openclaw doctor
```

---

## Cron

```bash
# Listar jobs
openclaw cron list

# Ver runs de un job
openclaw cron runs <job-id>

# Ejecutar manualmente
openclaw cron run <job-id>

# Logs
tail -f /tmp/openclaw/openclaw-$(date +%Y-%m-%d).log
```

---

## Models

```bash
# Estado de modelos
openclaw models status

# Probar modelo específico
openclaw models status --probe --probe-provider glm5 --json

# Ver config de modelos
cat /root/.openclaw/openclaw.json | jq '.models'
```

---

## Sessions

```bash
# Listar sesiones
openclaw sessions list

# Ver historial de sesión
openclaw sessions history <session-key>
```

---

## Status

```bash
# Estado general
openclaw status

# Versión
openclaw --version
```

---

## Files & Paths

| Qué | Dónde |
|-----|-------|
| **Config** | `/root/.openclaw/openclaw.json` |
| **Secrets** | `/root/.openclaw/.env` |
| **Logs** | `/tmp/openclaw/openclaw-YYYY-MM-DD.log` |
| **Workspace** | `/root/.openclaw/workspace` |
| **Credentials** | `/root/.openclaw/credentials/` |

---

## Troubleshooting

### Gateway no responde

```bash
# Verificar proceso
ps aux | grep openclaw

# Reiniciar
systemctl --user restart openclaw-gateway

# Ver logs
journalctl --user -u openclaw-gateway -f
```

### Modelo falla

```bash
# Verificar API keys
cat /root/.openclaw/.env | grep -i key

# Probar conexión
openclaw models status --probe
```

### Cronjob no ejecuta

```bash
# Ver estado
openclaw cron list

# Ver logs del job
openclaw cron runs <job-id>

# Ejecutar manualmente para debug
openclaw cron run <job-id>
```

---

## One-liners Útiles

```bash
# Ver uptime del gateway
systemctl --user show openclaw-gateway --property=ActiveState,SubState

# Ver últimas 50 líneas de log
tail -50 /tmp/openclaw/openclaw-$(date +%Y-%m-%d).log

# Contar errores en el log
grep -c "error\|Error\|ERROR" /tmp/openclaw/openclaw-$(date +%Y-%m-%d).log

# Ver uso de APIs
cat /root/.openclaw/workspace/memory/brave-usage.json
```

---

_Creado: 2026-02-20 21:06 UTC - Micro-tarea autónoma_
