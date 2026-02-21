# Google Leak: Demotions Confirmadas

**ID:** REF-GOOGLE-LEAK-DEMOTIONS-001
**Status:** active
**Tags:** #google #leak #seo #demotions #penalties
**Keys:** demotions, penalties, anchor-mismatch, emd, serp-dissatisfaction
**Last reviewed:** 2026-02-21
**Source:** Google Content Warehouse API Leak (2,596 modules)

---

## 1. Resumen Ejecutivo

El leak confirma **7 demotions activas** que Google aplica a sitios web. Estas son reducciones de ranking basadas en señales negativas detectadas.

### Demotions Confirmadas:

| Demotion | Severidad | Detectable | Recuperable |
|----------|-----------|------------|-------------|
| Anchor Mismatch | 🔴 Alta | Sí | Sí |
| EMD (Exact Match Domain) | 🟡 Media | Sí | Parcial |
| SERP Dissatisfaction | 🔴 Alta | Difícil | Sí |
| Product Reviews Low Quality | 🟡 Media | Sí | Sí |
| Adult Content | 🔴 Alta | Sí | No aplica |
| User Location Mismatch | 🟢 Baja | Sí | Sí |
| Page Quality Low | 🔴 Alta | Difícil | Sí |

---

## 2. Anchor Mismatch Demotion

### Qué es:
Cuando el anchor text de un enlace **no coincide** con el contenido de la página de destino.

### Evidencia del leak:
```
AnchorMismatchDemotion
- anchorText: string
- targetPageContent: vector
- mismatchScore: float
```

### Cómo detectarlo:
1. Revisar backlinks con anchors irrelevantes
2. Usar Ahrefs → Anchors → Filter por términos no relacionados
3. Verificar enlaces internos con anchors genéricos ("clic aquí")

### Cómo recuperarse:
| Acción | Prioridad |
|--------|-----------|
| Contactar webmasters para cambiar anchor | 🔴 Alta |
| Disavow enlaces tóxicos | 🟡 Media |
| Mejorar contenido para match con anchors existentes | 🟡 Media |

### Prevención:
- Anchor text relevante en enlaces internos
- Solicitar anchors específicos en link building
- Evitar anchors genéricos ("aquí", "clic", "leer más")

---

## 3. EMD (Exact Match Domain) Demotion

### Qué es:
Dominios que coinciden exactamente con la keyword objetivo reciben escrutinio adicional y potencial demotion si el contenido no justifica el dominio.

### Ejemplos:
- `mejor-seo-mexico.com`
- `clinicadentalcancun.mx`
- `abogadosaccidentes.com`

### Evidencia del leak:
```
ExactMatchDomainDemotion
- domain: string
- queryMatchScore: float
- contentQualityScore: float
```

### Cómo funciona:
1. Google detecta coincidencia exacta dominio ↔ query
2. Evalúa calidad del contenido
3. Si contenido es bajo → demotion aplicada

### Cómo evitarla:
| Estrategia | Efectividad |
|------------|-------------|
| Contenido de alta calidad | ✅ Mejor |
| Marca real (no solo keyword) | ✅ Bueno |
| Múltiples páginas de valor | ✅ Bueno |
| Cambiar de dominio | ⚠️ Último recurso |

### No todos los EMD son penalizados:
EMD + contenido de calidad = ✅ OK
EMD + contenido thin = ❌ Demotion

---

## 4. SERP Dissatisfaction Demotion

### Qué es:
Cuando usuarios hacen click en tu resultado pero vuelven rápidamente al SERP (pogo-sticking), Google interpreta que tu página no satisfizo la intención de búsqueda.

### Evidencia del leak:
```
NavboostCrapsClickSignals
- badClicks: integer
- goodClicks: integer
- lastLongestClick: timestamp
- unsquashedClicks: integer
```

### Señales negativas:
| Señal | Qué indica |
|-------|-----------|
| `badClicks` altos | Usuarios no encontraron lo que buscaban |
| `lastLongestClick` bajo | Sessions cortas en tu página |
| Ratio badClicks/goodClicks > 1 | Más frustración que satisfacción |

### Cómo medirlo:
- **Google Search Console** → CTR + Posición promedio
- Si CTR alto pero posición baja = posible dissatisfaction
- **Analytics** → Bounce rate desde búsqueda orgánica

### Cómo recuperarse:
1. **Analizar query intent** → ¿Qué busca realmente el usuario?
2. **Mejorar contenido above-the-fold** → Respuesta rápida
3. **Añadir valor real** → No solo texto, recursos útiles
4. **Optimizar velocidad** → Core Web Vitals
5. **UX improvements** → Navegación clara, sin popups agresivos

---

## 5. Product Reviews Quality Demotion

### Qué es:
Páginas de reviews de productos con contenido thin o poco útil son demotionadas.

### Evidencia del leak:
```
ProductReviewQualitySignals
- reviewDepth: float
- originalAnalysis: boolean
- productData: structured
```

### Factores evaluados:
| Factor | Qué busca Google |
|--------|------------------|
| **Profundidad** | Reviews de 1000+ palabras con análisis real |
| **Originalidad** | Experiencia personal, no specs copiadas |
| **Datos estructurados** | Schema markup de review |
| **Multimedia** | Fotos/videos propios del producto |
| **Comparativas** | Alternativas mencionadas |

### Cómo evitarla:
- Reviews originales con experiencia real
- Pros/cons detallados
- Fotos/videos propios
- Comparativas con otros productos
- Schema markup correcto

---

## 6. Adult Content Demotion

### Qué es:
Contenido adulto/pornográfico es filtrado y demotionado en resultados generales.

### Evidencia del leak:
```
AdultContentDemotion
- isAdult: boolean
- adultScore: float
- safeSearchOverride: boolean
```

### Aplicación:
- SafeSearch activado por defecto → contenido adulto oculto
- Búsquedas sin intención adulta → demotion aplicada
- No afecta a sitios legítimos de salud/educación

---

## 7. User Location Mismatch Demotion

### Qué es:
Cuando el contenido no coincide con la ubicación del usuario.

### Evidencia del leak:
```
UserLocationSignals
- userLocation: geo
- pageRelevance: geo[]
- mismatchScore: float
```

### Ejemplo:
- Usuario en México → Resultado de España → Potencial demotion
- Usuario en Buenos Aires → Resultado de Madrid → Menos relevante

### Cómo evitarla:
| Acción | Para sitios |
|--------|-------------|
| Hreflang tags | Múltiples idiomas/regiones |
| Geo-targeting en GSC | Específico por país |
| Contenido localizado | Negocios locales |
| IP detection + redirect | E-commerce multi-país |

---

## 8. Page Quality Low Demotion

### Qué es:
Páginas con señales de baja calidad general son demotionadas.

### Señales negativas:
| Señal | Peso |
|-------|------|
| `spamScore` alto | 🔴 Alto |
| `nsr` bajo | 🔴 Alto |
| `ymylScore` bajo (para YMYL) | 🔴 Alto |
| Contenido thin | 🟡 Medio |
| E-E-A-T bajo | 🟡 Medio |

### Evidencia del leak:
```
CompressedQualitySignals
- spamScore: float
- nsr: float (Neural Site Rank)
- ymylScore: float
- siteAuthority: float
```

---

## 9. Checklist de Recuperación

Si sospechas demotion:

### Paso 1: Diagnóstico
- [ ] Revisar tráfico en GSC (¿caída repentina?)
- [ ] Verificar manual actions en GSC
- [ ] Analizar backlinks recientes (¿spam?)
- [ ] Revisar contenido reciente (¿thin? ¿duplicado?)

### Paso 2: Identificar causa probable
| Síntoma | Causa probable |
|---------|----------------|
| Caída en queries específicos | Anchor mismatch |
| Caída general del sitio | siteAuthority bajo |
| Caída en reviews | Product review quality |
| Caída en EMD | EMD demotion |
| Bounce rate alto | SERP dissatisfaction |

### Paso 3: Acción correctiva
1. **Anchor mismatch:** Disavow + contacto webmasters
2. **EMD:** Mejorar contenido, construir marca
3. **SERP dissatisfaction:** Mejorar UX + contenido
4. **Product reviews:** Añadir profundidad + multimedia
5. **Page quality:** E-E-A-T improvements

---

## 10. Referencias Cruzadas

### Documentación Interna:
- `ref-google-leak-ranking-systems.md` → Sistemas de ranking
- `ref-google-leak-seo-checklist.md` → Checklist para clientes
- `ref-google-anchors-seo-guide.md` → Guía de anchors

### Fuentes:
- Google Content Warehouse API Leak (Mar 2024)
- DOJ testimony (Feb 2025)
- iPullRank analysis (May 2024)

---

**Creado:** 2026-02-21 12:12 UTC
**Próxima revisión:** 2026-03-21
