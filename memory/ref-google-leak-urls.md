ID: REF-GOOGLE-LEAK-001
Status: active
Tags: #seo #google #leak #research
Keys: google, leak, seo, content-warehouse, quality-rater
Last reviewed: 2026-02-18

# Google Content Warehouse Leak - Fuentes Completas

**Importante:** URLs pasadas por Daniel en sesiones anteriores.

---

## FASE 1 — Leak Original

| # | Fuente | URL |
|---|--------|-----|
| 1 | SparkToro (análisis original) | https://sparktoro.com/blog/an-anonymous-source-shared-thousands-of-leaked-google-search-api-documents-with-me-everyone-in-seo-should-see-them/ |
| 2 | PopWebDesign | https://www.popwebdesign.net/popart_blog/en/2024/06/google-leak-document/ |
| 3 | Hobo-web | https://www.hobo-web.co.uk/google-goldmine/ |

---

## FASE 2 — GitHub + HexDocs + APIs (Leak Principal)

| # | Fuente | URL |
|---|--------|-----|
| 4 | GitHub elixir-google-api (REPO COMPLETO) | https://github.com/googleapis/elixir-google-api/ |
| 5 | Lista de 326 clientes API | https://api.github.com/repos/googleapis/elixir-google-api/contents/clients |
| 6 | Content Warehouse v0.6.1 (latest) | https://hexdocs.pm/google_api_content_warehouse/api-reference.html |
| 7 | Content Warehouse v0.6.0 | https://hexdocs.pm/google_api_content_warehouse/0.6.0/api-reference.html |
| 8 | Content Warehouse v0.5.0 | https://hexdocs.pm/google_api_content_warehouse/0.5.0/api-reference.html |
| 9 | Content Warehouse v0.4.0 | https://hexdocs.pm/google_api_content_warehouse/0.4.0/api-reference.html |
| 10 | Content Warehouse v0.3.0 | https://hexdocs.pm/google_api_content_warehouse/0.3.0/api-reference.html |
| 11 | Content Warehouse v0.2.0 (MÁS modelos) | https://hexdocs.pm/google_api_content_warehouse/0.2.0/api-reference.html |
| 12 | Source code en GitHub | https://github.com/googleapis/elixir-google-api/tree/master/clients/content_warehouse |

---

## FASE 3 — Documentación Oficial Google

| # | Fuente | URL | Idioma |
|---|--------|-----|--------|
| 7 | Quality Rater Guidelines | https://static.googleusercontent.com/media/guidelines.raterhub.com/en//searchqualityevaluatorguidelines.pdf | EN |
| 8 | Guías de Calidad | https://static.googleusercontent.com/media/guidelines.raterhub.com/es//searchqualityevaluatorguidelines.pdf | ES |
| 9 | How Search Works | https://www.google.com/search/howsearchworks/how-search-works/rigorous-testing/?hl=es-419 | ES |
| 10 | Ranking Systems Guide | https://developers.google.com/search/docs/appearance/ranking-systems-guide?hl=es-419 | ES |

---

## FASE 4 — Análisis de Terceros

| # | Fuente | URL |
|---|--------|-----|
| 11 | SERoundtable | https://www.seroundtable.com/google-search-quality-raters-guidelines-updated-38794.html |
| 12 | Portent SEO | https://portent.com/blog/seo/googles-search-quality-evaluator-guidelines-for-seo.htm |

---

## ESTADO DE INVESTIGACIÓN

**Status:** ✅ ANÁLISIS INICIAL COMPLETADO

**Qué se investigó (18 Feb 2026):**
- 3 versiones del API de Content Warehouse en HexDocs
- 326 clientes API en el repositorio oficial
- Sistemas internos expuestos: AbuseIAm, People API, Anchors, IAM, Document AI

**Documentos generados:**
- `ref-google-leak-urls.md` (este archivo) - URLs de referencia
- `ref-google-content-warehouse-leak-analysis.md` - Análisis técnico detallado

---

## VALOR DE ESTA INVESTIGACIÓN

### Para Mí (Claudio):
1. **Knowledge base SEO** - Entiendo cómo Google evalúa links, calidad, anchors
2. **Source credibility** - Puedo distinguir entre speculation y evidence interna
3. **Pattern recognition** - Conozco sistemas como AbuseIAm que usas en proyectos
4. **Better advice** - Mis recomendaciones SEO tienen base real, no solo "best practices"

### Para Daniel:
1. **Ventaja competitiva SEO** - Sistemas internos documentados:
   - `sourceType` (HIGH/MEDIUM/LOW_QUALITY)
   - `locality` y `bucket` como métricas de calidad
   - Anchos dropeados por tipo
2. **Entender content moderation** - AbuseIAm revela:
   - Restricciones geográficas
   - Gating por edad
   - Flujo de veredictos
3. **Reverse engineering** - Datos para:
   - Analizar por qué un sitio está penalizado
   - Entender qué señales valora Google
   - Optimizar estrategia de links
4. **Gray hat awareness** - Saber dónde están los límites

---

## HALLAZGOS CLAVE

### Anchor Quality Signals
```
source_type = HIGH_QUALITY  → base documents
source_type = MEDIUM_QUALITY → supplemental tier
source_type = LOW_QUALITY   → blackhole documents
```

### Link Devaluation
- `homepageAnchorsDropped` - Anchos de homepage filtrados
- `redundantAnchorsDropped` - Muestreo de anchors redundantes
- `nonlocalAnchorsDropped` - Anchos non-local filtrados

### Internal Google Links (go/)
- `go/projectr` - Project R age/geo gating
- `go/iii` - Internationalization
- `go/people-api-howto` - People API docs
- `go/peopleapi-acl` - ACL documentation

---

## PRÓXIMOS PASOS (cuando Daniel quiera profundizar)

1. Leer artículo original de SparkToro
2. Analizar módulos específicos de interés
3. Cruzar con Quality Rater Guidelines
4. Documentar implicaciones para proyectos específicos

---

## LECCIÓN APRENDIDA

**Estas URLs me fueron pasadas en sesiones anteriores y NO fueron documentadas.**

**Regla:**
> Si no está en memory/, no existe.

**Acción correctiva:**
- Documentar URLs importantes INMEDIATAMENTE
- No asumir que "lo recordaré"
- Cada URL importante → entrada en research/ o memory/

---

_Creado: 18 Feb 2026 - Recuperación de URLs no documentadas_
