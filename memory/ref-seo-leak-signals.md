# Google Leak - Señales SEO Críticas

ID: REF-SEO-LEAK-001
Status: active
Tags: #seo #google-leak #anchors #ranking
Keys: seo, anchors, sourceType, quality, ranking-signals
Last reviewed: 2026-02-18

---

## Señales de Calidad de Anchors

### sourceType (Clasificación de Calidad)

**De anchors_anchor.ex:**

```
sourceType indica la calidad de la página fuente del anchor:

- TYPE_HIGH_QUALITY = documentos base
- TYPE_MEDIUM_QUALITY = documentos suplementarios
- TYPE_LOW_QUALITY = documentos blackhole
```

**Aplicación SEO:**
- Links de HIGH_QUALITY son más valiosos
- Links de LOW_QUALITY pueden ser dañinos
- La calidad NO es igual al PageRank

---

### locality + bucket (Métricas de Ranking)

**De anchors_anchor.ex:**

```
locality: calidad del anchor para ranking
bucket: clasificación adicional
```

**Referencia:** `quality/anchors/definitions.h`

**Aplicación SEO:**
- locality más alto = mejor calidad de link
- bucket puede indicar categorización por tipo

---

### Spam Detection Signals

**De indexing_docjoiner_anchor_phrase_spam_info.ex:**

| Campo | Qué significa |
|-------|---------------|
| `phraseAnchorSpamCount` | Cuántos spam phrases encontrados |
| `phraseAnchorSpamDays` | Días en que se detectó 80% del spam |
| `phraseAnchorSpamDemoted` | Anchors demoted por spam |
| `phraseAnchorSpamFraq` | Fracción de anchors que son spam |
| `phraseAnchorSpamPenalty` | Penalización combinada |

**Aplicación SEO:**
- Google detecta spikes de anchor spam
- Penalizaciones se calculan automáticamente
- Links durante spikes son marcados como LINK_SPAM_PHRASE_SPIKE

---

### Campos de Tiempo

**De anchors_anchor.ex:**

| Campo | Uso |
|-------|-----|
| `creationDate` | Cuándo se creó el link |
| `firstseenDate` | Cuándo Google lo vio primero |
| `firstseenNearCreation` | Si firstseen ≈ creation (link fresco) |
| `lastUpdateTimestamp` | Última actualización del anchor |

**Aplicación SEO:**
- Links frescos vs viejos tienen diferente valor
- Google puede determinar cuándo se añadió un link

---

### Campos de Calidad Adicionales

| Campo | Significado |
|-------|-------------|
| `isLocal` | Si source y target están en mismo dominio |
| `weight` | Peso del anchor (0-127) |
| `experimental` | No usar en serving |
| `deleted` | Link eliminado |
| `expired` | Dominio expirado |

---

## Sistema de Moderación (AbuseIAm)

### Tipos de Abuso

**De abuseiam_abuse_type.ex:**

```
id: tipo de abuso
subtype: subtipo específico del cliente
```

**Ejemplos (inferidos):**
- PORNOGRAPHY → nudity, graphic_sex
- SPAM → different types
- HARASSMENT → various forms

### Veredictos

**De abuseiam_verdict.ex:**

```
decision: decisión final
reasonCode: razón del veredicto
durationMins: duración en minutos
region: regiones donde aplica
restriction: restricciones específicas
```

**Aplicación SEO:**
- Contenido puede ser restringido por región
- Veredictos tienen duración temporal
- Razones están codificadas

---

## Archivos Eliminados Entre Versiones

### v0.2.0 → v0.6.1

**Eliminados (sensibles):**
- `AbuseiamVideoReviewData` - Proceso de revisión de videos
- `AbuseiamVideoReviewer` - Identidad de reviewers
- `AbuseiamManualReviewTool` - Herramientas internas
- `AbuseiamClusterEvaluationContext` - Evaluación en cluster
- `AbuseiamFeature` - Features de clasificación

**Esto revela:**
- Google limpia activamente información sensible
- Versiones antiguas tienen más datos
- Algunos campos se consideran "too revealing"

---

## Síntesis para SEO Práctico

### Qué Hacer

1. **Calidad de Links**
   - Priorizar sites que serían TYPE_HIGH_QUALITY
   - Evitar sites que serían TYPE_LOW_QUALITY
   - Diversificar anchor texts

2. **Detección de Spam**
   - No crear spikes de anchors idénticos
   - Distribuir creación de links en tiempo
   - Evitar patrones detectables

3. **Temporalidad**
   - Links frescos tienen valor diferente
   - Google sabe cuándo se añadió un link
   - Construir links gradualmente

### Qué NO Hacer

1. **Spam de Anchors**
   - No crear muchos anchors idénticos rápido
   - phraseAnchorSpamFraq > threshold = penalización
   - Google detecta automáticamente

2. **Links de Baja Calidad**
   - TYPE_LOW_QUALITY sources no ayudan
   - Pueden activar spam detection
   - Calidad > Cantidad

---

## Próximos Pasos de Investigación

1. Analizar `encodedNewsAnchorData` (qué hace un site "newsy")
2. Mapear `forwardingTypes` (cómo se redirigen links)
3. Investigar `catfishTags` (sistema de tags de links)
4. Documentar `linkAdditionalInfo` (scores adicionales)

---

## Archivos Fuente

```
memory/lib/google_api/content_warehouse/v1/model/anchors_anchor.ex
memory/lib/google_api/content_warehouse/v1/model/indexing_docjoiner_anchor_phrase_spam_info.ex
memory/lib/google_api/content_warehouse/v1/model/abuseiam_*.ex
```

---

_Creado: 18 Feb 2026 - Síntesis SEO del Google Leak_
