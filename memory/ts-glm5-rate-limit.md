# GLM-5 Rate Limit - Troubleshooting

ID: TS-GLM5-RATE-001
Status: active
Tags: #glm5 #rate-limit #modal #troubleshooting
Keys: glm5, rate-limit, modal, reset, troubleshooting
Last reviewed: 2026-02-18

---

## Síntoma

```
⚠️ API rate limit reached. Please try again later.
```

O en logs:
```json
"error": "FailoverError: ⚠️ API rate limit reached. Please try again later."
```

---

## Causa

**GLM-5 via Modal tiene límite de 1 request concurrente.**

Uso intensivo en ráfagas cortas puede saturar el endpoint.

---

## Límites Confirmados

| Parámetro | Valor |
|-----------|-------|
| Concurrent requests | 1 |
| Tokens | Sin límite directo |
| Rate limit reset | ~1-2 horas (automático) |
| Gratis hasta | 30 Abril 2026 |

---

## Timeline del Incidente

| Hora (UTC) | Evento |
|------------|--------|
| 09:03 | Gateway iniciado |
| 09:36 | Rate limit hit (~33 min uso intensivo) |
| 10:33 | Heartbeat ejecuta (sin respuesta) |
| 11:03 | Heartbeat ejecuta (sin respuesta) |
| 11:45 | Reset confirmado con test |

**Duración del rate limit:** ~2 horas

---

## Diagnóstico

### 1. Verificar rate limit activo

```bash
curl -s -w "\nHTTP_CODE:%{http_code}\n" -X POST "https://api.us-west-2.modal.direct/v1/chat/completions" \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $GLM_API_KEY" \
  -d '{"model": "zai-org/GLM-5-FP8", "messages": [{"role": "user", "content": "test"}], "max_tokens": 10}'
```

- **HTTP 200:** Funciona
- **HTTP 429:** Rate limit activo

### 2. Verificar fallback

```bash
grep "fallbacks" /root/.openclaw/openclaw.json
```

Si fallback es Claude, verificar créditos:
```
"Your credit balance is too low to access the Anthropic API"
```

---

## Soluciones

### Plan A: Esperar reset (gratis)

- **Tiempo:** ~1-2 horas
- **Automático:** Sí
- **Acción:** Ninguna, esperar

### Plan B: Añadir créditos a Claude (inmediato)

- **Costo:** $5 mínimo
- **Acción:** Ir a Anthropic console → Billing → Add credits
- **Resultado:** Fallback funcional

### Plan C: Reducir uso intensivo (preventivo)

- Evitar ráfagas de requests en corto tiempo
- Espaciar llamadas al modelo
- Usar heartbeat cada 2h en lugar de 30min durante uso intensivo

### Plan D: Buscar alternativa (largo plazo)

- GLM-5 gratis hasta Abril 2026
- Investigar otros proveedores gratuitos
- Considerar self-hosting

---

## Tests

### Test de conectividad

```bash
curl -X POST "https://api.us-west-2.modal.direct/v1/chat/completions" \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $GLM_API_KEY" \
  -d '{"model": "zai-org/GLM-5-FP8", "messages": [{"role": "user", "content": "ping"}], "max_tokens": 5}'
```

### Test de modelos

```bash
openclaw models status --probe --probe-provider glm5 --json
```

---

## Prevención

1. **Monitorear uso:** Si hay muchos errores 429, reducir frecuencia
2. **Fallback funcional:** Mantener Claude con créditos mínimos
3. **Alternativas:** Tener plan B antes de Abril 2026

---

## Fuentes

- https://modal.com/blog/try-glm-5
- https://modal.com/glm-5-endpoint

---

_Creado: 18 Feb 2026 - Post-rate-limit incidente_
