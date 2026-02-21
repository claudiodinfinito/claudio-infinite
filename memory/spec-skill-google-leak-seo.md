# Especificación: Skill de Google Leak SEO

**Creado:** 2026-02-21 16:10 UTC
**Estado:** DRAFT
**Propósito:** Crear skill de OpenClaw para análisis SEO basado en Google Leak

---

## TL;DR

Skill que automatiza auditorías SEO usando los hallazgos del leak de Google Content Warehouse (2,590 archivos, 2024).

---

## Nombre del Skill

`google-leak-seo` o `seo-leak-audit`

---

## Ubicación

```
~/.openclaw/skills/google-leak-seo/
├── SKILL.md          # Documentación
├── skill.json        # Configuración
└── templates/
    ├── audit-checklist.md
    └── report-template.md
```

---

## Funcionalidades

### 1. Auditoría SEO Rápida
- Analizar anchors (tipo, diversidad, spam)
- Verificar content quality signals
- Revisar technical foundation (CWV, mobile, HTTPS)

### 2. Análisis de Competencia
- Comparar anchors vs competencia
- Identificar gaps en content
- Detectar oportunidades de ranking

### 3. Checklist para Clientes
- Generar checklist priorizado
- Incluir recomendaciones accionables
- Exportar en markdown

---

## Inputs del Skill

```yaml
url: "https://cliente.com"
keywords: ["keyword1", "keyword2"]
competitors:
  - "https://competidor1.com"
  - "https://competidor2.com"
depth: "quick|full"  # quick=30min, full=2h
```

---

## Outputs del Skill

```markdown
# SEO Audit - [CLIENTE]

## Resumen Ejecutivo
- Score: X/100
- Problemas críticos: N
- Oportunidades: M

## 🔥 Alta Prioridad
### Anchor System
- [ ] Anchors contienen keywords objetivo
- [ ] Diversidad: X% variación
- [ ] Sin anchors spammy

### Content Quality
- [ ] E-E-A-T signals
- [ ] Freshness score
- [ ] Thin content detectado: N páginas

### Technical
- [ ] Core Web Vitals: LCP X, FID Y, CLS Z
- [ ] Mobile-friendly
- [ ] HTTPS activo

## 📊 Media Prioridad
[...]

## Recomendaciones Prioritarias
1. [Acción 1] - Impacto: Alto - Esfuerzo: Bajo
2. [Acción 2] - Impacto: Medio - Esfuerzo: Medio

## Próximos Pasos
- [ ] Implementar fixes críticos
- [ ] Revisar en 30 días
```

---

## Integración con Herramientas

| Herramienta | Uso |
|-------------|-----|
| `web_search` | Buscar información del dominio |
| `web_fetch` | Analizar páginas específicas |
| `read` | Leer checklists existentes |
| `write` | Guardar reportes |

---

## Archivos de Referencia

El skill usa estos archivos de memoria:

| Archivo | Contenido |
|---------|-----------|
| `ref-google-leak-seo-checklist.md` | Checklist completo |
| `ref-google-anchors-seo-guide.md` | Guía de anchors |
| `ref-google-ranking-checklist-clientes.md` | Checklist para clientes |
| `ref-google-leak-ranking-systems.md` | Sistemas de ranking |

---

## Comando de Uso

```bash
# En OpenClaw
openclaw skill run google-leak-seo --url "https://cliente.com" --keywords "keyword1,keyword2"
```

---

## Configuración (skill.json)

```json
{
  "name": "google-leak-seo",
  "version": "1.0.0",
  "description": "SEO audit based on Google Content Warehouse leak",
  "author": "Claudio",
  "tools": ["web_search", "web_fetch", "read", "write"],
  "timeout": 600,
  "memory": true
}
```

---

## Próximos Pasos

1. Crear directorio `~/.openclaw/skills/google-leak-seo/`
2. Escribir `SKILL.md` con instrucciones completas
3. Crear `skill.json` con configuración
4. Crear templates de reportes
5. Probar con dominio de ejemplo

---

## Referencias

- `memory/ref-google-leak-seo-checklist.md`
- `memory/ref-google-anchors-seo-guide.md`
- `memory/ref-google-ranking-checklist-clientes.md`
- https://docs.openclaw.ai/skills

---

_Actualizado: 2026-02-21 16:10 UTC - Spec lista para implementar_
