# Template: SEO Audit para Clientes

**Versión:** 1.0
**Tiempo estimado:** 2-3 horas
**Output:** Documento markdown + checklist accionable

---

## 1. Setup Inicial (15 min)

```bash
# Verificar indexación
site:cliente.com

# Verificar robots.txt
cliente.com/robots.txt

# Verificar sitemap
cliente.com/sitemap.xml
```

---

## 2. Technical SEO (45 min)

| Check | Tool | Pass/Fail |
|-------|------|-----------|
| HTTPS | Browser | ☐ |
| Page Speed >90 | PageSpeed Insights | ☐ |
| Mobile-friendly | Mobile Test | ☐ |
| Structured Data | Schema Validator | ☐ |
| Canonical tags | View Source | ☐ |
| Meta robots | View Source | ☐ |
| Hreflang (si aplica) | View Source | ☐ |

---

## 3. On-Page SEO (30 min)

| Check | Tool | Pass/Fail |
|-------|------|-----------|
| Title tag <60 chars | View Source | ☐ |
| Meta description <160 | View Source | ☐ |
| H1 único | View Source | ☐ |
| Alt text en imágenes | View Source | ☐ |
| Internal linking | Crawl | ☐ |
| URL structure | Manual | ☐ |

---

## 4. Google Leak Checks (20 min)

Basado en `ref-google-leak-seo-checklist.md`:

| Señal | Check | Score |
|-------|-------|-------|
| Anchor diversity | Ahrefs | /10 |
| SourceType quality | Ahrefs | /10 |
| Domain diversity | Ahrefs | /10 |
| Content freshness | GSC | /10 |
| Click-through rate | GSC | /10 |

---

## 5. Content Audit (30 min)

```markdown
## Top 10 páginas por tráfico

| URL | Keywords | Traffic | CTR | Action |
|-----|----------|---------|-----|--------|
| 1 | X | X | X% | Optimize |
| 2 | X | X | X% | Keep |
```

---

## 6. Quick Wins (15 min)

Identificar:
- [ ] Páginas con impressions pero sin clicks → optimizar meta
- [ ] Páginas en posición 11-20 → boost con backlinks
- [ ] Páginas lentas → optimizar imágenes
- [ ] 404s → redirigir

---

## 7. Output Final

```markdown
# [Cliente] - SEO Audit

## Resumen Ejecutivo
- Health score: X/100
- Quick wins: X
- Medium priority: X
- Long term: X

## Quick Wins (implementar esta semana)
1. X
2. X

## Medium Priority (1-2 meses)
1. X

## Long Term (3+ meses)
1. X

## Herramientas recomendadas
- X

## Próximos pasos
- X
```

---

_Creado: 2026-02-20 — Template SEO para clientes_
