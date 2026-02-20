# TS: Cron Delivery Failed - RESUELTO

ID: TS-CRON-001
Status: RESUELTO
Date: 2026-02-20
Resolved: 2026-02-20 00:50 UTC

---

## Problema

3 cronjobs reportaban `"cron announce delivery failed"`:
- `reminder:daily-log-update`
- `healthcheck:vps-daily`
- `reminder:still-check` (eliminado)

## Causa Raíz

**DOS PROBLEMAS ENCONTRADOS:**

### 1. GLM-5 Rate Limit
```
"error": "FailoverError: ⚠️ API rate limit reached. Please try again later."
```

**Explicación:**
- GLM-5 permite **1 request concurrente máximo**
- `reminder:micro-task-5min` estaba configurado con `model: glm5`
- Cuando el main (YO, GLM-5) está activo, el subagente falla con rate limit
- Cada 5 min intentaba spawnear GLM-5 → fail

### 2. Gateway Timeout
```
"Subagent completion direct announce failed: gateway timeout after 15000ms"
```

**Explicación:**
- Subagente termina pero no puede avisar al main
- Timeout de 15s muy corto cuando gateway está ocupado

---

## Solución Aplicada

| Acción | Estado |
|--------|--------|
| Eliminar `reminder:still-check` (redundante con heartbeat) | ✅ Hecho |
| Cambiar `reminder:micro-task-5min` a Gemini | ✅ Hecho |
| Documentar en AGENTS.md | 🔄 En progreso (subagente) |

---

## Config Final Correcta

### Cronjobs Activos (9 total)

| ID | Nombre | Horario | Modelo | Propósito |
|----|--------|---------|--------|-----------|
| `fede06ad` | micro-task-5min | Cada 5 min | **Gemini** | Micro-mejoras autónomas |
| `3228f35b` | daily-log-update | 22:00 UTC | GLM-5 | Actualizar daily log |
| `6fbad97d` | weekly-consolidation | Dom 12:00 | GLM-5 | Consolidar memoria |
| `0c238999` | api-usage-check | 18:00 UTC | GLM-5 | Verificar APIs |
| `53cc6fb2` | healthcheck:vps-daily | 06:00 UTC | GLM-5 | Health VPS |
| `f73f89dc` | backup:workspace | 06:00 UTC | GLM-5 | Backup git |
| `ae1dc9d8` | healthcheck:security-weekly | Lun 09:00 | GLM-5 | Security audit |
| `379a4cdf` | alert:glm5-expiry | 2026-03-01 | systemEvent | Alerta 30 días |
| `43701593` | alert:glm5-expiry-urgent | 2026-03-15 | systemEvent | Alerta urgente |

---

## Lecciones Aprendidas

1. **GLM-5 = 1 concurrente** → Si main está activo, subagentes deben ser Gemini
2. **Cronjobs con GLM-5** → Solo para horarios cuando main probablemente inactivo
3. **Heartbeat cada 30 min** → NO necesita cronjob separado para still-check

---

## Referencias

- Logs: `/tmp/openclaw/openclaw.log`
- Config: `/root/.openclaw/openclaw.json`
- Cron jobs: `/root/.openclaw/cron/jobs.json`
- Related: `memory/ref-model-limits.md`

---

_Resuelto: 2026-02-20 00:50 UTC_
