# Referencia: Free LLM APIs (GitHub cheahjs/free-llm-api-resources)

**ID:** REF-FREE-LLM-APIS-001
**Fuente:** https://github.com/cheahjs/free-llm-api-resources
**Revisado:** 2026-02-21

---

## TL;DR

Repo con lista de proveedores que ofrecen APIs de LLM gratis o con créditos de prueba.

---

## Proveedores 100% Gratis

| Proveedor | Límite | Modelos destacados |
|-----------|--------|-------------------|
| **OpenRouter** | 20 req/min, 50/día | Gemma 3 12B/27B, Llama 3.3 70B, Mistral Small 3.1 24B |
| **Google AI Studio** | Variable (generoso) | Gemini 1.5 Flash/Pro |
| **NVIDIA NIM** | API key gratis | Llama, Mistral, modelos optimizados |
| **Groq** | Rate limit variable | Llama 3.1 70B, Mixtral (muy rápido) |
| **HuggingFace Inference** | 30k chars/mes | Modelos open source |
| **Cohere** | Trial gratis | Command, Embed |
| **GitHub Models** | Con cuenta GitHub | Llama, Phi, otros |
| **Cloudflare Workers AI** | 10k req/día | Llama 2, Mistral |
| **Cerebras** | Rate limit variable | Llama 3 (muy rápido) |

---

## Con Créditos de Prueba

| Proveedor | Créditos | Nota |
|-----------|----------|------|
| **Modal** | $30/mes gratis | **Yo uso GLM-5 vía Modal** |
| **Fireworks** | $1 crédito | Modelos optimizados |
| **Baseten** | Créditos trial | Deployment de modelos |
| **Hyperbolic** | Créditos | Modelos open source |
| **SambaNova Cloud** | Trial gratis | Modelos enterprise |
| **Scaleway** | €20 trial | Deploy en Europa |

---

## Modelos Destacados en OpenRouter Gratis

| Modelo | Parámetros | Contexto | Uso ideal |
|--------|------------|----------|-----------|
| **Llama 3.3 70B Instruct** | 70B | 128k | Tareas complejas, razonamiento |
| **Gemma 3 27B Instruct** | 27B | 128k | Balance velocidad/calidad |
| **Mistral Small 3.1 24B** | 24B | 128k | Multilingual, eficiente |
| **Llama 3.2 3B Instruct** | 3B | 128k | Tareas simples, rápido |

---

## Recomendaciones para Daniel

### Para producción (clientes):
1. **Google AI Studio** → Gemini 1.5 Flash (gratis, rápido, buena calidad)
2. **Groq** → Llama 3.1 70B (muy rápido, bueno para batch)
3. **OpenRouter** → Flexibilidad de cambiar modelos

### Para desarrollo/testing:
1. **OpenRouter** → Variar modelos gratis
2. **HuggingFace** → Probar modelos nuevos
3. **GitHub Models** → Integración con repos

### Para mi uso personal:
1. **GLM-5 vía Modal** → Actual (gratis hasta Abril 2026)
2. **Post-Abril:** Migrar a OpenRouter Llama 3.3 70B o Groq

---

## Cómo usar OpenRouter

```bash
# Endpoint
https://openrouter.ai/api/v1/chat/completions

# Headers
Authorization: Bearer <OPENROUTER_API_KEY>
Content-Type: application/json

# Ejemplo curl
curl https://openrouter.ai/api/v1/chat/completions \
  -H "Authorization: Bearer $OPENROUTER_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "model": "meta-llama/llama-3.3-70b-instruct:free",
    "messages": [{"role": "user", "content": "Hello"}]
  }'
```

---

## Gotchas

- **OpenRouter:** Límite compartido entre modelos
- **Groq:** Rate limit agresivo, usar con cuidado
- **Google AI Studio:** Requiere Google account
- **HuggingFace:** 30k chars/mes es poco para uso intensivo
- **Modal:** GLM-5 gratis termina Abril 2026

---

## Próximos Pasos

1. Probar OpenRouter con Llama 3.3 70B
2. Evaluar Groq para tareas batch
3. Considerar Google AI Studio como fallback post-GLM-5

---

_Fuente: GitHub cheahjs/free-llm-api-resources_
_Revisado: 2026-02-21_
