# Claude Prompt Caching Reference

**Propósito:** Documentar prompt caching de Anthropic para optimizar costos.
**Beneficio:** Hasta 90% ahorro en tokens cacheados.

---

## ¿Qué es Prompt Caching?

Claude puede "recordar" partes del prompt entre llamadas, cobrando solo por los tokens nuevos.

| Sin Cache | Con Cache |
|-----------|-----------|
| Cobran todos los tokens cada vez | Tokens cacheados = 10% del precio |
| Context largo = caro | Context largo = barato después del primer uso |
| $3/M input tokens | $0.30/M cached tokens |

---

## Cómo Funciona

```python
# Ejemplo Python
response = client.messages.create(
    model="claude-3-5-sonnet-20241022",
    system=[
        {
            "type": "text",
            "text": "Sistema largo que no cambia...",
            "cache_control": {"type": "ephemeral"}
        }
    ],
    messages=[
        {
            "role": "user",
            "content": [
                {
                    "type": "text",
                    "text": "Documento largo...",
                    "cache_control": {"type": "ephemeral"}
                }
            ]
        }
    ]
)
```

---

## Dónde Aplicar

| Caso de Uso | Beneficio |
|-------------|-----------|
| System prompts largos | Se cachea una vez, reusa gratis |
| Documentos de referencia | El documento se cachea |
| Conversaciones multi-turno | Historia cacheada |
| Tools/funciones definidas | Definición cacheada |

---

## Límites

| Modelo | Min Tokens para Cache | Cache TTL |
|--------|----------------------|-----------|
| Claude 3.5 Sonnet | 1,024 tokens | 5 min default |
| Claude 3.5 Haiku | 1,024 tokens | 5 min default |
| Claude 3 Opus | 1,024 tokens | 5 min default |

**TTL:** El cache expira si no se usa en 5 minutos.

---

## Pricing (Ejemplo Sonnet)

| Tipo | Input | Output |
|------|-------|--------|
| Normal | $3.00/M tokens | $15.00/M tokens |
| **Cached** | **$0.30/M tokens** | $15.00/M tokens |
| Ahorro | **90%** | — |

---

## Estrategia de Uso

1. **Identificar prompts repetitivos:** system prompts, instrucciones largas
2. **Añadir cache_control:** al final del bloque a cachear
3. **Mantener dentro del TTL:** reusar dentro de 5 min
4. **Medir savings:** comparar usage antes/después

---

## En OpenClaw

- No implementado aún en config
- Posible futuro: cachear SOUL.md, AGENTS.md
- Requiere API key de Anthropic activa

---

## Referencias

- [Anthropic Docs: Prompt Caching](https://docs.anthropic.com/claude/docs/prompt-caching)
- TODO.md item #17

---

_Creado: 2026-02-20 04:08 UTC - Micro-tarea autónoma_
