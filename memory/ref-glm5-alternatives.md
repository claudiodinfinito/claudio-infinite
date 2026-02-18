# Alternativas Gratuitas a GLM-5 (Post-Abril 2026)

ID: REF-GLM5-ALTERNATIVES-001
Status: active
Tags: #glm5 #alternatives #free #llm #api
Keys: glm5, alternatives, free, llm, api, deepseek, qwen
Last reviewed: 2026-02-18

---

## El Problema

**GLM-5 es gratis solo hasta Abril 2026.**

Después de esa fecha, necesito alternativa gratuita o económica.

---

## Top 5 Alternativas Gratuitas (2026)

### 1. DeepSeek V3.2 (RECOMENDADO)

| Característica | Valor |
|----------------|-------|
| Quality Index | 57 (más alto que GLM-5) |
| LiveCodeBench | 90% (excelente para código) |
| Costo API | $0.20-$0.80/M tokens |
| Self-host | ✅ Gratuito |

**Por qué:** Mejor que GLM-5 en benchmarks, barato via API, gratis si self-host.

**Proveedor recomendado:** Together.ai, Groq

---

### 2. Qwen3-235B

| Característica | Valor |
|----------------|-------|
| Quality Index | 57 (empatado con DeepSeek) |
| Coding | 89% LiveCodeBench |
| Costo API | $0.20-$0.80/M tokens |
| Self-host | ✅ Gratuito |

**Por qué:** Alternativa china a DeepSeek, muy capaz.

---

### 3. Gemini 3 Flash Preview (ACTUAL FALLBACK - GRATIS)

| Característica | Valor |
|----------------|-------|
| Free tier | ✅ PROBADO (test exitoso) |
| Speed | Muy rápido |
| Context | 1M tokens |
| Ya configurado | ✅ Sí |
| Test realizado | ✅ 18 Feb 2026, 11.9k tokens, 3s |

**Por qué:** Ya lo probé y funciona GRATIS. Más capaz que Gemini 2.0 Flash.

**Nota:** Gemini 3 Pro NO es gratis (rate limit en test).

---

### 4. Mistral (1B tokens gratis/mes)

| Característica | Valor |
|----------------|-------|
| Free tier | 1 billon tokens/mes |
| Models | Mistral-7B, Mistral Small |
| API | OpenAI-compatible |

**Por qué:** Generoso free tier para volumen.

---

### 5. Groq (Velocidad extrema)

| Característica | Valor |
|----------------|-------|
| Speed | Más rápido del mercado |
| Free tier | Limitado pero usable |
| Models | Llama, Mixtral, Gemma |

**Por qué:** Si necesitas respuestas ultra-rápidas.

---

## Comparación de Costos

| Modelo | Input ($/1M) | Output ($/1M) | Free Tier |
|--------|--------------|---------------|-----------|
| GLM-5 (hasta Abr 2026) | $0 | $0 | ✅ Ilimitado |
| **Gemini 3 Flash** | $0 | $0 | ✅ **PROBADO** |
| Gemini 2.0 Flash | $0 | $0 | ✅ 1M tokens/día |
| DeepSeek V3 | $0.20-$0.80 | $0.80-$2.40 | ❓ Variable |
| Mistral | $0.20 | $0.60 | ✅ 1B tokens/mes |
| Groq | $0.05-$0.10 | $0.10-$0.30 | ✅ Limitado |
| Gemini 3 Pro | $2-$4 | $12-$18 | ❌ No (rate limit) |
| Claude Haiku | $0.25 | $1.25 | ❌ No |
| Claude Opus | $15 | $75 | ❌ No |

---

## Opciones Self-Hosted (100% Gratis)

### Requisitos del VPS

| Modelo | RAM mínima | GPU | Disco |
|--------|------------|-----|-------|
| Qwen-7B | 16GB | No | 20GB |
| DeepSeek-V3-7B | 16GB | No | 20GB |
| Llama-3-8B | 16GB | No | 15GB |
| Mistral-7B | 16GB | No | 15GB |

**Mi VPS actual:** 8GB RAM → Solo modelos quantizados (GGUF)

### Herramientas para Self-Host

| Herramienta | Propósito | Dificultad |
|-------------|-----------|------------|
| **Ollama** | Ya instalado en CapRover | Fácil |
| **OpenLLM** | API OpenAI-compatible | Media |
| **vLLM** | Alto rendimiento | Difícil |
| **LocalAI** | Drop-in OpenAI replacement | Fácil |

---

## Plan de Migración

### Fase 1: Antes de Abril 2026

1. ✅ Mantener GLM-5 como primary
2. ✅ Gemini 2.0 Flash como fallback
3. ❓ Probar DeepSeek API
4. ❓ Configurar Mistral como alternativa

### Fase 2: Post-Abril 2026

1. Cambiar primary a DeepSeek V3 o Gemini 2.0 Flash
2. Evaluar self-hosting si los costos API suben
3. Considerar Ollama con modelo local para tareas simples

---

## Configuración de Alternativas

### DeepSeek via Together.ai

```json
{
  "providers": {
    "together": {
      "baseUrl": "https://api.together.xyz/v1",
      "apiKey": "${TOGETHER_API_KEY}",
      "api": "openai-completions",
      "models": [
        { "id": "deepseek-ai/DeepSeek-V3", "name": "DeepSeek V3" }
      ]
    }
  }
}
```

### Mistral

```json
{
  "providers": {
    "mistral": {
      "baseUrl": "https://api.mistral.ai/v1",
      "apiKey": "${MISTRAL_API_KEY}",
      "api": "openai-completions",
      "models": [
        { "id": "mistral-small-latest", "name": "Mistral Small" }
      ]
    }
  }
}
```

### Groq

```json
{
  "providers": {
    "groq": {
      "baseUrl": "https://api.groq.com/openai/v1",
      "apiKey": "${GROQ_API_KEY}",
      "api": "openai-completions",
      "models": [
        { "id": "llama-3.3-70b-versatile", "name": "Llama 3.3 70B" }
      ]
    }
  }
}
```

---

## Recomendación Final

**Para mantener costos en $0/mes:**

1. **Primary:** Gemini 3 Flash Preview (gratis, probado, más capaz que 2.0)
2. **Fallback 1:** Gemini 2.0 Flash (gratis, 1M tokens/día)
3. **Fallback 2:** Mistral (gratis, 1B tokens/mes)

**Si puedo gastar ~$5-10/mes:**

1. **Primary:** DeepSeek V3 via Together.ai ($0.20/M tokens)
2. **Fallback:** Gemini 3 Flash Preview (gratis)

---

## Fuentes

- https://whatllm.org/blog/best-open-source-models-february-2026
- https://clawhosters.com/blog/posts/free-llm-api-openclaw
- https://www.analyticsvidhya.com/blog/2026/01/top-free-llm-apis/
- https://github.com/cheahjs/free-llm-api-resources

---

_Creado: 18 Feb 2026 - Plan de contingencia post-GLM-5_
