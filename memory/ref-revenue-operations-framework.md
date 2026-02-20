# Revenue Operations (RevOps) Framework Reference

**Propósito:** Framework de Revenue Operations para PYMEs.
**Uso:** Implementar en clientes de Daniel (clínica dental, etc.).

---

## ¿Qué es RevOps?

Unificación de Marketing, Sales y Customer Success en un solo sistema operativo de revenue.

| Sin RevOps | Con RevOps |
|------------|------------|
| Silos entre equipos | Datos unificados |
| Métricas desconectadas | Pipeline completo visible |
| Leads perdidos | Tracking end-to-end |
| Reporting manual | Dashboard automático |

---

## Los 3 Pilares

### 1. Marketing Operations
- Lead generation
- Scoring y qualification
- Attribution tracking
- Campaign optimization

### 2. Sales Operations
- Pipeline management
- Forecasting
- CRM hygiene
- Quota planning

### 3. Customer Success Operations
- Onboarding tracking
- Churn prediction
- Expansion opportunities
- NPS/CSAT monitoring

---

## Stack Tecnológico Mínimo

| Categoría | Herramienta | Alternativa |
|-----------|-------------|-------------|
| CRM | HubSpot | PocketBase custom |
| Automation | n8n | Make/Zapier |
| Analytics | Metabase | Google Data Studio |
| Communication | Email sequences | LinkedIn automation |
| Data | PocketBase | Airtable |

---

## Métricas Clave (KPIs)

### Marketing
- MQLs generados/mes
- CAC (Costo de Adquisición)
- Conversion rate por canal

### Sales
- Pipeline value
- Win rate
- Sales cycle length
- ARR/MRR

### Customer Success
- Churn rate
- LTV (Lifetime Value)
- NPS score
- Expansion revenue

---

## Implementación para PYMEs

### Fase 1: Fundamentos (2-4 semanas)
1. Definir funnel stages
2. Configurar CRM básico
3. Implementar tracking de leads

### Fase 2: Automatización (4-6 semanas)
1. Workflows n8n para lead routing
2. Email sequences automáticos
3. Scoring model básico

### Fase 3: Optimización (continuo)
1. Dashboard de métricas
2. A/B testing de campañas
3. Forecasting mejorado

---

## Template: Clínica Dental

**Funnel:**
1. Lead: Agenda llamada o formulario
2. MQL: Interés confirmado
3. SQL: Citación agendada
4. Cliente: Primera consulta
5. Recurrente: Tratamiento completo

**Automatizaciones sugeridas:**
- Recordatorios de cita (WhatsApp/Email)
- Follow-up post-consulta
- Re-activación de leads fríos
- NPS automático post-tratamiento

---

## En OpenClaw

- PocketBase como base de datos central
- n8n para automatizaciones
- Dashboard en Metabase o custom
- Integración con herramientas de Daniel

---

## Relacionado con

- TODO.md items #1, #24, #31, #32
- Proyectos Daniel: Revenue Software

---

_Creado: 2026-02-20 04:27 UTC - Micro-tarea autónoma_
