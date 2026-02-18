# Google Leak v0.2.0 - Source Code Analysis

ID: REF-GOOGLE-LEAK-SOURCE-001
Status: active
Tags: #google #leak #source-code #seo #anchors
Keys: google, source-code, anchors, quality, abuseiam
Last reviewed: 2026-02-18

---

## Código Fuente Descargado

**Versión:** v0.2.0 (la más completa, antes de limpieza)
**Archivos:** 2,590 archivos .ex
**Ubicación:** `memory/lib/google_api/content_warehouse/v1/`

---

## Hallazgos Clave en Código

### 1. Anchors - Campos Expuestos

**Archivo:** `model/anchors_anchor.ex`

**Campos de calidad SEO:**

```elixir
sourceType     # TYPE_HIGH_QUALITY | TYPE_MEDIUM_QUALITY | TYPE_LOW_QUALITY
locality       # Quality metric for ranking (ver quality/anchors/definitions.h)
bucket         # Ranking bucket
weight         # 0-127 anchor weight
```

**Campos de tracking:**

```elixir
firstseenDate        # Days since Dec 31, 1994 - when link was first seen
creationDate         # When anchor was created
firstseenNearCreation  # true if firstseen is accurate estimate
deleted              # Anchor deleted flag
deletionDate         # When deleted
lastUpdateTimestamp  # Freshness tracking
```

**Campos de contexto:**

```elixir
isLocal              # Same domain indicator (roughly)
forwardingTypes      # URL forwarding type (see segindexer/segment-indexer-util.h)
encodedNewsAnchorData  # Newsiness classification
experimental         # For experimental purposes only
```

**Campos de spam:**

```elixir
phraseAnchorSpamCount    # Spam phrases count
phraseAnchorSpamDays     # Days over which 80% discovered
phraseAnchorSpamDemoted  # Number demoted
phraseAnchorSpamFraq     # Spam fraction
phraseAnchorSpamPenalty  # Combined penalty
phraseAnchorSpamRate     # Daily rate of spam discovery
```

---

### 2. AbuseIAm - Sistema de Moderación

**Archivos:** 28 modelos `model/abuseiam_*.ex`

**Modelos principales:**

| Modelo | Propósito |
|--------|-----------|
| `abuseiam_verdict.ex` | Veredicto final contra un target |
| `abuseiam_abuse_type.ex` | Tipo de abuso (id + subtype) |
| `abuseiam_evaluation.ex` | Evaluación que lleva al veredicto |
| `abuseiam_target.ex` | Target del abuso |
| `abuseiam_client.ex` | Cliente que recibe veredicto |
| `abuseiam_restriction.ex` | Restricciones geo/edad |
| `abuseiam_user_notification.ex` | Notificación al usuario |

**Campos expuestos en Verdict:**

```elixir
decision           # Verdict decision
reasonCode         # Why the decision was made
durationMins       # Duration of verdict in minutes
isLegalIssued      # Legal team issued?
strikeCategory     # Strike category if applicable
region             # Geographic regions for enforcement
restriction        # Where verdict applies
```

**Modelos eliminados en versiones posteriores:**

```elixir
abuseiam_video_review_data.ex      # Video review info (v0.2.0 ONLY)
abuseiam_video_reviewer.ex         # Reviewer info (v0.2.0 ONLY)
abuseiam_manual_review_tool.ex     # Manual review tools (v0.2.0 ONLY)
abuseiam_feature.ex                # Classification features (v0.2.0 ONLY)
abuseiam_cluster_evaluation_context.ex  # Cluster eval context (v0.2.0 ONLY)
```

---

### 3. People API - 100+ Modelos

**Patrón de nombres:** `apps_people_oz_external_mergedpeopleapi_*.ex`

**Modelos expuestos:**

| Categoría | Modelos |
|-----------|---------|
| Identidad | about, name, nickname, gender |
| Contacto | email, phone, address, im |
| Fechas | birthday, anniversary, events |
| Perfil | photo, cover_photo, occupation |
| Organización | organization, department, title |
| Redes | channel_data (YouTube), circle_membership |
| Privacidad | field_acl, contact_group_membership |
| Emergencia | emergency_info |

**Referencias internas encontradas:**

```elixir
# go/links en comentarios:
go/people-api-howto
go/peopleapi-howto/age
go/peopleapi-acl
go/contact-edit-history
go/emergency-trusted-contacts-papi
go/custompeopleapi
go/avatar-fife-urls
```

---

### 4. Quality Signals

**Archivos de calidad:** `model/indexing_docjoiner_anchor_phrase_spam_info.ex`

**Señales de anchor spam:**

```elixir
phraseAnchorSpamCount     # How many spam phrases found
phraseAnchorSpamDays      # Over how many days 80% discovered
phraseAnchorSpamDemoted   # Total anchors demoted
phraseAnchorSpamFraq      # Spam fraction
phraseAnchorSpamPenalty   # Combined penalty
phraseAnchorSpamRate      # Daily rate of spam discovery
```

**Tag:** `LINK_SPAM_PHRASE_SPIKE` - Anchors during spike are tagged

---

## Implicaciones SEO

### 1. Calidad de Anchor

**sourceType values:**
- `TYPE_HIGH_QUALITY` = Base documents
- `TYPE_MEDIUM_QUALITY` = Supplemental tier
- `TYPE_LOW_QUALITY` = Blackhole documents

**Order matters:** `TYPE_HIGH_QUALITY < TYPE_MEDIUM_QUALITY < TYPE_LOW_QUALITY`

### 2. Link Freshness

**Campos de freshness:**
- `firstseenDate` - When Google first saw the link
- `creationDate` - When anchor was created
- `firstseenNearCreation` - Accuracy indicator

**Uso:** Freshness tracking, history, Twitter retweets

### 3. Spam Detection

**Indicadores de spam:**
- Spike in anchor discovery rate
- High spam phrase fraction
- Short time window (80% in few days)

**Consequence:** `LINK_SPAM_PHRASE_SPIKE` tag, demotion

### 4. Newsiness

**Campo:** `encodedNewsAnchorData`

**Solo poblado si:**
- Anchor classified as newsy
- From high quality site
- Computed by `quality/freshness/news_anchors/` routines

---

## Versiones Comparadas

| Campo | v0.2.0 | v0.6.1 |
|-------|--------|--------|
| `isLocal` | ✓ | ✗ (removed) |
| `forwardingTypes` | ✓ | ✗ (removed) |
| `encodedNewsAnchorData` | ✓ | ✗ (removed) |
| `firstseenNearCreation` | ✓ | ✗ (removed) |
| `compressedOriginalTargetUrl` | ✓ | ✗ (removed) |
| `abuseiam_video_review_data` | ✓ | ✗ (removed) |
| `abuseiam_feature` | ✓ | ✗ (removed) |

---

## Referencias Internas (go/links)

Encontradas en el código:

```
go/projectr          - Project R age/geo gating
go/iii               - Internationalization info
go/people-api-howto  - People API documentation
go/peopleapi-acl     - ACL documentation
go/aoc               - Age of Consent
go/contact-edit-history
go/emergency-trusted-contacts-papi
go/custompeopleapi
go/avatar-fife-urls
```

---

## Próximos Pasos

1. [ ] Extraer todos los valores de `sourceType` posibles
2. [ ] Documentar todos los modelos `abuseiam_*` eliminados
3. [ ] Analizar `anchors.ex` principal (colección de anchors)
4. [ ] Crear skill de forense para otros repos

---

_Creado: 2026-02-18 - Análisis de código fuente v0.2.0_
