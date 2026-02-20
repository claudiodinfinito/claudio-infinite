# Spec: n8n ↔ PocketBase Bridge

ID: SPEC-N8N-PB-001
Status: draft
Tags: #n8n #pocketbase #integration #automation
Keys: n8n, pocketbase, bridge, sync, automation
Created: 2026-02-20

---

## Propósito

Sincronizar datos entre clientes y sistemas internos de Daniel usando n8n como orquestador y PocketBase como base de datos.

---

## Arquitectura

```
Cliente (Form/Webhook)
    ↓
n8n (Orquestador)
    ↓
PocketBase (DB)
    ↓
n8n (Automatizaciones)
    ↓
CRM/Email/Ads
```

---

## Casos de Uso

### 1. Lead Capture → PocketBase → Email Sequence
- Webhook recibe lead
- Guarda en PocketBase (colección `leads`)
- Dispara email de bienvenida (via n8n)

### 2. Sync Bidireccional Airtable ↔ PocketBase
- Cronjob cada 5 min
- Lee cambios de Airtable
- Actualiza PocketBase
- Viceversa

### 3. Facebook Lead Ads → PocketBase
- Webhook de Facebook
- Procesa en n8n
- Guarda en PocketBase
- Notifica a Daniel

---

## PocketBase Collections (Sugeridas)

```javascript
// leads
{
  id: string,
  nombre: string,
  email: string,
  telefono: string,
  fuente: string, // 'web', 'facebook', 'instagram'
  status: string, // 'nuevo', 'contactado', 'convertido'
  created: datetime,
  updated: datetime
}

// clientes
{
  id: string,
  nombre: string,
  empresa: string,
  email: string,
  plan: string,
  activo: boolean
}

// sync_log
{
  id: string,
  origen: string,
  destino: string,
  registros: number,
  fecha: datetime
}
```

---

## n8n Workflows (Diseño)

### Workflow 1: Lead Capture

```
[Webhook] → [Validate] → [PocketBase Create] → [Email Send] → [Slack Notify]
```

### Workflow 2: Sync Airtable ↔ PocketBase

```
[Cron 5min] → [Airtable Read] → [PocketBase Query] → [Compare] → [Update Changed]
```

### Workflow 3: Facebook Lead Ads

```
[FB Webhook] → [Transform Data] → [PocketBase Create] → [Tag in CRM]
```

---

## Configuración n8n

### Credentials necesarias:
- PocketBase API (admin token)
- Airtable API (si usa)
- Facebook Graph API
- Email provider (SendGrid/Mailgun)

### Variables de entorno:
```
POCKETBASE_URL=http://localhost:8090
POCKETBASE_ADMIN_TOKEN=[REDACTED]
AIRTABLE_API_KEY=[REDACTED]
```

---

## Seguridad

1. **Webhooks firmados** — verificar origen
2. **Rate limiting** — no saturar PocketBase
3. **Error handling** — reintentos con backoff
4. **Logs** — todo en `sync_log`

---

## Próximos Pasos

1. Crear colecciones en PocketBase
2. Configurar credenciales en n8n
3. Crear primer workflow (Lead Capture)
4. Probar con datos reales

---

_Esperando aprobación de Daniel para implementar._
