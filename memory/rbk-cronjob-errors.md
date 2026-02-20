# Runbook: Cronjob Errors

**Síntoma:** Cronjobs marcados como "error" en `openclaw cron list`
**Causa común:** Rate limit GLM-5 (1 request concurrente)

---

## Diagnóstico Rápido

```bash
# Ver estado de cronjobs
openclaw cron list

# Ver logs del job específico
openclaw cron runs <job-id>
```

---

## Flujo de Diagnóstico

```
Cronjob en ERROR
    ↓
¿El modelo es GLM-5?
├── SÍ → ¿Hay otro GLM-5 activo?
│   ├── SÍ → Rate limit → Esperar o usar Gemini
│   └── NO → Verificar payload/config
└── NO → Verificar logs específicos
```

---

## Errores Comunes

### 1. Rate Limit GLM-5 (429)

**Síntoma:** `"API rate limit reached"` o `"gateway timeout"`

**Causa:** GLM-5 = 1 request concurrente. Si main session activa, cronjob falla.

**Fix:**
- Opción A: Cambiar modelo del cronjob a Gemini
- Opción B: Programar cronjobs en horarios sin main session activa
- Opción C: Usar systemEvent en lugar de agentTurn para alerts

### 2. Session Locked

**Síntoma:** `"session locked"` en logs

**Causa:** Sesión previa no terminó correctamente, quedó lock.

**Fix:**
```bash
# Ver locks
ls /tmp/openclaw/*.lock

# Eliminar locks huérfanos
rm /tmp/openclaw/*.lock
```

### 3. Gateway Timeout

**Síntoma:** `"gateway timeout"` después de 30+ segundos

**Causa:** Modelo tarda demasiado en responder.

**Fix:**
- Aumentar timeout en config del cronjob
- Simplificar prompt del task
- Usar modelo más rápido

### 4. Delivery Failed

**Síntoma:** Job ejecuta pero no entrega mensaje a Telegram

**Causa:** Canal no configurado o token inválido.

**Fix:**
```bash
# Verificar configuración de canal
openclaw doctor

# Ver logs de delivery
tail -f /tmp/openclaw/openclaw-$(date +%Y-%m-%d).log
```

---

## Cronjobs Actuales con Error (2026-02-20 11:36 UTC)

| Job ID | Nombre | Último run | Causa Probable |
|--------|--------|------------|----------------|
| `53cc6fb2-b188-427f-956a-504c1261beb2` | healthcheck:vps-daily | 6h ago | Rate limit GLM-5 |
| `3228f35b-2e5f-4512-9105-7219b752924e` | daily-log-update | 14h ago | Rate limit GLM-5 |

**Estado:** Ambos jobs programados para correr nuevamente (healthcheck en 18h, daily-log en 10h).

**Acción recomendada:**
1. Cambiar modelo a Gemini en ambos jobs
2. O usar `systemEvent` en lugar de `agentTurn` para alerts simples

---

## Prevención

| Práctica | Descripción |
|----------|-------------|
| **Modelos separados** | Main = GLM-5, Cronjobs = Gemini |
| **Horarios distintos** | Evitar superposición de GLM-5 jobs |
| **Timeout apropiado** | Ajustar según complejidad del task |
| **Monitoreo** | Revisar `openclaw cron list` diario |

---

## Comandos de Referencia

```bash
# Listar todos los jobs
openclaw cron list

# Ver runs de un job
openclaw cron runs <job-id>

# Ejecutar job manualmente
openclaw cron run <job-id>

# Logs en tiempo real
tail -f /tmp/openclaw/openclaw-$(date +%Y-%m-%d).log

# Ver estado gateway
openclaw gateway status
```

---

_Creado: 2026-02-20 05:32 UTC - Micro-tarea autónoma_
