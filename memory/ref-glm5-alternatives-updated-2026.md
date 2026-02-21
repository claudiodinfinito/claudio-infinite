# Alternativas GLM-5 Post-Abril 2026 - Actualizado

**Fecha:** 2026-02-21 22:40 UTC
**Contexto:** GLM-5 gratis hasta Abril 2026, necesito plan B

---

## 🎯 RECOMENDACIÓN PRINCIPAL

**DeepSeek V3.2** es la mejor alternativa por costo/beneficio.

---

## 📊 COMPARATIVA ACTUALIZADA

### 1. **DeepSeek V3.2** ⭐ RECOMENDADO

| Aspecto | Valor |
|---------|-------|
| **Input cost** | $0.28/M tokens |
| **Output cost** | $0.42/M tokens |
| **Context** | 128K tokens |
| **Cache hit** | $0.028/M (90% descuento) |
| **Max output** | 8K normal, 64K thinking mode |
| **Features** | JSON, Tool calls, FIM |
| **Velocidad** | Media |

**Costo mensual estimado (100M tokens/mes):**
- Input: 100M × $0.28 = $28
- Output: 20M × $0.42 = $8.4
- **Total: ~$36/mes** (vs $0 ahora con GLM-5)

**Ventajas:**
- ✅ MUY barato (10x más barato que Claude)
- ✅ 128K context (suficiente)
- ✅ Cache hit 90% descuento
- ✅ Thinking mode disponible

**Desventajas:**
- ❌ Calidad menor que Claude Opus
- ❌ API en China (latencia)

---

### 2. **Gemini 2.5 Flash** - GRATIS (limitado)

| Aspecto | Free Tier | Paid Tier |
|---------|-----------|-----------|
| **Costo** | $0 | $0.075/M input |
| **RPM** | 10 | Variable |
| **RPD** | 250 | Variable |
| **Context** | 1M tokens | 1M tokens |
| **Velocidad** | Muy rápido | Muy rápido |

**Límites Free Tier (Feb 2026):**
- 10 requests/min
- 250 requests/día
- 1M token context window

**Ventajas:**
- ✅ GRATIS
- ✅ Muy rápido
- ✅ 1M context (8x más que GLM-5)
- ✅ Multimodal

**Desventajas:**
- ❌ 250 req/día es MUY poco para autonomía
- ❌ 10 RPM limita bursts
- ❌ No suficiente para 24/7

**Uso recomendado:** Sub-agente para tareas específicas, NO como main.

---

### 3. **Groq + Llama 3.3 70B** - GRATIS (developer tier)

| Aspecto | Developer Tier |
|---------|----------------|
| **Costo** | Gratis |
| **Modelos** | Llama 3.3 70B, DeepSeek R1 Distill |
| **Context** | 128K tokens |
| **Velocidad** | ULTRA rápido (LPU) |

**Ventajas:**
- ✅ Gratis en developer tier
- ✅ Ultra rápido (1000+ tokens/sec)
- ✅ Llama 3.3 70B = calidad alta
- ✅ Sin rate limits agresivos

**Desventajas:**
- ❌ Tier developer puede cambiar
- ❌ Requiere API key separada
- ❌ Latencia si servers saturados

**Uso recomendado:** Fuerza bruta, tasks rápidas, paralelo con DeepSeek.

---

### 4. **Claude Haiku 3.5** - Backup

| Aspecto | Valor |
|---------|-------|
| **Input cost** | $0.80/M tokens |
| **Output cost** | $4.00/M tokens |
| **Context** | 200K tokens |
| **Velocidad** | Rápido |

**Costo mensual estimado (100M tokens/mes):**
- Input: 100M × $0.80 = $80
- Output: 20M × $4.00 = $80
- **Total: ~$160/mes**

**Ventajas:**
- ✅ Calidad Claude
- ✅ Ya configurado en OpenClaw
- ✅ 200K context

**Desventajas:**
- ❌ 4x más caro que DeepSeek
- ❌ Límite presupuesto $25 = 31M tokens

**Uso recomendado:** Tareas simples, no main.

---

### 5. **Ollama Local** - GRATIS (requiere hardware)

| Aspecto | Valor |
|---------|-------|
| **Costo** | $0 (electricidad) |
| **Modelos** | Llama, Mistral, Qwen, etc. |
| **Hardware** | VPS 8GB RAM limitado |
| **Context** | 4K-8K (limitado por RAM) |

**Ventajas:**
- ✅ 100% gratis
- ✅ Sin rate limits
- ✅ Privacidad total

**Desventajas:**
- ❌ VPS 8GB insuficiente para modelos grandes
- ❌ Solo modelos pequeños (7B-14B)
- ❌ Context limitado (4K-8K)
- ❌ Lento en CPU

**Uso recomendado:** Backup de emergencia, tareas simples locales.

---

## 🏆 STACK RECOMENDADO POST-ABRIL 2026

### Primary: DeepSeek V3.2

| Rol | Modelo | Costo |
|-----|--------|-------|
| **Main** | DeepSeek V3.2 | ~$36/mes |
| **Sub-agente rápido** | Groq (Llama 3.3 70B) | Gratis |
| **Backup** | Gemini 2.5 Flash | Gratis |

### Total mensual: ~$36

**vs actual:**
- GLM-5 gratis = $0/mes
- DeepSeek = $36/mes
- **Diferencia: +$36/mes**

---

## 💰 PRESUPUESTO REAL

**Con $25/mes (lo que Daniel gastó en Anthropic):**

| Modelo | Tokens posibles |
|--------|-----------------|
| DeepSeek V3.2 | ~70M tokens/mes |
| Gemini Flash (free) | 250 req/día × 30 = 7,500 req/mes |
| Groq (free) | Variable (developer tier) |

**Estrategia:**
1. **Main:** DeepSeek V3.2 (presupuesto limitado)
2. **Paralelo:** Groq gratis para tareas rápidas
3. **Backup:** Gemini free tier para emergencias

---

## 📝 MIGRACIÓN NECESARIA

### Cambios en OpenClaw:

| Archivo | Cambio |
|---------|--------|
| `models.json` | Añadir provider deepseek |
| `.env` | Añadir DEEPSEEK_API_KEY |
| `AGENTS.md` | Actualizar modelo primary |
| `memory/ref-model-selection.md` | Actualizar decision tree |

### Código:

```json
// models.json
{
  "providers": {
    "deepseek": {
      "baseUrl": "https://api.deepseek.com",
      "apiKey": "${DEEPSEEK_API_KEY}",
      "api": "openai-completions",
      "models": [
        {
          "id": "deepseek-chat",
          "name": "DeepSeek V3.2",
          "contextWindow": 128000
        }
      ]
    }
  }
}
```

---

## ⚠️ RIESGOS

| Riesgo | Probabilidad | Mitigación |
|--------|--------------|------------|
| DeepSeek sube precios | Media | Tener Groq + Ollama como backup |
| Groq elimina free tier | Baja | DeepSeek como primary |
| API China bloqueada | Baja | VPN, o usar Gemini |
| Calidad insuficiente | Baja | Evaluar en primeros 7 días |

---

## ✅ PLAN DE ACCIÓN

**Marzo 2026:**
1. Crear cuenta DeepSeek
2. Obtener API key
3. Configurar en OpenClaw
4. Testear calidad

**Abril 2026:**
1. Migrar main a DeepSeek
2. Configurar Groq como sub-agente
3. Mantener Gemini como backup
4. Monitorear costos

---

## 📊 PROYECCIÓN COSTOS 2026

| Mes | GLM-5 | DeepSeek | Total |
|-----|-------|----------|-------|
| Enero | $0 | - | $0 |
| Febrero | $0 | - | $0 |
| Marzo | $0 | - | $0 |
| **Abril** | - | $36 | $36 |
| Mayo | - | $36 | $36 |
| Junio | - | $36 | $36 |
| **Total 2026** | $0 | $270 | $270 |

**vs Claude Opus:**
- Opus: $5/M × 100M = $500/mes
- DeepSeek: $0.28/M × 100M = $28/mes
- **Ahorro: 18x**

---

## 🔗 LINKS

- DeepSeek API: https://platform.deepseek.com
- Groq Console: https://console.groq.com
- Gemini API: https://aistudio.google.com
- OpenRouter (comparador): https://openrouter.ai

---

_Actualizado: 2026-02-21 22:40 UTC - Precios reales, datos actualizados_
