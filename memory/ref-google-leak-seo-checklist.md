# Google Leak SEO Checklist (Para Clientes)

**Fuente:** Google Content Warehouse API Leak (v0.2.0, 2,590 archivos)
**Propósito:** Checklist práctico para implementar en sitios de clientes.
**Referencias:** `ref-google-anchors-seo-guide.md`, `ref-seo-leak-signals.md`

---

## 🎯 Checklist Rápido (Lo que Google REALMENTE evalúa)

### 1. Anchors (Texto de Enlaces)

| Factor | Acción | Prioridad |
|--------|--------|-----------|
| **Anchor text relevante** | Usar keywords en enlaces internos | 🔴 Alta |
| **Anchor text externo** | Solicitar anchors específicos en backlinks | 🔴 Alta |
| **SourceType diverso** | Conseguir enlaces de múltiples fuentes | 🟡 Media |
| **Anchor frequency** | No repetir mismo anchor exacto | 🟡 Media |

**Comando verificar:** `site:tudominio.com` + ver anchor text en SERP

---

### 2. SourceType (Tipos de Fuentes)

Google clasifica fuentes en buckets. Diversificar mejora autoridad.

| SourceType | Ejemplo | Valor SEO |
|------------|---------|-----------|
| `NEWS` | Medios digitales | 🔴 Alto |
| `BLOG` | Posts invitados | 🟡 Medio |
| `FORUM` | Reddit, foros | 🟢 Bajo |
| `SOCIAL` | Twitter, LinkedIn | 🟢 Bajo (nofollow) |
| `WIKI` | Wikipedia | 🟡 Medio |

**Acción:** Crear estrategia de link building diversificada.

---

### 3. Calidad de Contenido

| Señal | Qué evalúa Google | Acción |
|-------|-------------------|--------|
| **OriginalityScore** | Contenido único vs duplicado | Crear contenido original |
| **NavBoostScore** | Utilidad para navegación | Mejorar UX, menús claros |
| **TopicAuthority** | Expertise en el tema | Publicar contenido profundo |
| **Freshness** | Actualización reciente | Actualizar contenido regularmente |

---

### 4. Señales de Spam (EVITAR)

| Señal | Qué detecta Google | Riesgo |
|-------|-------------------|--------|
| **Anchor stuffing** | Exceso de anchors con keyword exacta | 🔴 Penalización |
| **Link farms** | Redes de enlaces artificiales | 🔴 Penalización |
| **Cloaking** | Contenido diferente para bots | 🔴 Penalización |
| **PBN detectado** | Private Blog Networks | 🟠 Desautorización |

---

## 📊 Auditoría Rápida (5 min por cliente)

### Paso 1: Verificar Anchors

```bash
# Herramienta: Ahrefs/Semrush
# Exportar anchors → Analizar distribución
```

**Objetivo:** Anchor natural = 30% exact match, 40% partial match, 30% branded/generic

---

### Paso 2: Verificar SourceType

```bash
# Herramienta: Ahrefs → Referring domains → Filter by type
```

**Objetivo:** Diversidad de fuentes, no todo de un solo tipo.

---

### Paso 3: Verificar Contenido

| Check | Pregunta | Pass/Fail |
|-------|----------|-----------|
| ¿Contenido único? | Copyscape score < 10% | |
| ¿Actualizado? | Última edición < 6 meses | |
| ¿Profundo? | 1500+ palabras, valor real | |
| ¿Bien estructurado? | H1-H3, bullets, imágenes | |

---

## 🛠️ Herramientas Recomendadas

| Herramienta | Uso | Costo |
|-------------|-----|-------|
| Ahrefs | Backlinks, anchors | $99+/mes |
| Semrush | Auditoría SEO | $129+/mes |
| Screaming Frog | Crawling técnico | Gratis |
| Google Search Console | Rendimiento orgánico | Gratis |

---

## 📋 Template para Cliente

```
CLIENTE: [Nombre]
FECHA: [YYYY-MM-DD]

### Anchors
- [ ] Anchor distribution analizada
- [ ] % exact match: ___
- [ ] Acción: _______________

### SourceType
- [ ] Diversidad verificada
- [ ] Fuentes principales: _______________
- [ ] Acción: _______________

### Contenido
- [ ] Páginas principales auditadas
- [ ] Contenido duplicado: Sí/No
- [ ] Última actualización: _______________

### Próximos Pasos
1. _______________
2. _______________
3. _______________
```

---

## 🔗 Referencias Internas

- `ref-google-anchors-seo-guide.md` — Guía completa de anchors
- `ref-seo-leak-signals.md` — Señales específicas del leak
- `ref-google-content-warehouse-leak-analysis.md` — Análisis técnico

---

## ⚠️ Disclaimer

**Este checklist se basa en el leak del API interno de Google.**

- No es documentación oficial
- Los algoritmos cambian constantemente
- Usar como guía, no como verdad absoluta
- Siempre priorizar UX sobre SEO técnico

---

_Creado: 2026-02-20 05:47 UTC - Micro-tarea autónoma_
