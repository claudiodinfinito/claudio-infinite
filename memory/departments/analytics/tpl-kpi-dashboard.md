# Template: KPI Dashboard

**Departamento:** ANALYTICS
**Uso:** Reportes ejecutivos de métricas clave

---

## Input Requerido

```yaml
cliente: "Nombre del cliente"
periodo: "mes|trimestre|año"
fecha_inicio: "YYYY-MM-DD"
fecha_fin: "YYYY-MM-DD"
fuentes_datos:
  - pocketbase
  - google_analytics
  - facebook_ads
objetivo_principal: "leads|conversiones|revenue|retencion"
```

---

## Estructura de Output

```markdown
# KPI Dashboard - [CLIENTE] - [PERÍODO]

**Generado:** [Fecha UTC]
**Período:** [fecha_inicio] a [fecha_fin]
**vs Período anterior:** [comparación]

---

## 📊 Resumen Ejecutivo (3 bullets)

1. **[Métrica principal]**: [Valor] ([cambio %] vs período anterior)
2. **[Insight principal]**: [Qué está pasando y por qué importa]
3. **[Acción recomendada]**: [Qué hacer con esta información]

---

## 📈 Métricas Clave

| Métrica | Este Período | Período Anterior | Cambio | Trend |
|---------|-------------|------------------|--------|-------|
| Leads generados | X | Y | +Z% | ↑↓ |
| Tasa conversión | A% | B% | +C% | ↑↓ |
| Costo por lead | $X | $Y | +Z% | ↑↓ |
| CAC | $X | $Y | +Z% | ↑↓ |
| LTV | $X | $Y | +Z% | ↑↓ |
| MRR/Revenue | $X | $Y | +Z% | ↑↓ |

---

## 🎯 Funnel de Conversión

```
Visitantes    →  X (100%)
    ↓ Drop-off: Y%
Leads         →  A (B%)
    ↓ Drop-off: C%
Calificados   →  D (E%)
    ↓ Drop-off: F%
Clientes      →  G (H%)

Conversión end-to-end: I%
```

**Cuello de botella:** [Etapa con mayor drop-off]

---

## 💡 Insights Principales

### Insight 1: [Título]
- **Qué:** [Observación objetiva]
- **Por qué importa:** [Impacto en negocio]
- **Recomendación:** [Acción específica]

### Insight 2: [Título]
- **Qué:** [Observación objetiva]
- **Por qué importa:** [Impacto en negocio]
- **Recomendación:** [Acción específica]

### Insight 3: [Título]
- **Qué:** [Observación objetiva]
- **Por qué importa:** [Impacto en negocio]
- **Recomendación:** [Acción específica]

---

## 🚨 Alertas

| Alerta | Severidad | Descripción |
|--------|-----------|-------------|
| [Tipo] | 🔴 Alta | [Descripción] |
| [Tipo] | 🟡 Media | [Descripción] |

---

## 📋 Próximos Pasos

- [ ] [Acción 1] - Owner: [Responsable] - Deadline: [Fecha]
- [ ] [Acción 2] - Owner: [Responsable] - Deadline: [Fecha]
- [ ] [Acción 3] - Owner: [Responsable] - Deadline: [Fecha]

---

## Notas Técnicas

**Fuentes de datos:**
- [Fuente 1]: [última actualización]
- [Fuente 2]: [última actualización]

**Limitaciones:**
- [Cualquier limitación de datos o cobertura]

**Próxima revisión:** [Fecha]
```

---

## Ejemplo de Uso

**Input:**
```yaml
cliente: "Clínica Dental Sonrisa"
periodo: "mes"
fecha_inicio: "2026-01-21"
fecha_fin: "2026-02-21"
objetivo_principal: "conversiones"
```

**Output esperado:**
- Dashboard completo con métricas
- 3 insights accionables
- Funnel con cuello de botella identificado
- Alertas si hay anomalías
- Próximos pasos concretos

---

## Checklist de Calidad

- [ ] Resumen ejecutivo ≤ 100 palabras
- [ ] Todas las métricas con comparación vs período anterior
- [ ] Funnel con drop-offs calculados
- [ ] 3 insights mínimo con recomendaciones
- [ ] Alertas solo si hay anomalías reales
- [ ] Próximos pasos son accionables

---

_Actualizado: 2026-02-21 14:50 UTC_
