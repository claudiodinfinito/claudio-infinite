# Google Leak: Anchor System Deep Dive

ID: REF-GOOGLE-ANCHOR-DEEP-001
Status: active
Tags: #google #leak #anchor #seo #ranking
Keys: google, leak, anchor, seo, ranking, signals
Created: 2026-02-20

---

## Señales de Anchor (Descubiertas en el Leak)

### Tipos de Anchor

| Tipo | Señal | Qué significa |
|------|-------|---------------|
| **Interno** | `sourceOnsiteAnchor` | Links dentro del mismo sitio |
| **Externo** | `sourceOffdomainAnchor` | Links desde otros dominios |

### Señales Críticas

1. **anchorMismatchDemotion** — Google penaliza si el anchor no es relevante al contexto
2. **context2** — Hash de términos CERCA del anchor (no solo el anchor mismo)
3. **fullLeftContext** — Texto completo a la izquierda del link
4. **fullRightContext** — Texto completo a la derecha del link

---

## Implicaciones para SEO

### 1. Muerte de "Trophy Links"
- Antes: Buscabas links de alta autoridad sin importar relevancia
- Ahora: `anchorMismatchDemotion` penaliza si el anchor no es relevante

### 2. Contexto > Anchor Text
- Google analiza las palabras ALREDEDOR del link
- No basta con el anchor text exacto
- El contexto debe ser relevante

### 3. Dos etapas de ranking
1. **Pre-flight check** — CompressedQualitySignals (barato computacionalmente)
2. **Final ranking** — Solo si pasa la primera etapa

---

## Acciones Concretas

### Para Link Building:
1. **Relevancia extrema** — El link debe venir de un contexto relacionado
2. **Contexto natural** — Palabras alrededor del link deben ser coherentes
3. **Evitar anchors genéricos** — "click here" sin contexto relevante

### Para On-Page:
1. **Internos con contexto** — No solo "ver más", sino "ver más sobre X tema"
2. **Coherencia en bloques** — Párrafos donde aparecen links deben ser relevantes

---

## Fuentes

- Hobo Web: "The Definitive Guide to Linkbuilding after the Google Content Warehouse Leak"
- Ai SEO Solutions: "The Google Leak Decoded: Actionable SEO Insights for 2025"
- Original leak: 2,590 archivos de Google Content Warehouse API

---

_Tarea de 3 min completada. Anchor system analizado._
