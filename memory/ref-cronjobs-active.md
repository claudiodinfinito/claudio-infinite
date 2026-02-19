# Cronjobs Activos - Sistema de Recordatorios

ID: REF-CRONJOBS-001
Status: active
Tags: #cronjobs #reminders #automation
Keys: cronjobs, reminders, automation, alerts
Last reviewed: 2026-02-19

---

## Cronjobs Configurados

| ID | Nombre | Horario | Propósito |
|----|--------|---------|-----------|
| `fede06ad...` | reminder:micro-task-5min | Cada 5 min | Micro-tarea autónoma (Atomic Habits) |
| `3228f35b...` | reminder:daily-log-update | Diario 22:00 UTC | Actualizar daily log + TODO |
| `6fbad97d...` | reminder:weekly-consolidation | Domingo 12:00 UTC | Consolidar memoria semanal |
| `0c238999...` | reminder:api-usage-check | Diario 18:00 UTC | Verificar uso de APIs |
| `0f6fae18...` | reminder:still-check | Cada 2 horas | Check si estoy en STILL |
| `53cc6fb2...` | healthcheck:vps-daily | Diario 06:00 UTC | Health check del VPS |
| `f73f89dc...` | backup:workspace | Diario 06:00 UTC | Backup del workspace |
| `ae1dc9d8...` | healthcheck:security-weekly | Lunes 09:00 UTC | Security check semanal |
| `379a4cdf...` | alert:glm5-expiry | 2026-03-01 09:00 UTC | Alerta GLM-5 expiry |
| `43701593...` | alert:glm5-expiry-urgent | 2026-03-15 09:00 UTC | Alerta urgente GLM-5 |

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

## Flujo de Still Check (cada 2 horas)

```
Cron: reminder:still-check se ejecuta
    ↓
Leo: ¿Daniel ha interactuado en los últimos 30 min?
    ↓ NO
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

## Notas

- Los cronjobs con `sessionTarget: isolated` ejecutan en sesión aislada
- El modelo usado es GLM-5 (gratis)
- Los reminders van al canal Telegram de Daniel

---

_Creado: 2026-02-19 - Tracking de automatizaciones_
