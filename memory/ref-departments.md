# Departamentos del Sistema Multiagente

ID: REF-DEPT-001
Tags: #departments #multiagent #organization
Keys: departments, multiagent, marketing, frontend, backend, seo, copy, emprendimiento
Last reviewed: 2026-02-19

---

## Los 6 Departamentos

| Dept | Focus | Temperature | Directorio |
|------|-------|-------------|------------|
| **MARKETING** | Revenue ops, funnels, ads | 0.5 | `departments/marketing/` |
| **FRONTEND** | Astro, UI/UX, componentes | 0.4 | `departments/frontend/` |
| **BACKEND** | APIs, Docker, VPS | 0.3 | `departments/backend/` |
| **SEO** | Keywords, technical, Google Leak | 0.4 | `departments/seo/` |
| **COPY** | Copywriting, persuasión | 0.6 | `departments/copy/` |
| **EMPRENDIMIENTO** | Business, estrategia | 0.5 | `departments/emprendimiento/` |

---

## Temperaturas

| Temp | Uso |
|------|-----|
| **0.3** | Backend - precisión, sin creatividad extra |
| **0.4** | Frontend/SEO - balance |
| **0.5** | Marketing/Emprendimiento - algo creativo |
| **0.6** | Copy - máximo creativo |

---

## Sistema de Handover

Cuando un departamento pasa trabajo a otro:

```json
{
  "from": "MARKETING",
  "to": "COPY",
  "artifact": "landing-brief.md",
  "brief_version": "1.3",
  "priority": "HIGH"
}
```

---

## Bus de Contexto Compartido

Archivo: `memory/shared/brief.md`

Todos los departamentos leen este archivo para contexto global.

---

## Gatekeeper Checklist

Antes de aceptar artefactos de otro dept:
1. ¿Brief version match?
2. ¿Formato correcto?
3. ¿Sin conflictos con system anchors?

---

_Creado: 2026-02-19 - Referencia de departamentos_
