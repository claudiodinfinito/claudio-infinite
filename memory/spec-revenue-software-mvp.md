# Spec: Revenue Software MVP

**Creado:** 2026-02-21 13:15 UTC (autonomía)
**Estado:** DRAFT
**Prioridad:** ALTA

---

## TL;DR

- MVP = PocketBase + n8n + 3 workflows core
- Target: PYMEs que quieren RevOps sin Salesforce
- Stack: Astro frontend + PocketBase backend + n8n automation

---

## El Problema

PYMEs tienen:
- Leads en WhatsApp/Instagram → sin tracking
- Cotizaciones en Excel → sin seguimiento
- Clientes perdidos → sin reactivación

**Resultado:** Pierden 30-50% de ingresos potenciales.

---

## La Solución (MVP)

### Stack Técnico

| Componente | Tecnología | Ya existe |
|------------|------------|-----------|
| Database | PocketBase | ✅ en VPS |
| Automation | n8n | ✅ en VPS |
| Frontend | Astro | ❌ crear |
| Auth | PocketBase | ✅ built-in |

### Features MVP (3 semanas)

**Semana 1: Data Foundation**
- [ ] PocketBase schema: leads, contacts, deals, activities
- [ ] Collections: leads, contacts, deals, tasks, notes
- [ ] API endpoints listos

**Semana 2: Automation Core**
- [ ] n8n workflow: Lead capture → PocketBase
- [ ] n8n workflow: Deal stage change → notification
- [ ] n8n workflow: Inactive client → reactivation email

**Semana 3: UI Mínima**
- [ ] Astro dashboard: ver leads
- [ ] Astro dashboard: mover deals
- [ ] Astro dashboard: ver actividades

---

## PocketBase Schema

```yaml
leads:
  - id: uuid
  - name: text
  - email: email
  - phone: text
  - source: select (whatsapp, instagram, website, referral)
  - status: select (new, contacted, qualified, lost)
  - created: datetime
  - updated: datetime

contacts:
  - id: uuid
  - name: text
  - email: email
  - phone: text
  - company: text
  - lead_id: relation (leads)

deals:
  - id: uuid
  - contact_id: relation (contacts)
  - value: number
  - stage: select (prospect, proposal, negotiation, closed-won, closed-lost)
  - probability: number (0-100)
  - expected_close: date
  - created: datetime
  - updated: datetime

activities:
  - id: uuid
  - deal_id: relation (deals)
  - type: select (call, email, meeting, note)
  - description: text
  - created: datetime

tasks:
  - id: uuid
  - deal_id: relation (deals)
  - title: text
  - due: datetime
  - done: boolean
```

---

## n8n Workflows (3 Core)

### Workflow 1: Lead Capture
```
Trigger: Webhook (desde form/WhatsApp)
→ Validar datos
→ Crear en PocketBase (leads collection)
→ Notificar al equipo (Telegram)
```

### Workflow 2: Pipeline Movement
```
Trigger: PocketBase webhook (deal updated)
→ Si stage cambió
→ Calcular nuevo valor esperado
→ Notificar al owner
→ Log en activities
```

### Workflow 3: Reactivation
```
Trigger: Cron diario (06:00)
→ Buscar contacts sin actividad 30+ días
→ Para cada uno:
  → Verificar si tiene deals abiertos
  → Si no: crear task "Reactivar [nombre]"
  → Notificar al equipo
```

---

## Diferenciadores vs CRM tradicional

| CRM Tradicional | Revenue Software MVP |
|-----------------|---------------------|
| $50-300/mes/usuario | $0 (self-hosted) |
| Setup 2-4 semanas | Setup 3 días |
| Features que no usas | Solo lo esencial |
| Vendor lock-in | Open source |
| Sin automatización | n8n integrado |

---

## Métricas de Éxito

| Métrica | Target MVP |
|---------|------------|
| Leads capturados | 100/mes |
| Tasa conversión | 15% |
| Tiempo respuesta lead | <4 horas |
| Reactivaciones | 5/mes |

---

## Siguiente Paso

1. Daniel aprueba schema
2. Yo creo PocketBase collections
3. Yo diseño n8n workflows
4. Daniel conecta frontend

---

## Rollback

Si no funciona:
- Borrar collections PocketBase
- Desactivar workflows n8n
- No hay costo fijo

---

_Autonomía 2026-02-21 13:15 UTC — Tarea #1 TODO.md_
