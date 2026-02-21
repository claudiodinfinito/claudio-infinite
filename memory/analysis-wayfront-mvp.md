# Wayfront/SPP.co - Análisis y MVP Propuesto

**Fecha:** 2026-02-21 19:12 UTC

---

## QUÉ ES WAYFRONT (ANTES SPP.CO)

**Client Portal para agencias productizadas.**

### Features principales:

| Categoría | Features |
|-----------|----------|
| **Sell** | Client portal, Billing, CRM |
| **Service** | Projects, Form builder, Helpdesk |
| **Scale** | Referrals, Analytics, White-label |

---

## MODELO DE NEGOCIO

| Aspecto | Detalle |
|---------|---------|
| **Target** | Agencias de marketing digital productizadas |
| **Propuesta** | Todo-en-uno: vender + entregar + escalar |
| **Pricing** | Precio fijo mensual, sin transaction fees |
| **Diferenciador** | Elimina "tool sprawl" (múltiples herramientas) |

---

## FEATURES CLAVE

### 1. Client Portal
- Branded con tu dominio
- Ordenes, archivos, mensajes
- Template editor

### 2. CRM
- Leads, contacts, clients
- Sales pipeline
- Activity history

### 3. Billing
- Subscriptions
- Invoices
- Stripe integration (no transaction fees)

### 4. Projects
- Asignación de trabajo
- Tracking automático
- Form builder con e-signatures

### 5. Helpdesk
- Support tickets
- Client context

### 6. Scale
- Referral/affiliate program
- Analytics de revenue
- White-label para revendedores

---

## NUESTRO MVP

**NO copiar Wayfront. Hacer lo mínimo que FUNCIONA.**

### Fase 1: Core (2 semanas)

| Feature | Por qué |
|---------|---------|
| **Client Portal** | Donde el cliente ve todo |
| **Leads** | Capturar interés |
| **Deals** | Cerrar ventas |
| **Billing básico** | Cobrar (Stripe checkout) |

### Fase 2: Service (1 semana)

| Feature | Por qué |
|---------|---------|
| **Projects** | Entregar el trabajo |
| **Helpdesk** | Soporte básico |

### Fase 3: Scale (1 semana)

| Feature | Por qué |
|---------|---------|
| **Analytics** | Ver qué funciona |
| **Referrals** | Crecer sin ads |

---

## COLLECTIONS POCKETBASE (MVP)

### 1. leads (Captura)

| Campo | Tipo | Propósito |
|-------|------|-----------|
| email | email | Contacto |
| source | text | De dónde vino |
| pain_point | text | Problema |
| budget | select | Rango: <$1k, $1-5k, $5-10k, $10k+ |
| timeline | select | urgent, 30d, 90d, exploring |
| status | select | new, contacted, qualified, lost |

### 2. deals (Pipeline)

| Campo | Tipo | Propósito |
|-------|------|-----------|
| lead | relation | Link al lead |
| service | select | SEO, ads, web, consulting |
| value | number | Valor del deal |
| stage | select | discovery, proposal, negotiation, won, lost |
| probability | number | % |
| close_date | date | Cuándo |

### 3. clients (Ganados)

| Campo | Tipo | Propósito |
|-------|------|-----------|
| lead | relation | Lead original |
| stripe_customer | text | ID de Stripe |
| status | select | active, churned, paused |
| mrr | number | Monthly recurring revenue |

### 4. projects (Entrega)

| Campo | Tipo | Propósito |
|-------|------|-----------|
| client | relation | Cliente |
| name | text | Nombre del proyecto |
| status | select | onboarding, in_progress, review, completed |
| due_date | date | Deadline |
| assigned_to | relation | Usuario responsable |

### 5. tickets (Soporte)

| Campo | Tipo | Propósito |
|-------|------|-----------|
| client | relation | Cliente |
| subject | text | Asunto |
| status | select | open, in_progress, resolved |
| priority | select | low, medium, high, urgent |

---

## DIFERENCIA CON WAYFRONT

| Wayfront | NOSOTROS |
|----------|----------|
| Todo-en-uno enorme | MVP funcional en 4 semanas |
| $500M+ vendidos | Empezar de cero |
| Features para todos | Features para TU agencia |
| Generic CRM | Revenue-focused |

---

## PRÓXIMO PASO

**Definir:**

1. ¿Estas 5 collections tienen sentido?
2. ¿Falta algo crítico?
3. ¿Queremos billing desde día 1 o después?
4. ¿El portal es para clientes o para tu equipo primero?

---

_Creado: 2026-02-21 - Análisis Wayfront para RevOps MVP_
