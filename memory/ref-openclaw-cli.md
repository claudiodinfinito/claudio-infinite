# Comandos OpenClaw CLI

ID: REF-CLI-001
Tags: #openclaw #cli #commands
Keys: openclaw, cli, commands, gateway, cron
Last reviewed: 2026-02-19

---

## Gateway

```bash
# Estado
openclaw gateway status

# Reiniciar
systemctl --user restart openclaw-gateway

# Logs
tail -f /tmp/openclaw/openclaw-$(date +%Y-%m-%d).log
```

---

## Cronjobs

```bash
# Listar
openclaw cron list

# Ejecutar uno
openclaw cron run <job-id>

# Historial
openclaw cron runs <job-id>
```

---

## Modelos

```bash
# Estado
openclaw models status

# Probar modelo específico
openclaw models status --probe --probe-provider glm5 --json
```

---

## Diagnóstico

```bash
# Doctor completo
openclaw doctor

# Status general
openclaw status
```

---

## Rutas Importantes

| Qué | Dónde |
|-----|-------|
| Config | `/root/.openclaw/openclaw.json` |
| Secrets | `/root/.openclaw/.env` |
| Workspace | `/root/.openclaw/workspace/` |
| Logs | `/tmp/openclaw/openclaw-*.log` |

---

_Creado: 2026-02-19 - Referencia CLI OpenClaw_
