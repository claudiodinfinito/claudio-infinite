# Model Selection Decision Tree

**Propósito:** Decision tree para elegir modelo AI según tarea.
**Contexto:** Múltiples modelos disponibles, elegir el óptimo por costo/calidad.

---

## Decision Tree

```
¿Necesitas razonamiento profundo?
├── SÍ → Claude Sonnet (extended thinking)
│   └── Budget limitado → Gemini 3 Flash
└── NO
    └── ¿Tarea simple/rápida?
        ├── SÍ → GLM-5 (gratis, 1 concurrente)
        │   └── GLM-5 ocupado → Gemini 3 Flash
        └── NO → ¿Análisis código/repos?
            ├── SÍ → Gemini 3 Flash (bueno analizando)
            └── NO → Claude Haiku ($1/M, rápido)
```

---

## Por Tarea

| Tarea | Modelo Óptimo | Alternativa |
|-------|---------------|-------------|
| Chat simple | GLM-5 | Gemini 3 Flash |
| Investigación web | GLM-5 | Gemini 3 Flash |
| Análisis código | Gemini 3 Flash | Claude Sonnet |
| Razonamiento complejo | Claude Sonnet + thinking | Gemini 3 Flash |
| Respuesta rápida | Claude Haiku | GLM-5 |
| Matemáticas exactas | Subagente DB | Claude Sonnet |
| Q&A debate | Gemini 3 Flash | GLM-5 |

---

## Por Costo

| Modelo | Input | Output | Notas |
|--------|-------|--------|-------|
| **GLM-5** | Gratis | Gratis | 1 concurrente, expira Abril 2026 |
| **Gemini 3 Flash** | Gratis | Gratis | 20/día |
| **Claude Haiku** | $0.25/M | $1.25/M | Mejor calidad que gratis |
| **Claude Sonnet** | $3/M | $15/M | Premium, extended thinking |
| **DeepSeek V3.2** | $0.27/M | $1.1/M | Alternativa a Haiku |

---

## Límites Actuales

| Modelo | Límite | Reset |
|--------|--------|-------|
| GLM-5 | 1 request concurrente | Por sesión |
| Gemini 3 Flash | 20/día | Diario UTC |
| Brave Search | 1,500/mes | Mensual |

---

## Flujo en OpenClaw

1. **Intentar GLM-5 primero** (gratis, main model)
2. **Si rate limit → Gemini 3 Flash** (subagent model)
3. **Si tarea compleja → Claude** (con budget tracking)

---

## GLM-5 Post-Abril 2026

**Plan B:**
1. **DeepSeek V3.2** — pricing similar a Haiku
2. **Ollama local** — verificar RAM (necesito 8GB+)
3. **MiniMax** — alternativa gratuita
4. **Claude Haiku** — $1/M, muy económico

---

## Heurística Rápida

| Si... | Entonces... |
|-------|-------------|
| GLM-5 disponible | Úsalo |
| GLM-5 ocupado + tarea simple | Gemini 3 Flash |
| Necesitas calidad | Claude Haiku |
| Necesitas profundidad | Claude Sonnet |
| Presupuesto ajustado | DeepSeek |

---

## Referencias

- TODO.md items #6, #26, #27, #28
- `ref-model-limits.md`
- `ref-glm5-alternatives.md`

---

_Creado: 2026-02-20 04:37 UTC - Micro-tarea autónoma_
