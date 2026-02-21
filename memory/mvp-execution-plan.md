# MVP RevOps Agency - Plan Ejecución

**Fecha:** 2026-02-21 19:30 UTC
**Objetivo:** Cliente real compra servicio de Google Ads

---

## FLUJO CLIENTE

```
Cliente entra a landing
    ↓
Ve servicios productizados (Google Ads $X/mes)
    ↓
Click "Comprar"
    ↓
Stripe checkout (server-side)
    ↓
Paga
    ↓
Webhook Stripe → Astro Action
    ↓
Crear lead + deal + client en PocketBase
    ↓
Cliente ve su portal (kanban, suscripción)
```

---

## COLLECTIONS POCKETBASE

### leads (YA EXISTE)
- email, source, pain_point, budget, timeline, status

### deals (YA EXISTE)
- lead, service, value, stage, probability, close_date, next_action

### clients (YA EXISTE)
- lead, status, mrr, start_date

### products (CREAR)
- name, price, stripe_product_id, description, features

### subscriptions (CREAR)
- client, stripe_subscription_id, status, current_period_end

---

## ASTRO FRONTEND

### Páginas:
1. `/` - Landing con servicios
2. `/checkout/[product]` - Stripe checkout
3. `/portal/[client]` - Client portal (kanban, suscripción)
4. `/success` - Post-pago

### Astro Actions:
1. `create-checkout-session` - Crear sesión Stripe
2. `stripe-webhook` - Recibir pagos
3. `create-lead` - Guardar en PocketBase
4. `create-deal` - Guardar deal
5. `create-client` - Guardar cliente

---

## STRIPE SETUP

### Productos a crear:
1. Google Ads Management - $X/mes
2. SEO Audit - $X one-time
3. Web Development - $X one-time

### Webhooks:
- `checkout.session.completed` → Crear client
- `invoice.paid` → Actualizar MRR
- `customer.subscription.deleted` → Marcar churned

---

## SEGURIDAD

- Stripe checkout server-side (no exponer API key)
- Webhook signature verification
- PocketBase auth para client portal
- HTTPS obligatorio

---

## DEPLOY

- VPS: Ya tenemos PocketBase corriendo
- Frontend: Astro en CapRover o VPS directo
- Dominio: subdominio de adwebcrm.com

---

## TIEMPO ESTIMADO

- PocketBase setup: 10 min ✅
- Astro frontend: 30 min
- Stripe integration: 20 min
- Deploy: 10 min
- **Total: 70 min**

---

_Creado: 2026-02-21 19:30 UTC - Ejecución inmediata_
