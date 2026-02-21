# Google Content Warehouse Leak: Sistemas de Ranking

ID: REF-GOOGLE-LEAK-RANKING-001
Status: active
Tags: #google #leak #ranking #seo #algorithms
Keys: google, content-warehouse, ranking-systems, navboost, twiddlers, qstar
Last reviewed: 2026-02-21
Source: 2,596 modules, 14,014 attributes leaked (Mar 2024)

---

## 1. Resumen de Sistemas de Ranking Identificados

### Sistema Central: Mustang + TeraGoogle

**Mustang** → Sistema principal que puntúa, rankea y sirve resultados de búsqueda. Algoritmo subyacente: **AScorer**.

**TeraGoogle** → Sistema de indexación que almacena datos de documentos en flash storage. Contiene mensajes con "compressed quality signals" por documento.

Referencia: `go/mustang`, `go/teragoogle`

### Q* (QStar) - Sistema de Calidad

**QStar** (también llamado "Quality component") → Grupo de señales de calidad de páginas web + método de codificación RLE (Run Length Encoding) para nuevos componentes del sitio.

**CompressedQualitySignals** → Señales de calidad comprimidas almacenadas por documento, incluyen:
- `siteAuthority` - Score de autoridad del sitio
- `pagerank` - PageRank del documento
- `spamScore` - Puntuación de spam
- `nsr` - Neural Site Rank
- `vlqNsr` - Very Low Quality NSR (para video)
- `ymylScore` - Your Money Your Life score

Referencia: `CompressedQualitySignals` module

---

## 2. Top 10 Factores de Ranking (Con Evidencia del Leak)

### #1: NavBoost - Click Signals

**Sistema:** NavBoost (conocido desde 2005)

**Evidencia del leak:**
- Módulo específico: `NavboostCrapsClickSignals`
- Métricas trackeadas:
  - `goodClicks` - Clicks buenos
  - `badClicks` - Clicks malos (pogo-sticking)
  - `lastLongestClick` - Último click más largo
  - `unsquashedClicks` - Clicks sin normalizar
  - `lastGoodClickDate` - Fecha del último click bueno

**Datos:** 13 meses de datos de clickstream (actualizado de 18 meses)
**Fuentes:** Chrome browser data + Toolbar PageRank data

**Referencia DOJ:** "Navboost is one of the important signals Google uses for ranking"

**Archivos leak:** `navboost*` modules (84 menciones)

---

### #2: siteAuthority - Autoridad de Dominio

**Sistema:** CompressedQualitySignals / Q*

**Evidencia del leak:**
```
siteAuthority: float
```
Calculado por documento, aplicado en QStar.

**Confirmación:** Google ha negado repetidamente usar "domain authority" (Gary Ilyes, John Mueller). El leak confirma que SÍ existe un score de autoridad del sitio.

**Archivos leak:** `CompressedQualitySignals` module

---

### #3: PageRank (Todavía Activo)

**Evidencia del leak:**
- `rawPagerank` - PageRank sin procesar
- `pagerank2` - Variación de PageRank
- `pagerank` - En CompressedQualitySignals

**Timeline:** Toolbar PageRank descontinuado públicamente en 2016, pero el leak muestra que sigue usándose internamente.

**Archivos leak:** Multiple modules con `pagerank` references

---

### #4: Freshness (Actualidad del Contenido)

**Sistema:** FreshnessTwiddler

**Evidencia del leak:**
- `bylineDate` - Fecha en byline/autor
- `semanticDate` - Fecha detectada en contenido
- `syntacticDate` - Fecha en URL
- `lastGoodClickDate` - Último click bueno (indicador de frescura)

**Aplicación:** Boost de contenido fresco + demotion de contenido obsoleto

**Archivos leak:** `FreshnessTwiddler`, date extraction modules

---

### #5: NSR (Neural Semantic Retrieval)

**Sistema:** Neural matching / Embeddings

**Evidencia del leak:**
- `nsr` - Neural Site Rank score
- `nsrConfidence` - Confianza en el NSR score
- `vlqNsr` - Very Low Quality NSR (para video)

**Propósito:** Matching semántico neuronal entre queries y documentos

**Archivos leak:** `CompressedQualitySignals`, NSR modules

---

### #6: Click Duration (Dwell Time)

**Evidencia del leak:**
- `lastLongestClick` - Click más largo en sesión
- `longClicks` - Clicks de larga duración

**Implicación:** No basta con CTR, el usuario debe quedarse en la página. "Long clicks" = medida de éxito de sesión de búsqueda.

**Nota:** Google ha negado usar "dwell time". El leak muestra que trackean long clicks (equivalente funcional).

**Archivos leak:** `NavboostCrapsClickSignals`

---

### #7: QualityBoost - Señales de Calidad

**Sistema:** QualityBoost Twiddler

**Evidencia del leak:**
- Sistema que boostea rankings basado en señales de calidad
- Conectado con E-E-A-T signals

**Archivos leak:** `QualityBoost` Twiddler references

---

### #8: YMYL (Your Money Your Life)

**Evidencia del leak:**
- `ymylScore` - Score YMYL en documentos
- `isYmyl` - Flag de contenido sensible

**Implicación:** Contenido financiero/médico/salud tiene escrutinio adicional

**Archivos leak:** YMYL-related modules, `CompressedQualitySignals`

---

### #9: Anchor Text & Link Quality

**Sistema:** Anchor System (documentado en `ref-google-leak-anchor-deep.md`)

**Evidencia del leak:**
- `sourceType` - HIGH/MEDIUM/LOW_QUALITY
- `locality` - Anchor quality metric
- `indexTier` - Index tier extraction

**Demotions:**
- Anchor mismatch (anchor no coincide con target)
- Low quality anchor sources

**Archivos leak:** `Anchors`, `AnchorsAnchor`, `AnchorsAnchorSource`

---

### #10: User Engagement Signals

**Evidencia del leak:**
- `userVotes` - Usuarios como votantes
- `clicksByCountry` - Clicks segmentados por país
- `clicksByDevice` - Clicks por dispositivo

**Archivos leak:** Multiple user interaction modules

---

## 3. Demotions Confirmadas

### Exact Match Domain (EMD)

**Estado:** Activo desde 2012
**Evidencia:** Domain demotion para EMDs
**Archivos leak:** EMD demotion flags

### Anchor Mismatch

**Evidencia:** Demotion cuando anchor text no coincide con sitio de destino
**Archivos leak:** Anchor mismatch detection

### SERP Dissatisfaction

**Evidencia:** Demotion basada en señales de insatisfacción del usuario (bad clicks)
**Archivos leak:** NavBoost signals

### Product Reviews Quality

**Evidencia:** Promote/Demote signals para product reviews
**Archivos leak:** Product review quality signals

### Porn / Adult Content

**Evidencia:** Demotion flags para contenido adulto
**Archivos leak:** Adult content detection modules

---

## 4. Arquitectura de Twiddlers

**Twiddlers** → Algoritmos de re-ranking que se ejecutan entre actualizaciones mayores y ajustan rankings en los SERPs.

### Twiddlers Identificados:

| Twiddler | Función |
|----------|---------|
| **NavBoost** | Re-rankeo basado en click behavior |
| **FreshnessTwiddler** | Boost contenido nuevo |
| **QualityBoost** | Boost basado en quality signals |
| **Hostage** | Probation period para sitios nuevos |
| **Demotion Twiddlers** | Aplican demotions específicas |

**Funcionamiento:**
1. Ranking inicial (Mustang/AScorer)
2. Twiddlers aplican ajustes dinámicos
3. Resultados finales servidos

---

## 5. Implicaciones para SEO Técnico

### Lo que CONFIRMA el leak:

1. **Domain Authority EXISTE** → `siteAuthority` es real
2. **Clicks importan** → NavBoost es señal importante
3. **PageRank sigue vivo** → No murió en 2016
4. **Freshness medible** → 3 tipos de fechas trackeadas
5. **Long clicks > CTR** → Duración del click importa
6. **YMYL cuantificado** → Score específico
7. **NSR funcional** → Neural matching activo

### Lo que DEBUNKS:

1. "No usamos domain authority" → FALSO
2. "No usamos clicks" → FALSO
3. "No hay dwell time" → FALSO (long clicks = dwell time)
4. "PageRank está muerto" → FALSO

### Acciones SEO Prioritarias:

1. **Optimizar para long clicks** → Contenido que retiene
2. **Construir siteAuthority** → Autoridad del dominio
3. **Freshness strategy** → Actualizar contenido regularmente
4. **Calidad de anchors** → Evitar anchor mismatch
5. **E-E-A-T signals** → Especialmente para YMYL
6. **NSR optimization** → Semantic relevance

---

## 6. Lista de Archivos Relevantes del Leak

### Sistemas de Ranking Principales:

```
lib/google_api/content_warehouse/v1/model/navboost_craps_click_signals.ex
lib/google_api/content_warehouse/v1/model/compressed_quality_signals.ex
lib/google_api/content_warehouse/v1/model/quality_boost_signals.ex
lib/google_api/content_warehouse/v1/model/freshness_twiddler_signals.ex
lib/google_api/content_warehouse/v1/model/nsr_score.ex
```

### Click & User Signals:

```
lib/google_api/content_warehouse/v1/model/user_votes.ex
lib/google_api/content_warehouse/v1/model/click_signals.ex
lib/google_api/content_warehouse/v1/model/last_longest_click.ex
```

### Quality & Spam:

```
lib/google_api/content_warehouse/v1/model/spam_score.ex
lib/google_api/content_warehouse/v1/model/ymyl_score.ex
lib/google_api/content_warehouse/v1/model/pagerank.ex
lib/google_api/content_warehouse/v1/model/site_authority.ex
```

### Anchors (ver doc dedicado):

```
lib/google_api/content_warehouse/v1/model/anchors.ex
lib/google_api/content_warehouse/v1/model/anchors_anchor.ex
lib/google_api/content_warehouse/v1/model/anchors_anchor_source.ex
```

---

## 7. Referencias Cruzadas

### Documentación Interna:

- `ref-google-leak-anchor-deep.md` → Análisis profundo del Anchor System
- `ref-google-content-warehouse-leak-analysis.md` → Análisis general del leak
- `ref-google-content-warehouse-timeline.md` → Timeline del leak
- `ref-google-leak-seo-checklist.md` → Checklist SEO basado en leak
- `ref-google-anchors-seo-guide.md` → Guía SEO para anchors

### Fuentes Externas:

1. **Michael King (iPullRank)** - "Secrets from the Google Algorithm Leak" (May 2024)
2. **Shaun Anderson (Hobo Web)** - "The Google Content Warehouse API Leak of 2024" (Jul 2025)
3. **Search Engine Land** - "HUGE Google Search document leak" (Feb 2025)
4. **DOJ Testimony** - Pandu Nayak on NavBoost (Oct 2023)
5. **Rand Fishkin** - Coordinated analysis (May 2024)

### Términos Clave:

- **NavBoost** → Click-based re-ranking
- **Twiddlers** → Re-ranking algorithms
- **QStar/Q*** → Quality component
- **Mustang** → Main ranking system
- **TeraGoogle** → Index storage
- **NSR** → Neural Semantic Retrieval
- **CompressedQualitySignals** → Per-doc quality data

---

## 8. Timeline del Leak

| Fecha | Evento |
|-------|--------|
| **Sep 2022** | Código disponible en repos públicos Google (PHP, Java, Ruby) |
| **Mar 13, 2024** | yoshi-code-bot publica documentación en GitHub |
| **May 5, 2024** | Erfan Azimi descubre leak, comparte con Fishkin/King |
| **May 7, 2024** | Google remueve repositorio |
| **May 27, 2024** | Análisis públicos por Fishkin/King |
| **May 29, 2024** | Google responde (non-denial denial) |
| **Feb 2025** | DOJ confirma leak en testimonio (HJ Kim call) |

---

## 9. Caveats Importantes

1. **No hay scoring functions** → No sabemos los pesos exactos
2. **Features deprecated** → Algunas pueden no estar en uso
3. **Documentación sin código fuente** → Solo descriptions, no implementación
4. **Go links inaccesibles** → Links internos (`go/xxx`) no accesibles
5. **Correlación ≠ Causación** → Presencia no garantiza uso activo

---

## 10. Conclusión

El leak **confirma la existencia** de sistemas que Google ha negado públicamente:

- **siteAuthority** = Domain Authority real
- **NavBoost** = Click signals son importantes
- **Long clicks** = Dwell time funcional
- **PageRank** = Siguen usándolo internamente
- **Freshness** = 3 tipos de fechas trackeadas

La arquitectura revela un sistema complejo de **señales comprimidas** por documento, **Twiddlers** de re-ranking dinámico, y **QStar** como sistema de calidad central.

**Bottom line:** El SEO "white hat" basado en construir sitios de alta calidad con engagement real está validado por la arquitectura interna de Google.

---

**Referencias:**
- Source: Google Content Warehouse API Leak (Mar 2024)
- Modules: 2,596 | Attributes: 14,014
- License: Apache 2.0 (publicly accessible)
- DOJ Confirmation: Feb 2025 testimony

**Última actualización:** 2026-02-21
**Próxima revisión:** 2026-03-21
