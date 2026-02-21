# Tracking: Uso de Anthropic API

**Creado:** 2026-02-21 15:50 UTC
**Presupuesto:** $25 USD
**Propósito:** Calcular duración del presupuesto y optimizar uso

---

## Estado Actual

| Métrica | Valor |
|---------|-------|
| Presupuesto inicial | $25.00 USD |
| Usado hasta ahora | ~$0.00 USD |
| Disponible | $25.00 USD |
| Fecha de inicio | 2026-02-20 |

---

## Modelos Disponibles

| Modelo | Input | Output | Uso típico |
|--------|-------|--------|------------|
| Claude Opus 4-5 | $15/M | $75/M | Emergencias, razonamiento profundo |
| Claude Sonnet 4 | $3/M | $15/M | Balance costo/calidad |
| Claude Haiku 3.5 | $0.80/M | $4/M | Tareas simples, alto volumen |

---

## Estimación de Duración

### Escenario 1: Solo Haiku
- Tareas simples: ~1,000 tokens input, ~500 tokens output
- Costo por tarea: $0.001 + $0.002 = $0.003
- Tareas con $25: ~8,333 tareas

### Escenario 2: Mixto Haiku + Sonnet
- 80% Haiku, 20% Sonnet
- Promedio: $0.008/tarea
- Tareas con $25: ~3,125 tareas

### Escenario 3: Solo Opus (Emergencia)
- Tareas complejas: ~5,000 tokens input, ~2,000 tokens output
- Costo por tarea: $0.075 + $0.150 = $0.225
- Tareas con $25: ~111 tareas

---

## Tracking Manual

**Formato:** Añadir línea después de cada uso significativo

| Fecha | Modelo | Tokens In | Tokens Out | Costo Est. | Nota |
|-------|--------|-----------|------------|------------|------|
| 2026-02-20 | Opus 4-5 | ~10K | ~5K | ~$0.53 | Entrenamiento one-liners |
| 2026-02-21 | - | - | - | $0.00 | Sin uso hoy |

**Total usado:** ~$0.53 USD
**Restante:** ~$24.47 USD

---

## Reglas de Uso

1. **Usar Claude SOLO cuando:**
   - GLM-5 no disponible (rate limit)
   - Gemini quota agotada (20/día)
   - Emergencia crítica

2. **Modelo por defecto para backup:** Haiku 3.5 (más barato)

3. **Revisar balance semanalmente**

---

## Cómo Verificar Uso Real

```bash
# Via Anthropic Console
# https://console.anthropic.com/

# O verificar en el próximo mes
# cuando llegue el invoice
```

---

## Alertas

| Si restante < | Acción |
|---------------|--------|
| $20 | Notificar, reducir uso |
| $10 | Emergencia, solo crítico |
| $5 | Suspendido hasta recargar |

---

## Próxima Revisión

**Fecha:** 2026-02-28 (1 semana)

**Métrica a verificar:**
- ¿Cuánto se usó esta semana?
- ¿Tasa de consumo semanal?
- ¿Duración estimada total?

---

_Actualizado: 2026-02-21 15:50 UTC - Tracking inicial creado_
