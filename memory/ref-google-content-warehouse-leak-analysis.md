# Google Content Warehouse API Leak Analysis

ID: REF-GOOGLE-LEAK-001
Status: active
Tags: #google #leak #api #seo #security
Keys: google, content-warehouse, api-leak, abuseiam, people-api, anchors
Last reviewed: 2026-02-18

---

## Overview

The `google_api_content_warehouse` Elixir package exposes internal Google API structures that were never meant to be public. Available in 3 versions on HexDocs:
- **v0.6.1** (latest)
- **v0.4.0**
- **v0.2.0**

Each version contains thousands of model definitions revealing Google's internal systems.

---

## Major Systems Exposed

### 1. AbuseIAm (Abuse Intelligence and Management)

**Purpose:** Google's content moderation and abuse classification system.

**Key Models:**
- `AbuseiamAbuseType` - Abuse type classification
- `AbuseiamVerdict` - Final judgment on content
- `AbuseiamEvaluation` - Backend evaluation results
- `AbuseiamUserRestriction` - User-level restrictions
- `AbuseiamGeoRestriction` - Geographic content restrictions
- `AbuseiamAgeRestriction` - Age-based content gating
- `AbuseiamClient` - Google products that submit content for classification
- `AbuseiamTarget` - Target of abuse verdict
- `AbuseiamUserNotification` - User notification config

**Internal Links Found:**
- `go/projectr` - Project R age/geo gating
- `go/iii` - Internationalization info

**Implications:**
- Reveals how Google classifies and removes content
- Shows geographic and age-based restriction logic
- Exposes the verdict/evaluation pipeline

---

### 2. People API (AppsPeopleOzExternalMergedpeopleapi)

**Purpose:** Massive user profile and contact data system.

**Key Models (100+ models):**
- `AppsPeopleOzExternalMergedpeopleapiAbout` - User bio/about
- `AppsPeopleOzExternalMergedpeopleapiAddress` - Physical addresses
- `AppsPeopleOzExternalMergedpeopleapiBirthday` - Birthday data
- `AppsPeopleOzExternalMergedpeopleapiEmail` - Email with certificates
- `AppsPeopleOzExternalMergedpeopleapiPhone` - Phone numbers
- `AppsPeopleOzExternalMergedpeopleapiGender` - Gender identity
- `AppsPeopleOzExternalMergedpeopleapiPhoto` - Profile photos
- `AppsPeopleOzExternalMergedpeopleapiIm` - IM handles
- `AppsPeopleOzExternalMergedpeopleapiCoverPhoto` - Cover photos
- `AppsPeopleOzExternalMergedpeopleapiContactGroupMembership` - Contact groups
- `AppsPeopleOzExternalMergedpeopleapiCircleMembership` - Google+ circles
- `AppsPeopleOzExternalMergedpeopleapiChannelData` - YouTube channel data
- `AppsPeopleOzExternalMergedpeopleapiEmergencyInfo` - Emergency contacts
- `AppsPeopleOzExternalMergedpeopleapiFieldAcl` - Field-level ACLs

**Internal Links Found:**
- `go/people-api-howto` - People API documentation
- `go/peopleapi-howto/age` - Age data handling
- `go/peopleapi-acl` - ACL documentation
- `go/contact-edit-history` - Contact edit tracking
- `go/emergency-trusted-contacts-papi` - Emergency contacts
- `go/custompeopleapi` - Custom schema fields
- `go/avatar-fife-urls` - Avatar URL handling

**Implications:**
- Reveals extensive user data collection structure
- Shows how Google merges data from multiple sources
- Exposes field-level access control logic
- Reveals account birthday handling and age restrictions

---

### 3. Anchors (Link Analysis)

**Purpose:** Search indexing link analysis system.

**Key Models:**
- `Anchors` - Anchor text collection for a URL
- `AnchorsAnchor` - Individual anchor/link
- `AnchorsAnchorSource` - Source page attributes
- `AnchorsRedundantAnchorInfo` - Anchor sampling data

**Fields Revealed:**
- `sourceType` - Quality classification (HIGH/MEDIUM/LOW_QUALITY)
- `indexTier` - Index tier extraction
- `locality` - Anchor quality metric
- `bucket` - Ranking bucket
- `firstseenDate` - Link discovery date
- `creationDate` - Anchor creation timestamp
- `weight` - Anchor weight (0-127)
- `experimental` - Experimental anchor flag
- `forwardingTypes` - URL forwarding handling
- `encodedNewsAnchorData` - News classification

**Internal References:**
- `segindexer/types.h` - Index tier definitions
- `quality/anchors/definitions.h` - Quality metrics
- `webutil/urlencoding` - URL encoding

**Implications for SEO:**
- Reveals how Google evaluates link quality
- Shows anchor text processing
- Exposes link devaluation signals
- Documents anchor sampling logic

---

### 4. IAM & Audit Configuration

**Key Models:**
- `GoogleIamV1AuditConfig` - Audit logging config
- `GoogleIamV1AuditLogConfig` - Permission logging
- `GoogleIamV1Binding` - Role-member bindings
- `GoogleIamV1Policy` - Full IAM policy

**Reveals:**
- DATA_READ, DATA_WRITE, ADMIN_READ logging types
- Exemption mechanisms for audit logging
- Policy versioning

---

### 5. Document AI (DocAI)

**Key Models:**
- `GoogleCloudDocumentaiV1Document` - Canonical document format
- `GoogleCloudDocumentaiV1DocumentEntity` - Entity extraction
- `GoogleCloudDocumentaiV1DocumentPage` - Page analysis
- `GoogleCloudDocumentaiV1DocumentChunk` - Chunk processing
- `GoogleCloudDocumentaiV1DocumentProvenance` - Revision tracking

**Exposes:**
- OCR processing pipeline
- Entity extraction structure
- Layout analysis (blocks, tables, lists)
- Text style attributes

---

### 6. Content Warehouse Document Management

**Key Models:**
- `GoogleCloudContentwarehouseV1Document` - Document structure
- `GoogleCloudContentwarehouseV1DocumentSchema` - Schema definition
- `GoogleCloudContentwarehouseV1Property` - Property values
- `GoogleCloudContentwarehouseV1Rule` - Rule engine
- `GoogleCloudContentwarehouseV1RuleSet` - Rule collections
- `GoogleCloudContentwarehouseV1SynonymSet` - Custom synonyms
- `GoogleCloudContentwarehouseV1IngestionPipeline` - Data ingestion

**Reveals:**
- Document schema structure
- Property filtering and indexing
- Rule evaluation pipeline
- Custom synonym handling

---

### 7. AppsDynamite (Google Chat/Hangouts)

**Key Models:**
- `AppsDynamiteCustomerId` - GSuite customer ID
- `AppsDynamiteSharedOrganizationInfo` - Organization data
- `AppsDynamiteSharedSegmentedMembershipCount` - Membership counts

---

## SEO Implications

### Anchor Quality Signals

```
source_type values:
- TYPE_HIGH_QUALITY = base documents
- TYPE_MEDIUM_QUALITY = supplemental tier
- TYPE_LOW_QUALITY = blackhole documents
```

### Link Devaluation Signals

Fields that indicate link devaluation:
- `homepageAnchorsDropped` - Homepage anchor filtering
- `localAnchorsDropped` - Local anchor filtering
- `nonlocalAnchorsDropped` - Non-local anchor filtering
- `redundantAnchorsDropped` - Redundant anchor sampling
- `supplementalAnchorsDropped` - Supplemental anchor filtering

### Index Tiers

The `indexTier` field reveals:
- Multiple index tiers exist
- Tiers are defined in `segindexer/types.h`
- Different tiers affect anchor weight

---

## Security Implications

### Internal Google Links Exposed

Multiple `go/` internal links found:
- `go/projectr`
- `go/iii`
- `go/people-api-howto`
- `go/peopleapi-acl`
- `go/aoc` (Age of Consent)
- `go/age-disable-grace-period-dd`
- `go/contact-edit-history`
- `go/emergency-trusted-contacts-papi`
- `go/custompeopleapi`
- `go/avatar-fife-urls`

These are internal Google shortlinks that employees use.

### ACL Structure

Field-level ACLs reveal:
- Per-field access control
- Circle-based permissions
- Contact group-based permissions
- Domain-level restrictions
- "allUsers" for public access

---

## Version Differences

**Todas las versiones disponibles en Hex.pm:**
- v0.2.0
- v0.3.0
- v0.4.0
- v0.5.0
- v0.6.0
- v0.6.1 (latest)

| Feature | v0.2.0 | v0.4.0 | v0.6.0 | v0.6.1 |
|---------|--------|--------|--------|--------|
| AbuseiamVideoReviewData | ✓ | ✗ | ✗ | ✗ |
| AbuseiamVideoReviewer | ✓ | ✗ | ✗ | ✗ |
| AbuseiamManualReviewTool | ✓ | ✗ | ✗ | ✗ |
| AbuseiamClusterEvaluationContext | ✓ | ✗ | ✗ | ✗ |
| AbuseiamFeature | ✓ | ✗ | ✗ | ✗ |
| AppsPeopleOzExternalMergedpeopleapi* | ✓ | ✓ | ✗ | ✗ |
| Anchors* (full fields) | ✓ | ✓ | ✗ | ✗ |

**v0.2.0 tiene más modelos internos** que las versiones posteriores.

Algunos modelos fueron removidos después del descubrimiento del leak.

---

## Key Takeaways

1. **Massive Data Exposure**: Thousands of internal Google API models documented in public package

2. **SEO Goldmine**: Anchor processing, quality signals, index tiers all exposed

3. **Privacy Concerns**: Extensive user data structures revealed

4. **Internal Documentation**: `go/` links expose internal documentation paths

5. **Content Moderation**: AbuseIAm system fully documented

6. **People API**: User profile merging, ACLs, field-level access all exposed

---

## El Repositorio Completo

El `content_warehouse` es solo **1 de 326 clientes API** en el repositorio oficial:

**https://github.com/googleapis/elixir-google-api/**

Este repositorio es **OFICIAL de Google** y los clientes se generan automáticamente desde el **Google Discovery Service**.

### Cómo se produjo el leak:

1. Google publica specs de APIs en `https://www.googleapis.com/discovery/v1/apis`
2. El proyecto `elixir-google-api` tiene un script `mix google_apis.discover` que descubre todas las APIs
3. El script `mix google_apis.fetch` descarga las specs
4. El generador crea clientes Elixir automáticamente
5. **El `content_warehouse` fue publicado accidentalmente en el discovery service**
6. El generador lo encontró y creó el cliente con todos los modelos internos

### APIs potencialmente sensibles en el repo:

| API | Potencial exposición |
|-----|---------------------|
| `content_warehouse` | **LEAK CONFIRMADO** - Sistemas internos |
| `people` | People API (datos de usuario) |
| `document_ai` | Pipeline de OCR/extracción |
| `safe_browsing` | URLs maliciosas |
| `vault` | Retención legal, edisclosure |
| `cloud_search` | Búsqueda enterprise |
| `indexing` | Indexación de contenido |
| `content` | Content API for Shopping |

---

## Sources

- https://hexdocs.pm/google_api_content_warehouse/ (v0.6.1)
- https://hexdocs.pm/google_api_content_warehouse/0.4.0/api-reference.html
- https://hexdocs.pm/google_api_content_warehouse/0.2.0/api-reference.html
- https://github.com/googleapis/elixir-google-api/tree/master/clients/content_warehouse
