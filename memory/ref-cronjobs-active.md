# Cronjobs Activos - Sistema de Recordatorios

ID: REF-CRONJOBS-001
Status: active
Tags: #cronjobs #reminders #automation
Keys: cronjobs, reminders, automation, alerts
Last reviewed: 2026-02-20

---

## Cronjobs Configurados (9 activos)

| ID | Nombre | Horario | Modelo | Propósito |
|----|--------|---------|--------|-----------|
| `fede06ad` | micro-task-5min | Cada 5 min | **Gemini** | Micro-mejoras autónomas |
| `3228f35b` | daily-log-update | 22:00 UTC | GLM-5 | Actualizar daily log |
| `6fbad97d` | weekly-consolidation | Dom 12:00 | GLM-5 | Consolidar memoria |
| `0c238999` | api-usage-check | 18:00 UTC | GLM-5 | Verificar APIs |
| `53cc6fb2` | healthcheck:vps-daily | 06:00 UTC | GLM-5 | Health VPS |
| `f73f89dc` | backup:workspace | 06:00 UTC | GLM-5 | Backup git |
| `ae1dc9d8` | healthcheck:security-weekly | Lun 09:00 | GLM-5 | Security audit |
| `379a4cdf` | alert:glm5-expiry | 2026-03-01 | — | Alerta 30 días |
| `43701593` | alert:glm5-expiry-urgent | 2026-03-15 | — | Alerta urgente |

---

## Cambios Recientes (2026-02-20)

| Cambio | Razón |
|--------|-------|
| ❌ Eliminado `reminder:still-check` | Redundante con heartbeat cada 30 min |
| ✅ `micro-task-5min` ahora usa Gemini | Evitar rate limit GLM-5 |

---

## Comandos Útiles

```bash
# Listar todos
openclaw cron list

# Ejecutar uno manualmente
openclaw cron run <job-id>

# Ver historial
openclaw cron runs <job-id>
```

---

## Flujo de Still Check (Heartbeat)

```
Heartbeat cada 30 min
    ↓
¿Daniel ha interactuado en los últimos 30 min?
    ↓ NO (still)
LEO TODO.md → ¿Hay tareas Next?
    ↓ SÍ
ELIJO tarea ALTA → EJECUTO
    ↓
CREO artefacto → ACTUALIZO index.md
    ↓
GUARDO en daily log: "AUTÓNOMO: [qué hice]"
    ↓
REPORTO cuando Daniel vuelva
```

---

## Notas Técnicas

- `sessionTarget: isolated` = ejecuta en sesión aislada
- GLM-5 = 1 request concurrente máximo
- Gemini = 20 requests/día
- Micro-tarea usa Gemini para evitar conflicto con main (GLM-5)

---

## Troubleshooting

Ver: `memory/ts-cron-delivery-fixed.md`

---

_Actualizado: 2026-02-20 00:55 UTC - Cronjobs corregidos_
