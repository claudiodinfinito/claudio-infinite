# Template: Competitive Analysis

**Departamento:** RESEARCH
**Uso:** Análisis profundo de competidores

---

## Input Requerido

```yaml
industria: "Nombre de la industria/sector"
competidores:
  - nombre: "Competidor A"
    website: "https://..."
  - nombre: "Competidor B"
    website: "https://..."
nuestra_empresa: "Nombre de nuestra empresa/cliente"
aspectos_a_analizar:
  - pricing
  - features
  - positioning
  - marketing
  - customer_reviews
```

---

## Estructura de Output

```markdown
# Competitive Analysis - [INDUSTRIA]

**Generado:** [Fecha UTC]
**Competidores analizados:** [Lista]
**Aspectos:** [Pricing, Features, Positioning, etc.]

---

## 🎯 Resumen Ejecutivo (3 bullets)

1. **[Finding principal]**: [Qué descubrimos]
2. **[Oportunidad clave]**: [Gap identificado]
3. **[Acción recomendada]**: [Qué hacer con esta info]

---

## 📊 Panorama Competitivo

| Competidor | Fundado | Empleados | Funding | Posicionamiento |
|------------|---------|-----------|---------|-----------------|
| [A] | [Año] | [N] | $X | [Tagline/positioning] |
| [B] | [Año] | [N] | $Y | [Tagline/positioning] |

---

## 💰 Análisis de Pricing

| Plan | Nosotros | Competidor A | Competidor B |
|------|----------|--------------|--------------|
| Básico | $X/mes | $Y/mes | $Z/mes |
| Pro | $X/mes | $Y/mes | $Z/mes |
| Enterprise | Custom | $Y/mes | Custom |

**Insights de pricing:**
- [Competidor A] es X% más caro que nosotros
- Ninguno ofrece [feature X] en plan básico
- Oportunidad: [gap de pricing]

---

## ⚙️ Feature Comparison

| Feature | Nosotros | Competidor A | Competidor B | Importancia |
|---------|----------|--------------|--------------|-------------|
| [Feature 1] | ✅ | ✅ | ❌ | Alta |
| [Feature 2] | ✅ | ❌ | ✅ | Media |
| [Feature 3] | ❌ | ✅ | ✅ | Alta |

**Feature gaps identificados:**
1. **[Feature que falta]** - [Por qué importa]
2. **[Feature que falta]** - [Por qué importa]

**Nuestras ventajas:**
1. **[Feature única]** - [Diferenciador]

---

## 🎨 Positioning & Messaging

### Competidor A
- **Tagline:** "[Su tagline]"
- **Target:** [A quién se dirigen]
- **Mensaje principal:** [Qué comunican]
- **Tono:** [Formal/Casual/Técnico]

### Competidor B
- **Tagline:** "[Su tagline]"
- **Target:** [A quién se dirigen]
- **Mensaje principal:** [Qué comunican]
- **Tono:** [Formal/Casual/Técnico]

### Nosotros
- **Tagline:** "[Nuestra tagline]"
- **Target:** [A quién nos dirigimos]
- **Mensaje principal:** [Qué comunicamos]
- **Diferenciación propuesta:** [Qué nos hace únicos]

---

## ⭐ Customer Reviews Analysis

### Competidor A (G2/Capterra)
- **Rating promedio:** X/5
- **Lo que alaban:** [P1, P2, P3]
- **Lo que critican:** [C1, C2, C3]

### Competidor B (G2/Capterra)
- **Rating promedio:** Y/5
- **Lo que alaban:** [P1, P2, P3]
- **Lo que critican:** [C1, C2, C3]

**Oportunidades de desventaja competitiva:**
- [C1 de A] → Podemos destacarnos en esto
- [C2 de B] → Oportunidad de posicionamiento

---

## 🔍 Gap Analysis

### Oportunidad 1: [Título]
- **Qué:** [Descripción del gap]
- **Por qué existe:** [Razón]
- **Potencial:** [Alto/Medio/Bajo]
- **Acción sugerida:** [Qué hacer]

### Oportunidad 2: [Título]
- **Qué:** [Descripción del gap]
- **Por qué existe:** [Razón]
- **Potencial:** [Alto/Medio/Bajo]
- **Acción sugerida:** [Qué hacer]

---

## 📋 Recomendaciones Estratégicas

| Prioridad | Acción | Impacto esperado | Timeline |
|-----------|--------|------------------|----------|
| 1 | [Acción] | [Impacto] | [Semanas] |
| 2 | [Acción] | [Impacto] | [Semanas] |
| 3 | [Acción] | [Impacto] | [Semanas] |

---

## 📚 Fuentes

1. [Fuente 1] - [URL]
2. [Fuente 2] - [URL]
3. [Fuente 3] - [URL]

---

**Próxima actualización sugerida:** [Fecha en 3 meses]
```

---

## Ejemplo de Uso

**Input:**
```yaml
industria: "CRM para PYMEs"
competidores:
  - nombre: "HubSpot"
    website: "https://hubspot.com"
  - nombre: "Pipedrive"
    website: "https://pipedrive.com"
nuestra_empresa: "Revenue Software"
aspectos_a_analizar:
  - pricing
  - features
  - positioning
```

**Output esperado:**
- Análisis completo de 2 competidores
- Feature comparison matrix
- Pricing insights
- Gap analysis con oportunidades
- Recomendaciones estratégicas

---

## Checklist de Calidad

- [ ] Mínimo 2 competidores analizados
- [ ] Pricing comparado con % diferencia
- [ ] Feature matrix completa
- [ ] Reviews de clientes incluidos
- [ ] 2+ gaps identificados
- [ ] Recomendaciones priorizadas
- [ ] Fuentes citadas

---

_Actualizado: 2026-02-21 15:00 UTC_
