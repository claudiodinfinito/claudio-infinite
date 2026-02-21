# MVP: Revenue Software para PYMEs

**Autor:** Claudio (subagente)
**Fecha:** 2026-02-21 04:22 UTC
**Basado en:** `ref-revenue-operations-framework.md`

---

## 1. Resumen del Problema

Las PYMEs (ej: clínicas dentales, consultorios, agencias) pierden revenue por:

- **Leads sin seguimiento:** 60% de leads nunca reciben follow-up
- **Datos dispersos:** CRM, WhatsApp, email, sheets no se conectan
- **Sin visibilidad:** No saben qué funciona (marketing, sales, retención)
- **Procesos manuales:** Tareas repetitivas consumen tiempo del equipo

**El MVP resuelve:** Tracking unificado de leads + automatización básica de follow-up + visibilidad de pipeline.

---

## 2. Features MVP (Máximo 5)

### ✅ Feature 1: Pipeline de Leads Visual
**Qué hace:** Kanban board con leads en stages (Nuevo → Contactado → Calificado → Cliente)
**Para quién:** Dueño/equipo de ventas
**Valor:** Visibilidad instantánea del funnel, identificación de cuellos de botella

### ✅ Feature 2: Captura de Leads Multicanal
**Qué hace:** Formularios web + WhatsApp integration + Importación manual
**Para quién:** Marketing y ventas
**Valor:** Todos los leads en un solo lugar, sin duplicados

### ✅ Feature 3: Automatización de Follow-up
**Qué hace:** Workflows n8n para:
- Email de bienvenida automático (nuevo lead)
- Recordatorio si no hay respuesta en 48h
- Notificación al equipo para leads "fríos"
**Para quién:** Ventas
**Valor:** Ningún lead se pierde, reduce churn de leads en 40%

### ✅ Feature 4: Dashboard de Métricas Básico
**Qué hace:** 4 KPIs esenciales:
- Leads por mes
- Conversion rate por stage
- Tiempo promedio en pipeline
- Valor estimado del pipeline
**Para quién:** Dueño/Gerencia
**Valor:** Toma de decisiones basada en datos

### ✅ Feature 5: Gestión de Contactos + Notas
**Qué hace:** Ficha de contacto con historial de interacciones, notas, tags
**Para quién:** Todo el equipo
**Valor:** Contexto completo antes de cada interacción

---

## 3. Features Nice-to-Have (Post-MVP)

| Feature | Prioridad | Complejidad |
|---------|-----------|-------------|
| Scoring de leads automático | Media | Alta |
| Integración con calendario (agendar citas) | Alta | Media |
| WhatsApp Business API nativo | Alta | Media |
| Email sequences avanzados | Media | Baja |
| Reportes PDF automáticos | Baja | Media |
| Multi-usuario con roles | Media | Media |
| API pública para integraciones | Baja | Alta |
| Mobile app | Baja | Alta |

---

## 4. Stack Tecnológico Sugerido

```
┌─────────────────────────────────────────────┐
│           FRONTEND (Astro)                   │
│  - Dashboard React islands                   │
│  - Kanban board (react-kanban)               │
│  - Autenticación (PocketBase SDK)            │
│  - Desplegado en VPS (Node.js adapter)       │
└─────────────────────────────────────────────┘
                      ↓ API REST
┌─────────────────────────────────────────────┐
│        BACKEND (PocketBase)                  │
│  - Base de datos SQLite                      │
│  - Auth integrado (email/password)           │
│  - API REST auto-generada                    │
│  - Webhooks para n8n                         │
│  - Colecciones: leads, contacts, notes,      │
│    activities, users                         │
└─────────────────────────────────────────────┘
                      ↓ Webhooks
┌─────────────────────────────────────────────┐
│         AUTOMATION (n8n)                     │
│  - Email workflows (SendGrid/Resend)         │
│  - Lead routing logic                        │
│  - Notificaciones (Slack/Telegram)           │
│  - WhatsApp Business API (cuando ready)      │
└─────────────────────────────────────────────┘
```

### ¿Por qué este stack?

| Tecnología | Razón |
|------------|-------|
| **Astro** | Rápido, SEO-friendly, React islands para interactividad, ya en VPS |
| **PocketBase** | Backend listo en minutos, SQLite simple, auth integrado, sin costo extra |
| **n8n** | Ya instalado en VPS, 400+ integraciones, visual para no-devs |

---

## 5. Arquitectura Propuesta

### Base de Datos (PocketBase Collections)

```
leads/
├── id (auto)
├── nombre (text)
├── email (email)
├── telefono (text)
├── source (select: web, whatsapp, referral, manual)
├── stage (select: nuevo, contactado, calificado, cliente, perdido)
├── valor_estimado (number)
├── tags (relation multi)
├── owner (relation user)
├── created (auto)
├── updated (auto)

contacts/
├── id (auto)
├── nombre (text)
├── empresa (text)
├── email (email)
├── telefono (text)
├── notas (editor)
├── tags (relation multi)

notes/
├── id (auto)
├── lead (relation)
├── contenido (editor)
├── autor (relation user)
├── created (auto)

activities/
├── id (auto)
├── lead (relation)
├── tipo (select: email, llamada, whatsapp, meeting)
├── descripcion (text)
├── created (auto)

tags/
├── id (auto)
├── nombre (text)
├── color (text)
```

### Flujo de Datos

```
[Nuevo Lead entra]
    ↓
[PocketBase: crear registro] → [Webhook n8n]
                                  ↓
                           [Email de bienvenida]
                                  ↓
[Usuario ve lead en Kanban] → [Mueve a "Contactado"]
                                  ↓
                         [Log automático en activities]
```

---

## 6. Estimación de Tiempo

### Fase 1: Setup Backend (PocketBase) — 2 días
- [ ] Instalar/configurar PocketBase en VPS
- [ ] Crear colecciones (leads, contacts, notes, activities, tags)
- [ ] Configurar auth y permisos
- [ ] Crear datos de prueba

### Fase 2: Frontend Core (Astro) — 4 días
- [ ] Setup proyecto Astro con React
- [ ] Página de login/auth
- [ ] Dashboard con KPIs (4 métricas)
- [ ] Vista Kanban de leads
- [ ] Formulario nuevo lead
- [ ] Ficha de contacto con notas

### Fase 3: Automatizaciones (n8n) — 2 días
- [ ] Workflow: Email bienvenida nuevo lead
- [ ] Workflow: Recordatorio 48h sin contacto
- [ ] Workflow: Notificación lead perdido
- [ ] Webhooks desde PocketBase

### Fase 4: Testing + Polish — 2 días
- [ ] Testing end-to-end
- [ ] Ajustes UX/UI
- [ ] Documentación básica
- [ ] Deploy producción

---

## 7. Cronograma Total

| Fase | Tiempo | Acumulado |
|------|--------|-----------|
| Backend | 2 días | 2 días |
| Frontend | 4 días | 6 días |
| Automatizaciones | 2 días | 8 días |
| Testing | 2 días | **10 días** |

**Con 4-6 horas/día de desarrollo:** ~2-3 semanas

**Con desarrollo full-time (8h/día):** ~1.5 semanas

---

## 8. Costos Estimados

| Item | Costo | Nota |
|------|-------|------|
| PocketBase | $0 | Open source, self-hosted |
| Astro hosting | $0 | VPS existente |
| n8n | $0 | Self-hosted en VPS |
| Dominio | ~$12/año | Opcional |
| Email (SendGrid) | $0 | 100 emails/día gratis |
| **Total mensual** | **$0** | Solo tiempo de desarrollo |

---

## 9. Primer Cliente Piloto Sugerido

**Clínica Dental** (del framework original)

**Por qué:**
- Flujo claro: Lead → Cita → Consulta → Tratamiento
- Volumen manejable para testing
- Necesidad real de follow-up automático
- ROI visible rápidamente (menos leads perdidos = más pacientes)

**Métrica de éxito:** Reducción de leads perdidos de 60% a <20% en 30 días.

---

## 10. Próximos Pasos (Checklist)

- [ ] Validar features MVP con Daniel
- [ ] Definir dominio/subdominio
- [ ] Configurar PocketBase en VPS
- [ ] Crear wireframes básicos
- [ ] Iniciar Fase 1 (Backend)

---

_Este spec define el producto mínimo viable funcional para validar el concepto de Revenue Software con un cliente piloto._
