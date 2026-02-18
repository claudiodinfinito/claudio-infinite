# Análisis In-Depth: Por Qué "No Funciona"

ID: TS-HEARTBEAT-001
Status: active
Tags: #debug #heartbeat #rate-limit #billing #critical
Keys: heartbeat, rate-limit, billing, glm5, claude, debug
Last reviewed: 2026-02-18

---

## Síntoma

Daniel dice "no funcionó de nuevo" - espera que el sistema trabaje autónomamente mientras duerme.

---

## Diagnóstico In-Depth

### 1. Gateway Status

```
Runtime: running (pid 1667948, state active)
RPC probe: ok
Listening: 127.0.0.1:18789
```

**Conclusión:** ✅ Gateway funciona correctamente.

### 2. Heartbeat Config

```json
"heartbeat": {
  "every": "30m",
  "target": "telegram",
  "to": "8596613010"
}
```

**Conclusión:** ✅ Configuración correcta (30 minutos).

### 3. Heartbeat Logs

```
10:33:50 UTC - embedded run start (heartbeat)
11:03:50 UTC - embedded run start (heartbeat)
```

**Conclusión:** ✅ Heartbeat SE EJECUTA cada 30 minutos.

### 4. Model Failures

**De los logs del gateway:**

```
[diagnostic] lane task error: lane=main 
  error="FailoverError: ⚠️ API rate limit reached. Please try again later."

[diagnostic] lane task error: lane=main 
  error="FailoverError: LLM request rejected: Your credit balance is too low 
         to access the Anthropic API."

All models failed (2):
  glm5/zai-org/GLM-5-FP8: rate_limit
  anthropic/claude-opus-4-5: billing
```

**Conclusión:** ❌ TODOS LOS MODELOS FALLAN.

---

## Root Cause Analysis

### Problema Principal: Rate Limit + Balance

**Modelo Primario (GLM-5):**
- Status: `rate_limit` - API rate limit reached
- Causa: Demasiadas requests en poco tiempo
- Impacto: No puedo generar respuestas

**Modelo Fallback (Claude):**
- Status: `billing` - Credit balance too low
- Causa: Sin créditos en Anthropic
- Impacto: Fallback no disponible

**Resultado:**
El heartbeat SE ejecuta, pero cuando intento procesar y responder, todos los modelos fallan.

---

## Por Qué Sucedió Esto

### 1. Uso intensivo de GLM-5

**Esta sesión:**
- Múltiples investigaciones (Google leak, Atomic Habits, subagentes)
- Descarga y análisis de archivos
- Múltiples mensajes largos
- Búsquedas web (Brave API)

**GLM-5 es gratis** - pero tiene rate limits.

### 2. Fallback sin créditos

Claude está configurado como fallback, pero:
- No hay créditos en Anthropic
- Solo sirve para emergencias
- No es solución permanente

---

## Timeline del Problema

| Hora | Evento |
|------|--------|
| 08:35 | Actualización a v2026.2.17 |
| 09:03 | Gateway restart |
| 09:15 | Auto-investigación (modelo OK) |
| 09:21 | Descarga v0.2.0 (modelo OK) |
| 09:36 | Rate limit hit en GLM-5 |
| 09:36 | Claude fallback falla (billing) |
| 10:33 | Heartbeat ejecuta pero sin respuesta |
| 11:03 | Heartbeat ejecuta pero sin respuesta |

**El rate limit se activó ~90 minutos después del inicio de la sesión.**

---

## Soluciones

### Plan A: Esperar Rate Limit Reset (Temporal)

**Qué:** GLM-5 rate limit se resetea automáticamente
**Cuándo:** Desconocido (depende de la política de Modal/Z.AI)
**Riesgo:** No hay control, puede pasar en minutos o horas

### Plan B: Añadir Créditos a Claude (Temporal)

**Qué:** Añadir créditos a Anthropic para activar fallback
**Costo:** Mínimo $5 USD
**Riesgo:** Costo recurrente, no es solución gratuita

### Plan C: Reducir Uso de Modelo (Preventivo)

**Qué:** Optimizar uso de modelo:
- Menos mensajes largos
- Más trabajo directo (exec, read, write)
- Menos síntesis en tiempo real
- Síntesis al final de la sesión

**Riesgo:** Menos interactividad, pero más sostenible

### Plan D: Alternativa a GLM-5 (Largo Plazo)

**Qué:** Buscar otro modelo gratuito/low-cost antes de Abril 2026
**Opciones:**
- Otros modelos en Modal
- Modelos locales (Ollama en VPS)
- Otros providers con free tier

**Riesgo:** Requiere investigación y migración

---

## Acciones Inmediatas

### Ahora Mismo

1. **Esperar rate limit reset** - No hay otra opción gratis
2. **Reducir uso de modelo** - Menos síntesis, más trabajo directo
3. **Documentar lección** - Esto es un learning importante

### Próxima Sesión

1. **Verificar créditos Claude** - ¿Daniel quiere añadir $5?
2. **Investigar alternativas** - Modelos locales, otros providers
3. **Optimizar uso** - Reducir carga en GLM-5

---

## Lecciones Aprendidas

### 1. "Gratis" tiene límites

GLM-5 es gratis, pero tiene rate limits. No es ilimitado.

### 2. Fallback sin créditos = Sin fallback

Configurar Claude como fallback sin créditos es inútil.

### 3. El heartbeat funciona, el modelo no

No es que "no funcione" - el sistema funciona, pero el modelo está limitado.

### 4. Uso intensivo = Rate limit rápido

Una sesión productiva puede agotar el rate limit en 90 minutos.

---

## Checklist de Recuperación

```
□ Verificar si rate limit se reseteó (probar mensaje simple)
□ Si no, esperar más tiempo
□ Si Daniel quiere, añadir créditos a Claude
□ Documentar alternativa a GLM-5
□ Optimizar uso de modelo en próximas sesiones
```

---

## Próximo Paso

**Cuando el rate limit se resete:**
1. Responder a Daniel con diagnóstico
2. Proponer soluciones
3. Implementar optimizaciones

**Ahora:**
- Trabajo directo (exec, read, write) que NO requiere modelo
- Documentar en archivos
- Esperar reset

---

_Diagnóstico completado: El sistema funciona, el modelo está en rate limit._
