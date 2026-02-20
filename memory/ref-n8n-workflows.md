# n8n Workflows Reference

**Propósito:** Patrones de workflows n8n para automatizaciones de Daniel.
**Contexto:** n8n corre en Docker, usado para automatizaciones de marketing.

---

## Estado Actual

| Container | Uptime | Puerto |
|-----------|--------|--------|
| n8n-mkt | 6 días | 5678 |

---

## Patrones Comunes

### 1. Lead Routing

```
Webhook (form submission)
    → Validate data
    → Check scoring
    → Route to CRM/Email
    → Send notification
```

**Nodos típicos:** Webhook, Switch, HTTP Request, Gmail/Slack

---

### 2. Email Sequences

```
Trigger (new lead)
    → Wait 1 day
    → Send email #1
    → Wait 3 days
    → Check if opened
    → If no → Send email #2
    → If yes → Update CRM
```

**Nodos típicos:** Trigger, Wait, Email, If, HTTP Request

---

### 3. Data Sync (PocketBase ↔ Airtable)

```
Schedule (hourly)
    → Fetch PocketBase records
    → Fetch Airtable records
    → Compare
    → Sync differences
    → Log changes
```

**Nodos típicos:** Schedule, HTTP Request, Merge, Code, HTTP Request

---

### 4. Content Generation Pipeline

```
Trigger (topic request)
    → Call AI API (Gemini/Claude)
    → Parse output
    → Format for platform
    → Save to PocketBase
    → Notify team
```

**Nodos típicos:** Trigger, HTTP Request, Code, PocketBase, Slack

---

### 5. LinkedIn Data Processing

```
CSV upload (LinkedIn export)
    → Parse CSV
    → Transform data
    → Enrich with Clearbit/PeopleDataLabs
    → Save to PocketBase
    → Generate report
```

**Nodos típicos:** Read Binary File, Spreadsheet File, Code, HTTP Request, PocketBase

---

## Conexiones Disponibles

| Servicio | Tipo | Uso |
|----------|------|-----|
| **PocketBase** | HTTP Request | CRUD operations |
| **Gmail** | Built-in node | Send emails |
| **Slack** | Built-in node | Notifications |
| **Google Sheets** | Built-in node | Read/write data |
| **OpenAI** | Built-in node | AI completions |
| **HTTP Request** | Generic | Any API |

---

## PocketBase Integration

### Autenticación

```javascript
// Obtener token
const response = await fetch('http://pocketbase:8090/api/admins/auth-with-password', {
  method: 'POST',
  headers: { 'Content-Type': 'application/json' },
  body: JSON.stringify({
    identity: 'admin@example.com',
    password: 'PASSWORD'
  })
});
const { token } = await response.json();
```

### CRUD Operations

| Operación | Endpoint | Método |
|-----------|----------|--------|
| List | `/api/collections/{collection}/records` | GET |
| Create | `/api/collections/{collection}/records` | POST |
| Update | `/api/collections/{collection}/records/{id}` | PATCH |
| Delete | `/api/collections/{collection}/records/{id}` | DELETE |

---

## Best Practices

| Práctica | Descripción |
|----------|-------------|
| **Error handling** | Siempre añadir "On Error" branches |
| **Rate limiting** | Añadir Wait entre llamadas API |
| **Logging** | Guardar errores en tabla de logs |
| **Idempotency** | Verificar antes de crear duplicados |
| **Secrets** | Usar credentials, no hardcodear |

---

## Variables de Entorno

```bash
# En n8n settings
POCKETBASE_URL=http://pocketbase:8090
POCKETBASE_ADMIN_EMAIL=admin@example.com
POCKETBASE_ADMIN_PASSWORD=SECRET
OPENAI_API_KEY=sk-...
GEMINI_API_KEY=...
```

---

## Debugging

```bash
# Ver logs del container
docker logs n8n-mkt --tail 100

# Entrar al container
docker exec -it n8n-mkt sh

# Ver workflows guardados
ls /home/node/.n8n/
```

---

## Proyectos Pendientes (TODO)

| # | Proyecto | Estado |
|---|----------|--------|
| 10 | n8n ↔ PocketBase bridge | Diseñar |
| 33 | LinkedIn data processing | Diseñar |
| 37 | Content generation workflow | Crear |
| 38 | Email sequences template | Diseñar |

---

## Recursos

- [n8n Docs](https://docs.n8n.io/)
- [n8n Community](https://community.n8n.io/)
- TODO.md items #10, #33, #37, #38

---

_Creado: 2026-02-20 04:52 UTC - Micro-tarea autónoma_
