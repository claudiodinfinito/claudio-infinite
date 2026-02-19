# Límites de Modelos AI (Free Tier)

ID: REF-LIMITS-001
Tags: #models #limits #api #free
Keys: models, limits, api, free, rate-limit
Last reviewed: 2026-02-19

---

## Modelos Principales

| Modelo | Límite | Reset | Costo |
|--------|--------|-------|-------|
| **GLM-5** (Modal) | 1 request concurrente | Instant | Gratis hasta Abril 2026 |
| **Gemini 3 Flash** | 20 requests/día | Diario 00:00 UTC | Gratis |
| **Claude** | Por presupuesto | - | $5 mínimo |

---

## Regla Crítica

**GLM-5 = 1 request concurrente MÁXIMO**

- Si YO uso GLM-5 → NO puedo spawnear GLM-5 subagente
- Solución: Subagentes con Gemini

---

## Alternativas Gratuitas

| Modelo | Dónde | Notas |
|--------|-------|-------|
| MiniMax M2.5 | Puter.js | Sin API key |
| DeepSeek V3.2 | API propia | Barato |
| Puter.js | puter.com | Multi-modelo |

---

## Uso Actual

```bash
# Verificar uso Brave API
cat memory/brave-usage.json

# Status modelos
openclaw models status --probe --json
```

---

_Creado: 2026-02-19 - Límites de modelos AI_
