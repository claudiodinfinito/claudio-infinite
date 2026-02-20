# DeepSeek V3.2 Reference

**Propósito:** DeepSeek como alternativa a GLM-5 post-Abril 2026.
**Contexto:** GLM-5 expira, necesito Plan B económico.

---

## ¿Qué es DeepSeek?

Modelo AI chino con pricing muy competitivo y rendimiento comparable a GPT-4.

| Característica | Valor |
|----------------|-------|
| **Modelo actual** | DeepSeek V3.2 |
| **Context window** | 128K tokens |
| **Provider** | DeepSeek API |
| **Disponibilidad** | Global |

---

## Pricing

| Tipo | DeepSeek V3.2 | Claude Haiku | GLM-5 |
|------|---------------|--------------|-------|
| **Input** | $0.27/M | $0.25/M | Gratis* |
| **Output** | $1.10/M | $1.25/M | Gratis* |
| **Cached Input** | $0.07/M | $0.30/M | N/A |

*GLM-5 gratis hasta Abril 2026

---

## Comparación de Rendimiento

| Benchmark | DeepSeek V3 | GPT-4o | Claude 3.5 Sonnet |
|-----------|-------------|--------|-------------------|
| MMLU | 88.5 | 88.7 | 88.3 |
| HumanEval | 89.2 | 90.2 | 92.0 |
| MATH | 75.9 | 76.6 | 78.3 |

**Conclusión:** Rendimiento muy cercano a GPT-4o, ligeramente inferior a Claude 3.5 Sonnet.

---

## Ventajas

| Ventaja | Descripción |
|---------|-------------|
| **Precio** | 90% más barato que GPT-4 |
| **Contexto largo** | 128K tokens |
| **Sin rate limit estricto** | Más flexible que GLM-5 |
| **Disponibilidad** | API estable |
| **Prompt caching** | Soportado, 74% más barato |

---

## Desventajas

| Desventaja | Descripción |
|------------|-------------|
| **Calidad ligeramente inferior** | vs Claude Sonnet |
| **Provider chino** | Consideraciones de datos |
| **Menos features** | Sin extended thinking |
| **Latencia** | Puede ser mayor |

---

## API Setup

```python
from openai import OpenAI

client = OpenAI(
    api_key="DEEPSEEK_API_KEY",
    base_url="https://api.deepseek.com"
)

response = client.chat.completions.create(
    model="deepseek-chat",
    messages=[{"role": "user", "content": "..."}]
)
```

**Compatible con OpenAI SDK** — fácil migración.

---

## Casos de Uso Recomendados

| ✅ Buen caso | ❌ Mejor otro modelo |
|--------------|---------------------|
| Chat conversacional | Razonamiento muy profundo |
| Generación de código simple | Código complejo |
| Análisis de documentos | Tareas que requieren Claude |
| Prototipado rápido | Producción crítica |

---

## En OpenClaw

**Plan de migración GLM-5 → DeepSeek:**

1. **Marzo 2026:** Testing con DeepSeek
2. **Abril 2026:** Migrar main model a DeepSeek
3. **Backup:** Claude Haiku para tareas críticas

**Config OpenClaw:**
```json
{
  "models": {
    "default": "deepseek/deepseek-chat",
    "fallback": ["google/gemini-3-flash", "anthropic/claude-3-haiku"]
  }
}
```

---

## Alternativas También Evaluar

| Alternativa | Pricing | Notas |
|-------------|---------|-------|
| **Ollama local** | Gratis | Requiere RAM, sin API |
| **MiniMax** | Gratis | Límites desconocidos |
| **Claude Haiku** | $1/M | Mejor calidad |

---

## Referencias

- [DeepSeek API Docs](https://platform.deepseek.com/api-docs/)
- TODO.md items #6, #28, #71
- `ref-glm5-alternatives.md`

---

_Creado: 2026-02-20 04:42 UTC - Micro-tarea autónoma_
