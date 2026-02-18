# Google Anchors - Guía SEO Definitiva (del Código Fuente)

ID: REF-GOOGLE-ANCHORS-SEO-001
Status: active
Tags: #google #seo #anchors #leak #ranking
Keys: google, seo, anchors, ranking, link-building
Last reviewed: 2026-02-18

---

## FUENTE

**Archivo:** `lib/google_api/content_warehouse/v1/model/anchors_anchor.ex`
**Versión:** v0.2.0 (versión completa antes de limpieza)
**Líneas:** 130+ campos documentados

---

## SEÑALES DE CALIDAD DE ANCHORS

### 1. sourceType - Calidad de la Página Fuente

```elixir
* `sourceType` - Registra la calidad de la página fuente del anchor

Valores:
- TYPE_HIGH_QUALITY = documentos base
- TYPE_MEDIUM_QUALITY = documentos de calidad media (supplemental tier)
- TYPE_LOW_QUALITY = documentos de baja calidad (blackhole)
- TYPE_FRESHDOCS = caso especial para freshdocs indexing

IMPORTANTE: TYPE_HIGH_QUALITY < TYPE_MEDIUM_QUALITY < TYPE_LOW_QUALITY
(Valor menor = anchor más importante)
```

**Implicación SEO:**
- Links desde páginas base tienen MÁS valor
- Links desde supplemental tier tienen valor MEDIO
- Links desde blackhole tienen valor BAJO

---

### 2. weight - Peso del Anchor

```elixir
* `weight` - weights are 0-127
```

**Implicación SEO:**
- Peso de 0-127 (128 valores posibles)
- Mayor peso = más valor
- Probablemente basado en múltiples factores

---

### 3. locality - Calidad del Anchor

```elixir
* `locality` - For ranking purposes, the quality of an anchor is measured 
  by its "locality" and "bucket". See quality/anchors/definitions.h
```

**Implicación SEO:**
- Localidad + bucket = calidad del anchor
- Definiciones internas en quality/anchors/definitions.h

---

### 4. bucket - Bucket de Ranking

```elixir
* `bucket`
```

**Implicación SEO:**
- Bucket = categoría de ranking
- Junto con locality determina calidad
- Sistema de buckets no documentado externamente

---

## SEÑALES TEMPORALES

### 5. firstseenDate - Primera Vez Visto

```elixir
* `firstseenDate` - # days past Dec 31, 1994, 23:00:00 UTC
  that this link was first seen. Should never occupy more than 15 bits.
  NOTE: this is NOT the same as creation_date; firstseen_date is filled 
  during link extraction
```

**Implicación SEO:**
- Google recuerda CUÁNDO vio el link por primera vez
- 15 bits = máximo 32,768 días (~90 años)
- No es lo mismo que creation_date

---

### 6. creationDate - Fecha de Creación

```elixir
* `creationDate` - used for history - the first and last time we have 
  seen this anchor. creation_date also used for Freshdocs Twitter indexing
```

**Implicación SEO:**
- Usado para historial
- Relevante para Freshdocs (Twitter)
- Different de firstseenDate

---

### 7. firstseenNearCreation - Frescura del Link

```elixir
* `firstseenNearCreation` - true if we think 'firstseen_date' is an 
  accurate estimate of when the link was actually added to the source page. 
  false if it may have existed for some time before we saw it.
```

**Implicación SEO:**
- Google sabe si el link es "fresco" o no
- Si firstseenNearCreation = true → link nuevo
- Si false → link puede ser más viejo de lo que Google sabe

---

## SEÑALES DE TIPO

### 8. isLocal - Mismo Dominio

```elixir
* `isLocal` - The bit ~roughly~ indicates whether an anchor's source 
  and target pages are on the same domain.
```

**Implicación SEO:**
- Links internos vs externos
- Probablemente afecta peso del link

---

### 9. forwardingTypes - Redirecciones

```elixir
* `forwardingTypes` - How the anchor is forwarded to the canonical
  The forwarding types are defined in URLForwardingUtil 
  (segindexer/segment-indexer-util.h)
```

**Implicación SEO:**
- Google rastrea cómo se redirigen los anchors
- Afecta cómo se transfiere el valor del link

---

### 10. encodedNewsAnchorData - Newsiness

```elixir
* `encodedNewsAnchorData` - Encoded data containing information about 
  newsiness of anchor. Populated only if anchor is classified as coming 
  from a newsy, high quality site.
```

**Implicación SEO:**
- Google clasifica anchors como "newsy"
- Solo se popula si viene de sitio de noticias de alta calidad
- Scores computados con quality/freshness/news_anchors/

---

## SEÑALES DE CONTEXT

### 11. text - Texto del Anchor

```elixir
* `text` - Space-delimited anchor words. Text that needs segmentation 
  (like CJK or Thai) is unsegmented
```

**Implicación SEO:**
- Texto del anchor tokenizado
- CJK y Thai se procesan diferente

---

### 12. origText - Texto Original

```elixir
* `origText` - Original text, including capitalization and punctuation. 
  Runs of whitespace are collapsed into a single space.
```

**Implicación SEO:**
- Texto original SIN modificar
- Incluye capitalización y puntuación

---

### 13. context y context2 - Contexto del Anchor

```elixir
* `context` - This is a hash of terms near the anchor
* `context2` - This is a second-generation hash replacing the value 
  stored in the 'context' field.
* `fullLeftContext` - The full context. Not written out in linklogs.
* `fullRightContext` - 
```

**Implicación SEO:**
- Google analiza el contexto ALREDEDOR del anchor
- Hash de términos cercanos
- Contexto completo no se guarda en linklogs

---

## SEÑALES DE ESTADO

### 14. deleted - Anchor Eliminado

```elixir
* `deleted`
```

**Implicación SEO:**
- Google rastrea anchors eliminados
- Probablemente afecta ranking

---

### 15. expired - Dominio Expirado

```elixir
* `expired` - true iff exp domain
```

**Implicación SEO:**
- Links desde dominios expirados se marcan
- Probablemente pierden valor

---

### 16. experimental - Anchor Experimental

```elixir
* `experimental` - If true, the anchor is for experimental purposes 
  and should not be used in serving.
```

**Implicación SEO:**
- Anchors experimentales no se usan en producción
- Google tiene sistema de testing

---

## SEÑALES DE IMÁGENES

### 17. compressedImageUrls - Imágenes en el Link

```elixir
* `compressedImageUrls` - If the anchor contained images, these image 
  urls are stored here in compressed form.
```

**Implicación SEO:**
- Google rastrea si el link tiene imágenes
- URLs de imágenes se guardan comprimidas

---

## SEÑALES ADICIONALES

### 18. parallelLinks - Links Paralelos

```elixir
* `parallelLinks` - The number of additional links from the same source 
  page to the same target domain. Not populated if is_local is true.
```

**Implicación SEO:**
- Google cuenta links paralelos al mismo dominio
- No se popula para links locales

---

### 19. fragment - URL Fragment

```elixir
* `fragment` - The URL fragment for this anchor (the foo in 
  http://www.google.com#foo)
```

**Implicación SEO:**
- Google rastrea fragments (#)
- Puede afectar cómo se indexa

---

## SISTEMA DE DROPS

### De anchors.ex:

```elixir
* `homepageAnchorsDropped` - Anchors de homepage dropeados
* `localAnchorsDropped` - Anchors locales dropeados
* `nonlocalAnchorsDropped` - Anchors no-locales dropeados
* `redundantAnchorsDropped` - Anchors redundantes dropeados
* `supplementalAnchorsDropped` - Anchors suplementales dropeados (DEPRECATED)
```

**Implicación SEO:**
- Google DROPEA anchors por tipo
- Homepage anchors se pueden dropear
- Anchors redundantes se eliminan
- Sistema de limpieza activo

---

## RECORTES DE CÓDIGO

### Referencias Internas Encontradas:

```
- segindexer/types.h (indexTier)
- quality/anchors/definitions.h (locality, bucket)
- webutil/urlencoding (targetUrlEncoding)
- segindexer/segment-indexer-util.h (forwardingTypes)
- quality/freshness/news_anchors/ (newsAnchorData)
```

---

## GUÍA SEO PRÁCTICA

### Qué Hacer:

1. **Conseguir links de páginas base** (TYPE_HIGH_QUALITY)
2. **Evitar links de blackhole** (TYPE_LOW_QUALITY)
3. **Monitorear firstseenNearCreation** → Links frescos
4. **Diversificar anchors** → No solo homepage
5. **Contexto relevante** → Google lo analiza

### Qué NO Hacer:

1. **Links desde dominios expirados**
2. **Links desde páginas suplementales** (bajo valor)
3. **Anchors redundantes** → Se dropean
4. **Links experimentales** → No cuentan
5. **Links eliminados** → Se rastrean

---

## Archivos Relacionados

- `anchors.ex` - Colección de anchors
- `anchors_anchor.ex` - Anchor individual
- `anchors_anchor_source.ex` - Fuente del anchor
- `anchors_redundant_anchor_info.ex` - Info de redundancia

---

**Análisis completado:** 2026-02-18 09:35 UTC
**Valor:** 🔥🔥🔥 CRÍTICO para SEO
