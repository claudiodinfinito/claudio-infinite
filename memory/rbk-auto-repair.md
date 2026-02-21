# Runbook: Auto-Reparación del Sistema

**ID:** RBK-AUTO-REPAIR-001
**Propósito:** Reparar problemas recurrentes sin intervención de Daniel
**Trigger:** Detectar fallo 2+ veces → ejecutar fix automáticamente

---

## 🚨 Regla de Oro

```
Si algo falla 2+ veces:
    1. INVESTIGAR causa raíz (logs, estado, config)
    2. PROPONER fix
    3. SI es seguro (no destructivo) → EJECUTAR fix
    4. DOCUMENTAR en runbook o memoria
    5. REPORTAR a Daniel

PRINCIPIO: No solo reportar errores, intentar repararlos.
```

---

## Patrones Conocidos y Fixes

### 1. Cronjob falla por contexto saturado

**Síntoma:**
- Error: "context overflow" o "prompt too large"
- Input tokens > 200k
- Cronjob estaba reutilizando sesión

**Fix:**
```bash
# Añadir deleteAfterRun al cronjob
openclaw cron update <job-id> --patch '{"deleteAfterRun": true}'
```

**Preventivo:** Todos los cronjobs aislados deben tener `deleteAfterRun: true`

---

### 2. Sesión bloqueada por .lock file

**Síntoma:**
- Gateway responde pero sesión no avanza
- Archivo `.lock` existe en sessions/

**Fix:**
```bash
# Eliminar locks huérfanos
find /root/.openclaw -name "*.lock" -type f -delete
```

---

### 3. Container Docker en estado "exited"

**Síntoma:**
- `docker ps -a` muestra container con state "exited"
- Container secundario/duplicado

**Fix:**
```bash
# Eliminar container muerto
docker rm <container-id>

# Si es servicio principal, reiniciar
docker restart <container-name>
```

---

### 4. Rate limit en APIs

**Síntoma:**
- Error 429 de GLM-5, Gemini, o Claude
- Múltiples requests en corto tiempo

**Fix:**
- GLM-5: Esperar 1 min, reintentar
- Gemini: Límite 20/día → cambiar a GLM-5 temporalmente
- Claude: Verificar créditos

**Preventivo:** Trackear uso en `memory/brave-usage.json`

---

### 5. Disco lleno (logs/tmp)

**Síntoma:**
- `df -h /` muestra >90% uso
- Servicios fallando sin razón aparente

**Fix:**
```bash
# Limpiar logs antiguos
find /var/log -type f -name "*.log" -mtime +30 -delete

# Limpiar tmp
find /tmp -type f -mtime +7 -delete

# Docker cleanup
docker system prune -f
```

---

### 6. Cronjob "announce delivery failed"

**Síntoma:**
- Cronjob ejecuta OK pero delivery falla
- Error: "cron announce delivery failed"

**Causas posibles:**
- Rate limit del modelo
- Contexto saturado
- Canal Telegram temporalmente no disponible

**Fix:**
1. Verificar que `deleteAfterRun: true` está configurado
2. Verificar que el modelo no tiene rate limit
3. Reintentar en siguiente ciclo

---

## Anti-Patrones (NO hacer)

- ❌ Reiniciar gateway sin investigar primero
- ❌ Borrar datos sin backup
- ❌ Cambiar config crítica sin confirmación
- ❌ Ejecutar `docker system prune -a` (borra todo)
- ❌ Eliminar containers con prefijo `srv-captain--` (CapRover)

---

## Checklist de Diagnóstico

Cuando algo falla, verificar en orden:

1. **Logs:** `tail -100 /tmp/openclaw/openclaw-$(date +%Y-%m-%d).log`
2. **Estado:** `openclaw gateway status`
3. **Sesiones:** `find /root/.openclaw -name "*.lock"`
4. **Containers:** `docker ps -a`
5. **Disco:** `df -h /`
6. **RAM:** `free -h`
7. **Cronjobs:** `openclaw cron list`

---

## Auto-Reparación Automática

| Evento | Acción automática |
|--------|-------------------|
| Cronjob 2 errores seguidos | Investigar + proponer fix |
| .lock file detectado | Eliminar + reportar |
| Container exited | Eliminar + reportar |
| Contexto >180k tokens | Alertar + sugerir /new |
| Disco >85% | Limpiar logs + reportar |

---

_Creado: 2026-02-21_
_Lección: El cron de micro-tareas falló 20+ veces antes de que Daniel me pidiera arreglarlo. Nunca más._
