# Claude Extended Thinking Reference

**Propósito:** Documentar extended thinking de Anthropic para razonamiento profundo.
**Beneficio:** Respuestas más cuidadosas, mejor para tareas complejas.

---

## ¿Qué es Extended Thinking?

Claude puede "pensar más" antes de responder, generando razonamiento interno visible.

| Sin Extended Thinking | Con Extended Thinking |
|----------------------|----------------------|
| Respuesta directa | Razonamiento + respuesta |
| Rápido | Más lento pero más preciso |
| Menos tokens | Más tokens, mejor calidad |

---

## Cómo Funciona

```python
response = client.messages.create(
    model="claude-3-7-sonnet-20250219",
    max_tokens=16000,
    thinking={
        "type": "enabled",
        "budget_tokens": 10000  # tokens para pensar
    },
    messages=[...]
)
```

---

## Parámetros

| Parámetro | Valores | Descripción |
|-----------|---------|-------------|
| `type` | "enabled" | Activa extended thinking |
| `budget_tokens` | 1,024 - 160,000 | Tokens dedicados a pensar |

**Regla:** `budget_tokens` debe ser < `max_tokens`

---

## Cuándo Usar

| ✅ Buen Caso | ❌ Mal Caso |
|--------------|--------------|
| Análisis complejo | Preguntas simples |
| Debugging difícil | Chat casual |
| Decisiones arquitectónicas | Respuestas rápidas |
| Problemas multi-paso | Tareas triviales |

---

## Costos

- Thinking tokens se cobran igual que output tokens
- Recomendado: usar solo cuando la calidad justifica el costo extra

---

## En OpenClaw

- Requiere modelo Claude 3.7 Sonnet o superior
- Útil para: troubleshooting complejo, análisis de código, decisiones arquitectónicas
- Combinable con prompt caching para optimizar

---

## Ejemplo de Uso

**Prompt:** "Analiza este código y encuentra el bug"

**Sin extended thinking:** Respuesta rápida, puede fallar

**Con extended thinking:** Claude "piensa" → analiza → encuentra bug → explica

---

## Referencias

- [Anthropic Blog: Extended Thinking](https://www.anthropic.com/news/visible-extended-thinking)
- TODO.md item #18

---

_Creado: 2026-02-20 04:17 UTC - Micro-tarea autónoma_
