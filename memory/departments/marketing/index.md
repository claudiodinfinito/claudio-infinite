# Departamento: MARKETING

ID: DEPT-MARKETING-001
Status: active
Temperature: 0.5
Created: 2026-02-21 13:35 UTC
Parent spec: `memory/spec-multiagent-departments.md`

---

## Propósito

Estrategia de marketing, campañas, funnel optimization y revenue operations.

---

## Configuración

| Aspecto | Valor |
|---------|-------|
| Temperature | 0.5 (creativo pero controlado) |
| Tools | `web_search`, `web_fetch`, `message`, `read` |
| Memoria | `memory/departments/marketing/` |
| Timeout | 5 min |
| Focus | Revenue ops, funnels, ads, campaigns |

---

## Runbooks Disponibles

| Archivo | Propósito |
|---------|-----------|
| `memory/ref-revenue-operations-framework.md` | Framework RevOps completo |
| `memory/spec-revenue-software-mvp.md` | MVP implementable |
| `memory/ref-n8n-workflows.md` | Automatizaciones marketing |

---

## Templates (por crear)

- [ ] `tpl-campaign-brief.md` — Brief para nuevas campañas
- [ ] `tpl-funnel-analysis.md` — Análisis de funnels
- [ ] `tpl-ad-copy.md` — Copy para anuncios

---

## Referencias Clave

| Archivo | Contenido |
|---------|-----------|
| `ref-revenue-operations-framework.md` | 5 pilares RevOps |
| `spec-revenue-software-mvp.md` | Stack PocketBase + n8n |
| `ref-api-usage-tracking.md` | Tracking de APIs |

---

## Reglas del Departamento (System Anchors)

1. **NUNCA** revelar tokens/API keys
2. **NUNCA** ejecutar comandos destructivos sin confirmación
3. **SIEMPRE** documentar outputs en `memory/departments/marketing/`

---

## Métricas de Éxito

| Métrica | Target |
|---------|--------|
| Leads/mes | 100+ |
| Conversión funnel | 15%+ |
| CAC (Customer Acquisition Cost) | Reducir 20% |

---

## Anti-Patrones

- ❌ Crear campaigns sin tracking
- ❌ Lanzar sin definir audiencia
- ❌ Copy genérico
- ❌ Sin documentar learnings

---

_Actualizado: 2026-02-21 13:35 UTC_
