# Free LLM APIs Sin Login Complejo

ID: REF-FREE-LLM-APIS-001
Status: active
Tags: #free #llm #api #no-login
Keys: free, llm, api, openrouter, groq, mistral
Last reviewed: 2026-02-21

---

## APIs 100% Gratis (Sin Login Complejo)

### 1. OpenRouter (MEJOR OPCIÓN)

| Característica | Valor |
|----------------|-------|
| Límites | 20 req/min, 50/día gratis |
| Con $10 topup | 1000 req/día |
| Login | Solo API key |
| URL | https://openrouter.ai |

**Modelos gratis disponibles:**
- Llama 3.3 70B Instruct (potente)
- Mistral Small 3.1 24B
- Gemma 3 27B Instruct
- Qwen3 Coder
- DeepSeek R1 (reasoning)

**Config OpenClaw:**
```json
{
  "providers": {
    "openrouter": {
      "baseUrl": "https://openrouter.ai/api/v1",
      "apiKey": "${OPENROUTER_API_KEY}",
      "api": "openai-completions",
      "models": [
        { "id": "meta-llama/llama-3.3-70b-instruct:free", "name": "Llama 3.3 70B" },
        { "id": "mistralai/mistral-small-3.1-24b-instruct:free", "name": "Mistral Small" }
      ]
    }
  }
}
```

---

### 2. Google AI Studio

| Característica | Valor |
|----------------|-------|
| Límites | 250k tokens/min, 20 req/día |
| Login | Google account |
| URL | https://aistudio.google.com |

**Modelos:**
- Gemini 3 Flash (el mejor gratis)
- Gemini 2.5 Flash

**Nota:** Data usada para training fuera de EU/UK/CH/EEA.

---

### 3. Groq (Más Rápido)

| Característica | Valor |
|----------------|-------|
| Velocidad | Ultra rápido (LPU) |
| Login | API key |
| URL | https://console.groq.com |

**Modelos:**
- Llama 3.3 70B Versatile
- Mixtral 8x7B
- Gemma 2 9B

---

### 4. Mistral (1B Tokens Gratis)

| Característica | Valor |
|----------------|-------|
| Límites | 1 billon tokens/mes gratis |
| Login | API key |
| URL | https://console.mistral.ai |

**Modelos:**
- Mistral Small (bueno para tareas simples)
- Codestral (código)

---

### 5. Cerebras (Ultra Rápido)

| Característica | Valor |
|----------------|-------|
| Velocidad | Más rápido que Groq |
| Login | API key |
| URL | https://cloud.cerebras.ai |

---

## Proveedores con Trial Credits

| Proveedor | Créditos | Requisito |
|-----------|----------|-----------|
| Modal | $30/mes gratis | Signup |
| Fireworks | Trial credits | Signup |
| Hyperbolic | Trial credits | Signup |
| SambaNova | Trial credits | Signup |

---

## Recomendación para OpenClaw

**Stack gratuito óptimo:**

1. **Primary:** GLM-5 via Modal (gratis hasta Abril 2026)
2. **Fallback 1:** Gemini 3 Flash (Google AI Studio)
3. **Fallback 2:** Llama 3.3 70B (OpenRouter)
4. **Fallback 3:** Mistral Small

**Para sub-agentes:**
- OpenRouter (simple, muchos modelos)
- Groq (si necesito velocidad)

---

## Cómo Obtener API Keys

### OpenRouter:
1. Ir a https://openrouter.ai/keys
2. Crear cuenta (Google/GitHub login)
3. Generar API key
4. Añadir a `.env`: `OPENROUTER_API_KEY=sk-or-...`

### Groq:
1. Ir a https://console.groq.com/keys
2. Signup
3. Crear API key
4. Añadir a `.env`: `GROQ_API_KEY=gsk_...`

### Mistral:
1. Ir a https://console.mistral.ai
2. Signup
3. Crear API key
4. Añadir a `.env`: `MISTRAL_API_KEY=...`

---

## Comparativa de Velocidad

| Proveedor | Tokens/seg | Latencia |
|-----------|------------|----------|
| Cerebras | ~1000 | Ultra bajo |
| Groq | ~500 | Muy bajo |
| OpenRouter | ~50-100 | Variable |
| Google AI Studio | ~100 | Bajo |
| Mistral | ~50 | Medio |

---

## Fuentes

- https://github.com/cheahjs/free-llm-api-resources
- https://openrouter.ai/docs
- https://console.groq.com
- https://aistudio.google.com

---

_Creado: 2026-02-21 - Análisis de APIs gratuitas sin login complejo_
