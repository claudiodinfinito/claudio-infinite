# Google Leak: NavBoost/CRAPS - Sistema de Click Signals

```
ID: REF-GOOGLE-NAVBOST-CRAPS-001
Status: active
Tags: #google #leak #seo #navboost #craps #click-signals #ranking
Keys: google, leak, navboost, craps, clicks, seo, ranking, signals
Last reviewed: 2026-02-22
```

---

## Resumen Ejecutivo

**NavBoost/CRAPS** es el sistema de Google que rastrea señales de clicks e impresiones para ranking. Es uno de los sistemas más importantes para SEO que se han revelado en el leak.

---

## ¿Qué es CRAPS?

**CRAPS** = Click/Rate/Action/Pattern System

Es el motor detrás de NavBoost que:
1. Rastrea clicks e impresiones de usuarios
2. Clasifica clicks como "buenos" o "malos"
3. Segmenta datos por país, idioma, dispositivo
4. Aplica "squash" (normalización) a las señales
5. Detecta patrones de URLs

---

## Señales de Clicks Principales

| Señal | Qué significa | Importancia SEO |
|-------|---------------|-----------------|
| `clicks` | Total de clicks | Alta - CTR |
| `goodClicks` | Clicks que satisfacen la intención | CRÍTICA - UX |
| `badClicks` | Clicks que no satisfacen | CRÍTICA - pogo-sticking |
| `lastLongestClicks` | Clicks que fueron últimos y más largos | MUY ALTA - satisfacción |
| `unicornClicks` | Clicks de usuarios especiales | Media - calidad de usuario |
| `impressions` | Total de veces que apareció | Alta - visibilidad |
| `unsquashedClicks` | Clicks sin normalizar | Media - datos raw |

---

## El Concepto de "Squash"

Google aplica un proceso llamado "squash" a las señales:

```
Raw Signals → Squash Process → Normalized Signals
```

**Qué significa:**
- Los clicks se normalizan para comparar entre queries con diferentes volúmenes
- Existen versiones `squashed` y `unsquashed` de los datos
- El squash probablemente ajusta por posición, query, dispositivo

**Implicación SEO:**
- Un CTR absoluto no importa tanto como el CTR relativo normalizado
- Google compara tu CTR contra el esperado para tu posición

---

## Segmentación (Slicing)

CRAPS segmenta los datos por múltiples dimensiones:

| Dimensión | Campo | Ejemplos |
|-----------|-------|----------|
| País | `country` | "US", "FR", "BR", "MX" |
| Idioma | `language` | "en", "es", "pt-BR" |
| Dispositivo | `device` | mobile, desktop, tablet |
| Tag arbitrario | `sliceTag` | Cualquier string |
| Móvil | `mobileSignals` | Señales específicas móvil |

**Implicación SEO:**
- Tu ranking puede variar por país, idioma y dispositivo
- Las señales se trackean por separado para cada combinación
- Optimizar para mobile tiene sus propias señales

---

## URL Patterns y Niveles

CRAPS detecta patrones de URLs:

```
URL Original: http://abc.def.ghi/xyz.html

Level 0 (exacta): http://abc.def.ghi/xyz.html
Level 1:          p://abc.def.ghi
Level 2:          p://def.ghi
```

**Qué significa:**
- Google agrega señales de URLs similares
- Los patrones más generales tienen `patternLevel` más alto
- Permite detectar tendencias a nivel de sitio/sección

**Implicación SEO:**
- Un problema en una URL puede afectar patrones superiores
- Si muchas páginas del sitio tienen bad clicks, todo el sitio sufre
- Estructura de URLs importa para agregación de señales

---

## Aging y Freshness

CRAPS incluye sistema de envejecimiento:

- `agingCounts` - Contador de señales de aging
- Referencia: `go/freshness-aging`

**Implicación SEO:**
- Las señales de clicks "envejecen"
- Clicks recientes probablemente pesan más
- Contenido fresco puede tener boost temporal

---

## IP Reputation

CRAPS usa reputación de IP:

- `packedIpAddress` - IP comprimida
- `unscaledIpPriorBadFraction` - Fracción de "maldad" de la IP

**Implicación SEO:**
- Google detecta clicks de IPs sospechosas
- Click farms probablemente tienen alta `badFraction`
- Señales fraudulentas se detectan y posiblemente penalizan

---

## Privacy y voterTokenCount

- `voterTokenCount` - Número de tokens de votantes distintos
- Es un lower bound de usuarios únicos
- Usado para filtrado de privacidad

**Implicación SEO:**
- Google sabe cuántos usuarios únicos contribuyeron
- Señales con pocos usuarios únicos se filtran
- Necesitas diversidad de usuarios, no solo volumen

---

## ¿Qué es un "Good Click" vs "Bad Click"?

**Good Click (click bueno):**
- Usuario encontró lo que buscaba
- Permaneció en la página
- No regresó a los resultados inmediatamente

**Bad Click (click malo):**
- Usuario regresó rápido a los resultados (pogo-sticking)
- No encontró lo que buscaba
- Probablemente hizo otro click en otro resultado

**Métrica clave: lastLongestClicks**
- Clicks donde tu URL fue la ÚLTIMA que visitaron
- Y donde pasaron MÁS tiempo que en otras URLs
- Esta es la señal de satisfacción más fuerte

---

## Cómo Usar Esta Información para SEO

### 1. Optimizar para Good Clicks
- Contenido que satisface la intención de búsqueda
- CTR alto en títulos y meta descriptions
- Páginas que retienen al usuario

### 2. Evitar Bad Clicks
- No usar clickbait
- Entregar lo que promete el título
- Evitar pogo-sticking

### 3. Maximizar lastLongestClicks
- Contenido completo y útil
- UX que mantiene al usuario
- Respuesta directa a la query

### 4. Diversidad de usuarios
- No depender de pocos usuarios
- Evitar señales artificiales
- Construir audiencia diversa

### 5. Freshness
- Actualizar contenido regularmente
- Mantener señales frescas
- El aging afecta rankings

---

## Archivos Fuente del Leak

| Archivo | Propósito |
|---------|-----------|
| `quality_navboost_craps_craps_click_signals.ex` | Señales de clicks |
| `quality_navboost_craps_craps_data.ex` | Datos principales CRAPS |
| `quality_navboost_craps_aging_data.ex` | Sistema de aging |
| `quality_navboost_craps_craps_device.ex` | Dispositivos |
| `quality_navboost_craps_feature_craps_data.ex` | Features específicas |

---

## Referencias Cruzadas

- [REF-GOOGLE-ANCHORS-SEO-001](ref-google-anchors-seo-guide.md) — Sistema de Anchors
- [REF-GOOGLE-LEAK-SOURCE-001](ref-google-leak-v020-source-analysis.md) — Análisis del código fuente
- [REF-SEO-LEAK-001](ref-seo-leak-signals.md) — Señales SEO del leak

---

## Conclusión

**NavBoost/CRAPS es uno de los sistemas más importantes del leak para SEO.**

Demuestra que:
1. Google trackea clicks a nivel granular
2. Clasifica clicks como buenos/malos
3. Segmenta por país, idioma, dispositivo
4. Normaliza señales con "squash"
5. Detecta patrones de URLs
6. Considera freshness/aging
7. Detecta fraudes por IP

**La señal más importante:** `lastLongestClicks` — usuarios que terminaron su búsqueda en tu página.

---

_Creado: 2026-02-22 desde análisis del código fuente del leak (v0.2.0)_
