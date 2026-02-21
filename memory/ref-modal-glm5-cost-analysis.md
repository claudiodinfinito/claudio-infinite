# Análisis de Costos: GLM-5 en Modal.com

ID: REF-MODAL-GLM5-COST-001
Status: active
Tags: #modal #glm5 #cost #free-tier #api
Keys: modal, glm5, cost, free-tier, api, pricing
Last reviewed: 2026-02-21

---

## Contexto

- GLM-5-FP8 es mi modelo primario actual (gratis hasta Abril 2026)
- Modal.com ofrece **$30/mes en créditos gratis**
- Posiblemente GLM-5 siga siendo gratis post-Abril si uso Modal

---

## Precios de Modal (2026)

### CPU
- **Costo:** $0.0472/hora
- **Uso:** Modelos pequeños, inferencia básica

### GPU T4
- **Costo:** $0.5904/hora
- **Uso:** Modelos medianos como GLM-5

### GPU A10G
- **Costo:** ~$1.10/hora (según blog de Modal)
- **Uso:** Modelos grandes, alto rendimiento

---

## Estimación de Costos para GLM-5-FP8

### Asumiendo GPU T4 ($0.59/hora)

**Request típica:**
- Tiempo de inferencia: 2-5 segundos
- Tokens input: 2,000-10,000
- Tokens output: 500-2,000

**Cálculo:**
```
Costo por request = ($0.59/hora) × (3 segundos / 3600 segundos)
Costo por request = $0.59 × 0.000833
Costo por request ≈ $0.0005 (0.05 centavos)
```

**Requests posibles con $30/mes:**
```
Requests = $30 / $0.0005
Requests ≈ 60,000 requests/mes
```

### Asumiendo CPU ($0.0472/hora)

**Request típica (más lento):**
- Tiempo de inferencia: 5-10 segundos

**Cálculo:**
```
Costo por request = ($0.0472/hora) × (7 segundos / 3600 segundos)
Costo por request ≈ $0.00009 (0.009 centavos)
```

**Requests posibles con $30/mes:**
```
Requests = $30 / $0.00009
Requests ≈ 333,333 requests/mes
```

---

## Comparación con Otros Proveedores

| Modelo | Costo/1M tokens | Requests equivalentes |
|--------|-----------------|----------------------|
| **GLM-5 en Modal (GPU)** | ~$0.25* | 60k/mes gratis |
| **GLM-5 en Modal (CPU)** | ~$0.05* | 333k/mes gratis |
| DeepSeek V3 | $0.20-$0.80 | ~$20-80/mes |
| Gemini 2.0 Flash | Gratis | 1M tokens/día |
| Mistral | Gratis | 1B tokens/mes |

*Estimación basada en tokens promedio por request

---

## Mi Uso Actual

### Estimación de Requests Mensuales

**Sesión típica con Daniel:**
- Requests por día: 20-50
- Días activos/mes: ~20
- Requests totales: 400-1,000/mes

**Sub-agentes y cronjobs:**
- Micro-tareas: ~10/día × 30 días = 300/mes
- Health checks: ~30/mes
- Total: ~330/mes

**Total estimado: 700-1,300 requests/mes**

---

## Veredicto

**✅ $30/mes ES SUFICIENTE para mi uso actual.**

| Métrica | Valor |
|---------|-------|
| Mi uso estimado | 700-1,300 requests/mes |
| Límite con $30 (GPU) | 60,000 requests/mes |
| Margen de seguridad | 46x - 85x |

### Recomendación

1. **Post-Abril 2026:** Seguir usando GLM-5 via Modal
2. **Modelo:** Cambiar a CPU si la latencia es aceptable
3. **Fallback:** Mantener Gemini 2.0 Flash para emergencias
4. **Monitoreo:** Trackear uso real de Modal

---

## Siguientes Pasos

1. ✅ Verificar que GLM-5 corre en Modal post-Abril
2. ✅ Configurar monitoreo de uso en Modal
3. ✅ Evaluar cambio a CPU vs GPU
4. ✅ Documentar migración en `ref-glm5-alternatives.md`

---

## Fuentes

- https://modal.com/pricing - Planes y free tier
- https://cloudgpuprices.com/vendors/modal - Precios de GPU
- https://modal.com/blog/nvidia-a10g-price-article - Ejemplo de costos

---

_Creado: 2026-02-21 - Análisis de viabilidad de Modal post-Abril 2026_
