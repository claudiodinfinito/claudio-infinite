# Spec: Sincronización Bidireccional Airtable ↔ PocketBase

**Creado:** 2026-02-21 04:22 UTC
**Propósito:** Diseñar arquitectura de sync bidireccional entre Airtable y PocketBase via n8n.

---

## 1. Arquitectura

```
┌─────────────┐         ┌─────────────┐         ┌─────────────┐
│   Airtable  │◄───────►│     n8n     │◄───────►│ PocketBase  │
│  (Source)   │   API   │  (Orchestr.)│  API/   │   (Target)  │
│             │         │             │  Webhook│             │
└─────────────┘         └─────────────┘         └─────────────┘
       ▲                       │                       ▲
       │                       │                       │
       │                       ▼                       │
       │               ┌─────────────┐                 │
       │               │   Estado    │                 │
       └───────────────│  (JSON/DB)  │─────────────────┘
                       └─────────────┘
```

### Flujo de Datos

| Dirección | Trigger | Mecanismo |
|-----------|---------|-----------|
| **Airtable → PB** | Schedule/Webhook | Poll cada 5 min o webhook de Airtable |
| **PB → Airtable** | Webhook PB | Tiempo real via hooks |
| **Bidireccional** | Ambos | Merge inteligente con timestamps |

### Componentes

1. **n8n Workflow Principal:** Orquestador central
2. **Tabla de Estado:** PocketBase collection `sync_state` para tracking
3. **Webhooks PocketBase:** Hooks en colecciones principales
4. **Airtable API:** Read/Write via HTTP Request

---

## 2. Webhooks PocketBase

### Crear Hooks en PocketBase

```bash
# En PocketBase, crear hooks via Admin UI o migraciones
# Archivo: pb_data/hooks/sync_hooks.js
```

### Hook: OnCreate (leads/contacts)

```javascript
// pb_hooks/sync_to_airtable.pb.js
// Se ejecuta en cada creación de registro

onRecordAfterCreateRequest((e) => {
    const record = e.record;
    
    // Enviar a n8n webhook
    $http.send({
        url: 'http://n8n:5678/webhook/pb-created',
        method: 'POST',
        body: JSON.stringify({
            collection: record.collection().name,
            id: record.id,
            data: record.export(),
            created: record.created,
            action: 'create',
            source: 'pocketbase'
        }),
        headers: {
            'Content-Type': 'application/json',
            'X-Sync-Token': process.env.SYNC_TOKEN
        }
    });
}, 'leads', 'contacts');
```

### Hook: OnUpdate

```javascript
onRecordAfterUpdateRequest((e) => {
    const record = e.record;
    
    $http.send({
        url: 'http://n8n:5678/webhook/pb-updated',
        method: 'POST',
        body: JSON.stringify({
            collection: record.collection().name,
            id: record.id,
            data: record.export(),
            updated: record.updated,
            action: 'update',
            source: 'pocketbase'
        }),
        headers: {
            'Content-Type': 'application/json',
            'X-Sync-Token': process.env.SYNC_TOKEN
        }
    });
}, 'leads', 'contacts');
```

### Hook: OnDelete

```javascript
onRecordAfterDeleteRequest((e) => {
    $http.send({
        url: 'http://n8n:5678/webhook/pb-deleted',
        method: 'POST',
        body: JSON.stringify({
            collection: e.record.collection().name,
            id: e.record.id,
            action: 'delete',
            source: 'pocketbase'
        }),
        headers: {
            'Content-Type': 'application/json',
            'X-Sync-Token': process.env.SYNC_TOKEN
        }
    });
}, 'leads', 'contacts');
```

---

## 3. Workflow n8n (Pasos)

### Workflow 1: Airtable → PocketBase (Schedule)

```
┌──────────────────┐
│  Schedule Trigger │ (cada 5 min)
└────────┬─────────┘
         │
         ▼
┌──────────────────┐
│  Get Last Sync   │ ← Leer último timestamp de sync_state
└────────┬─────────┘
         │
         ▼
┌──────────────────┐
│ HTTP Request     │ → Airtable: GET /records?filterByFormula=
│ (Airtable API)   │   "last_modified_time > '{lastSync}'"
└────────┬─────────┘
         │
         ▼
┌──────────────────┐
│  Split In Batches│ (100 records max)
└────────┬─────────┘
         │
         ▼
┌──────────────────┐
│   For Each       │
│   Record         │◄─────────────────┐
└────────┬─────────┘                  │
         │                            │
         ▼                            │
┌──────────────────┐                  │
│  Check Exists    │ → GET PocketBase │
│  in PB?          │   /records/{id}  │
└────────┬─────────┘                  │
         │                            │
    ┌────┴────┐                       │
    │         │                       │
    ▼         ▼                       │
┌───────┐ ┌───────┐                   │
│CREATE │ │UPDATE │                   │
│in PB  │ │in PB  │                   │
└───┬───┘ └───┬───┘                   │
    │         │                       │
    └────┬────┘                       │
         │                            │
         ▼                            │
┌──────────────────┐                  │
│ Update sync_state│                  │
└────────┬─────────┘                  │
         │                            │
         └────────────────────────────┘
```

### Workflow 2: PocketBase → Airtable (Webhook)

```
┌──────────────────┐
│ Webhook Trigger  │ ← /webhook/pb-created|updated|deleted
└────────┬─────────┘
         │
         ▼
┌──────────────────┐
│ Validate Token   │ → Check X-Sync-Token
└────────┬─────────┘
         │
         ▼
┌──────────────────┐
│ Switch (action)  │
└────────┬─────────┘
         │
    ┌────┼────┬───────┐
    │    │    │       │
    ▼    ▼    ▼       ▼
┌─────┐┌─────┐┌─────┐
│create││update││delete│
└──┬──┘└──┬──┘└──┬──┘
   │      │      │
   ▼      ▼      ▼
┌─────────────────────┐
│ HTTP Request        │
│ (Airtable API)      │
│ POST/PATCH/DELETE   │
└────────┬────────────┘
         │
         ▼
┌──────────────────┐
│ Log to sync_logs │
└──────────────────┘
```

### Workflow 3: Resolución de Conflictos

```
┌──────────────────┐
│  Conflict Detected│ (mismo ID modificado en ambos lados)
└────────┬─────────┘
         │
         ▼
┌──────────────────┐
│ Compare Timestamps│
└────────┬─────────┘
         │
    ┌────┴────┐
    │         │
    ▼         ▼
┌───────┐ ┌───────┐
│Airtable│ │PB wins│
│ wins   │ │       │
└───┬───┘ └───┬───┘
    │         │
    ▼         ▼
┌──────────────────┐
│ Apply Winner     │
│ to both sides    │
└────────┬─────────┘
         │
         ▼
┌──────────────────┐
│ Log Conflict     │
│ Resolution       │
└──────────────────┘
```

---

## 4. Mapeo de Campos

### Collection: `leads`

| Airtable Field | PocketBase Field | Tipo | Notas |
|----------------|------------------|------|-------|
| `Record ID` | `airtable_id` | text | Cross-reference |
| `Name` | `name` | text | |
| `Email` | `email` | email | Unique key |
| `Phone` | `phone` | text | |
| `Company` | `company` | text | |
| `Status` | `status` | select | Map values |
| `Source` | `source` | text | |
| `Notes` | `notes` | editor | |
| `Created Time` | `created` | datetime | Auto |
| `Last Modified` | `updated` | datetime | Auto |
| `Owner` | `owner_id` | relation | User ID |

### Collection: `contacts`

| Airtable Field | PocketBase Field | Tipo | Notas |
|----------------|------------------|------|-------|
| `Record ID` | `airtable_id` | text | |
| `Full Name` | `full_name` | text | |
| `Email` | `email` | email | Unique |
| `Phone` | `phone` | text | |
| `LinkedIn URL` | `linkedin_url` | url | |
| `Company` | `company_id` | relation | → companies |
| `Title` | `job_title` | text | |
| `Tags` | `tags` | json | Array |
| `Created` | `created` | datetime | |
| `Modified` | `updated` | datetime | |

### Tabla de Estado: `sync_state`

```javascript
{
    "id": "uuid",
    "collection": "leads|contacts",
    "last_sync": "2026-02-21T04:00:00Z",
    "direction": "airtable_to_pb|pb_to_airtable",
    "records_processed": 42,
    "errors": 0,
    "created": "auto",
    "updated": "auto"
}
```

### Tabla de Logs: `sync_logs`

```javascript
{
    "id": "uuid",
    "action": "create|update|delete|conflict",
    "collection": "leads",
    "record_id": "pb_xxx",
    "airtable_id": "recXXX",
    "direction": "airtable_to_pb",
    "status": "success|error",
    "error_message": "optional",
    "payload": "{}", // JSON
    "created": "auto"
}
```

---

## 5. Manejo de Errores

### Estrategia General

| Error Tipo | Acción | Retry |
|------------|--------|-------|
| **Network timeout** | Reintentar con backoff | 3x |
| **Auth failed** | Refrescar token y reintentar | 1x |
| **Rate limit** | Wait y reintentar | Sí |
| **Validation error** | Log y saltar | No |
| **Conflict** | Aplicar resolución | Sí |
| **Unknown** | Log y alertar | No |

### Retry Logic (n8n Code Node)

```javascript
// Retry con exponential backoff
const maxRetries = 3;
const baseDelay = 1000; // 1 segundo

async function retryWithBackoff(fn, retries = 0) {
    try {
        return await fn();
    } catch (error) {
        if (retries >= maxRetries) throw error;
        
        const delay = baseDelay * Math.pow(2, retries);
        await new Promise(r => setTimeout(r, delay));
        
        return retryWithBackoff(fn, retries + 1);
    }
}

// Uso
const result = await retryWithBackoff(() => 
    $http.request({ url: '...', method: 'POST', body: data })
);
```

### Dead Letter Queue

```javascript
// En caso de error persistente, guardar en DLQ
if (error && retriesExhausted) {
    await $http.post('http://pocketbase:8090/api/collections/sync_dlq/records', {
        original_action: action,
        original_payload: JSON.stringify(payload),
        error: error.message,
        retry_count: retries,
        created: new Date().toISOString()
    });
}
```

### Alertas

```javascript
// Notificar errores críticos
if (errorCount > 5) {
    await $http.post('SLACK_WEBHOOK_URL', {
        text: `🚨 Sync Error: ${errorCount} fallos en última ejecución`
    });
}
```

---

## Código de Ejemplo: n8n Workflow JSON

```json
{
  "name": "Airtable-PocketBase Sync",
  "nodes": [
    {
      "name": "Schedule Trigger",
      "type": "n8n-nodes-base.scheduleTrigger",
      "position": [250, 300],
      "parameters": {
        "rule": {
          "interval": [{"field": "minutes", "minutesInterval": 5}]
        }
      }
    },
    {
      "name": "Get Last Sync",
      "type": "n8n-nodes-base.httpRequest",
      "position": [450, 300],
      "parameters": {
        "url": "http://pocketbase:8090/api/collections/sync_state/records",
        "method": "GET",
        "queryParameters": {
          "parameters": [
            {"name": "filter", "value": "collection='leads'"},
            {"name": "sort", "value": "-created"},
            {"name": "perPage", "value": "1"}
          ]
        }
      }
    },
    {
      "name": "Fetch Airtable",
      "type": "n8n-nodes-base.httpRequest",
      "position": [650, 300],
      "parameters": {
        "url": "https://api.airtable.com/v0/{baseId}/leads",
        "authentication": "genericCredentialType",
        "method": "GET",
        "queryParameters": {
          "parameters": [
            {"name": "filterByFormula", "value": "LAST_MODIFIED_TIME() > '{$json.last_sync}'"}
          ]
        }
      },
      "credentials": {
        "httpQueryAuth": {
          "name": "Airtable API",
          "value": "airtable_api_key"
        }
      }
    },
    {
      "name": "Split Items",
      "type": "n8n-nodes-base.splitInBatches",
      "position": [850, 300],
      "parameters": {
        "batchSize": 100
      }
    },
    {
      "name": "Check Exists in PB",
      "type": "n8n-nodes-base.httpRequest",
      "position": [1050, 300],
      "parameters": {
        "url": "http://pocketbase:8090/api/collections/leads/records/{$json.airtable_id}",
        "method": "GET"
      },
      "continueOnFail": true
    },
    {
      "name": "Switch Create/Update",
      "type": "n8n-nodes-base.switch",
      "position": [1250, 300],
      "parameters": {
        "rules": [
          {"output": 0, "conditions": {"string": [{"value1": "{{$json.id}}", "operation": "isEmpty"}]}}
        ]
      }
    },
    {
      "name": "Create in PB",
      "type": "n8n-nodes-base.httpRequest",
      "position": [1450, 200],
      "parameters": {
        "url": "http://pocketbase:8090/api/collections/leads/records",
        "method": "POST",
        "bodyParameters": {
          "parameters": [
            {"name": "airtable_id", "value": "{{$json.id}}"},
            {"name": "name", "value": "{{$json.fields.Name}}"},
            {"name": "email", "value": "{{$json.fields.Email}}"},
            {"name": "status", "value": "{{$json.fields.Status}}"}
          ]
        }
      }
    },
    {
      "name": "Update in PB",
      "type": "n8n-nodes-base.httpRequest",
      "position": [1450, 400],
      "parameters": {
        "url": "http://pocketbase:8090/api/collections/leads/records/{{$json.id}}",
        "method": "PATCH",
        "bodyParameters": {
          "parameters": [
            {"name": "name", "value": "{{$json.fields.Name}}"},
            {"name": "email", "value": "{{$json.fields.Email}}"},
            {"name": "status", "value": "{{$json.fields.Status}}"}
          ]
        }
      }
    }
  ],
  "connections": {
    "Schedule Trigger": {"main": [[{"node": "Get Last Sync"}]]},
    "Get Last Sync": {"main": [[{"node": "Fetch Airtable"}]]},
    "Fetch Airtable": {"main": [[{"node": "Split Items"}]]},
    "Split Items": {"main": [[{"node": "Check Exists in PB"}]]},
    "Check Exists in PB": {"main": [[{"node": "Switch Create/Update"}]]},
    "Switch Create/Update": {"main": [[{"node": "Create in PB"}], [{"node": "Update in PB"}]]}
  }
}
```

---

## Checklist de Implementación

- [ ] Crear collections en PocketBase (`leads`, `contacts`, `sync_state`, `sync_logs`)
- [ ] Configurar hooks en PocketBase
- [ ] Crear n8n credentials (Airtable API, PocketBase admin)
- [ ] Importar workflow en n8n
- [ ] Probar sincronización inicial
- [ ] Configurar alertas Slack/Email
- [ ] Documentar mapeo de campos final
- [ ] Crear runbook de troubleshooting

---

## Referencias

- `ref-n8n-workflows.md` - Patrones existentes
- [PocketBase Webhooks Docs](https://pocketbase.io/docs/manage-webhooks/)
- [Airtable API Docs](https://airtable.com/developers/web/api/introduction)
- [n8n HTTP Request Node](https://docs.n8n.io/integrations/nodes/n8n-nodes-base.httprequest/)

---

_Creado: 2026-02-21 04:22 UTC - Subagent task_
