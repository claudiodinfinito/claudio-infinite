# HEARTBEAT.md - Sistema de Investigación Inteligente

**Actualizado:** 17 Feb 2026

---

## 🧠 Sistema de Investigación "Still Detection"

**Concepto:** Investigación automática cuando detecto que estoy "still" (sin interacción de Daniel).

---

## 📊 Regla Simple

```
¿Heartbeat llega?
  → ¿Hora entre 11pm-6am Cancun (04:00-11:00 UTC)?
      → ¿Still > 1 hora sin interacción?
          → INVESTIGAR
      → ¿No?
          → HEARTBEAT_OK
  → ¿No?
      → HEARTBEAT_OK
```

**NO hay probabilidades.** Simple: de noche investigo, de día no.

---

## 📊 Frecuencia por Horario (Cancun UTC-5)

| Horario Cancun | Horario UTC | Acción |
|----------------|-------------|--------|
| **Noche (11pm-6am)** | 04:00-11:00 | Investigar si still > 1 hora |
| **Resto del día** | 11:00-04:00 | NO investigar, solo checks |

---

## 🔄 Checks por Heartbeat

### SIEMPRE (cada 30 min):
1. Gateway vivo → curl 127.0.0.1:18789
2. RAM/Disco → df -h, free -h
3. Contenedores → docker ps
4. Logs errores → tail /tmp/openclaw/*.log

### INVESTIGACIÓN (si still > 1 hora):
1. Verificar última interacción de Daniel
2. Si still → random check según probabilidad horario
3. Si toca investigar → elegir tema pendiente
4. Investigar y documentar en memory/investigaciones/

---

## 📝 Temas de Investigación Pendientes

1. **Búhos** - Simbolismo, mitología, sabiduría
2. **GLM-5 alternativas** - Antes de Abril 2026
3. **OpenClaw docs** - Novedades, best practices
4. **Optimización VPS** - Seguridad, performance
5. **Skills útiles** - ClawHub discoveries

---

## ⚙️ Cron Jobs Activos

| Nombre | Horario UTC | Frecuencia | Propósito |
|--------|-------------|------------|-----------|
| healthcheck:vps-daily | 06:00 | Diario | Salud del VPS |
| backup:workspace | 06:00 | Diario | Backup memoria |
| healthcheck:security-weekly | 09:00 Lun | Semanal | Auditoría seguridad |
| alert:glm5-expiry | 01 Mar 09:00 | One-shot | Aviso GLM-5 expira |
| alert:glm5-expiry-urgent | 15 Mar 09:00 | One-shot | Aviso urgente |

---

## 🚨 Alertas (solo si falla)

| Alerta | Condición | Acción |
|--------|-----------|--------|
| RAM crítica | >90% uso | Telegram inmediato |
| Disco lleno | >85% uso | Telegram inmediato |
| Gateway caído | No responde | Telegram + intento reinicio |
| Contenedor down | Algo no corre | Telegram con nombre |

---

## 📈 Tracking de Estado

Archivo: `memory/heartbeat-state.json`

```json
{
  "lastChecks": {
    "gateway": timestamp,
    "vps_health": timestamp,
    "containers": timestamp
  },
  "lastInteraction": timestamp,
  "stillMinutes": number,
  "investigationsToday": number
}
```

---

## 🔗 Links Importantes

- GLM-5 gratis: https://modal.com/blog/try-glm-5
- ClawHub: https://clawhub.ai/
- Docs: https://docs.openclaw.ai/
- GitHub: https://github.com/openclaw/openclaw

---

## 🛠️ Comandos

```bash
# Ver cron jobs
openclaw cron list

# Ejecutar job manualmente
openclaw cron run <job-id>

# Ver runs
openclaw cron runs <job-id>
```
