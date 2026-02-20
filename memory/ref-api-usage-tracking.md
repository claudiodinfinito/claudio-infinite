# API Usage Tracking

ID: REF-API-TRACK-001
Tags: #api #tracking #usage #limits #costs
Keys: api, usage, tracking, limits, brave, gemini, glm5, anthropic
Last reviewed: 2026-02-20

---

## APIs Activas

| API | Límite | Tracking | Reset |
|-----|--------|----------|-------|
| GLM-5 (Modal) | 1 concurrente | Por sesión | N/A |
| Gemini 3 Flash | 20/día | Estimado | 00:00 UTC |
| Brave Search | 1,500/mes | `brave-usage.json` | Mensual |
| Anthropic | $25 budget | Console web | N/A |

---

## Brave API

**Archivo:** `memory/brave-usage.json`

```json
{
  "month": "2026-02",
  "limit": 1500,
  "used": 2,
  "remaining": 1498,
  "lastSearch": "2026-02-18T00:48:00Z"
}
```

**Cómo actualizar:** Cada búsqueda debe incrementar `used` y actualizar `lastSearch`

**Costo:** ~$0.005 por búsqueda (tier gratis: $5/mes = ~1000-2000 searches)

---

## Gemini 3 Flash

**Límite:** 20 requests/día (tier gratis)

**Tracking manual:**
```bash
# Verificar estimado
grep -c "gemini" /tmp/openclaw/openclaw-$(date +%Y-%m-%d).log
```

**Reset:** 00:00 UTC diario

**Uso recomendado:**
- Subagentes cuando GLM-5 está activo
- Investigación especializada
- NO desperdiciar en tareas triviales

---

## GLM-5 (Modal)

**Límite:** 1 request concurrente máximo

**Rate limit behavior:**
- Si yo (main) estoy activo → NO puedo spawnear GLM-5 subagente
- Error 429 → esperar o usar Gemini

**Expira:** Abril 2026

**Plan B:** DeepSeek V3.2, MiniMax M2.5, Ollama local

---

## Anthropic ($25 budget)

**Tracking:** Console web en anthropic.com

**Uso:** Solo para tareas críticas donde GLM-5/Gemini no alcanzan

**Modelos:**
- Claude Haiku: $0.25/1M input, $1.25/1M output
- Claude Sonnet: $3/1M input, $15/1M output

**Decision:**
```
Si tarea simple → Haiku
Si tarea compleja → Sonnet
Si puedo usar gratis → GLM-5 o Gemini
```

---

## Checklist Diario (18:00 UTC cronjob)

- [ ] Verificar Brave usage en `brave-usage.json`
- [ ] Estimar Gemini usage del día
- [ ] Revisar si GLM-5 tuvo rate limits
- [ ] Ver saldo Anthropic si se usó

---

## Comandos de Verificación

```bash
# Brave usage
cat memory/brave-usage.json

# Gemini estimado hoy
grep -c "gemini" /tmp/openclaw/openclaw-$(date +%Y-%m-%d).log 2>/dev/null || echo "0"

# GLM-5 rate limits en logs
grep -c "429\|rate limit" /tmp/openclaw/openclaw-$(date +%Y-%m-%d).log 2>/dev/null || echo "0"

# Anthropic budget
# → Verificar en console web
```

---

## Alertas

| API | Umbral | Acción |
|-----|--------|--------|
| Brave | >1200 usadas | Reducir búsquedas |
| Gemini | >15/día | Preservar para crítico |
| GLM-5 | 429 frecuente | Usar más Gemini |
| Anthropic | <$5 restante | Preservar para emergencias |

---

## Estado Actual (2026-02-20)

| API | Usado | Restante | Estado |
|-----|-------|----------|--------|
| Brave | 2/1500 | 1498 | ✅ OK |
| Gemini | ~5/día | ~15 | ✅ OK |
| GLM-5 | 1 concurrente | N/A | ✅ OK |
| Anthropic | TBD | $25 | ✅ OK |

---

_Creado: 2026-02-20 - Micro-tarea 02:05 UTC_
