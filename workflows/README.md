# n8n Workflows - Revenue Software

**Creado:** 2026-02-21 14:30 UTC
**Propósito:** Workflows listos para importar en n8n

---

## Workflows Disponibles

| Archivo | Propósito | Status |
|---------|-----------|--------|
| `n8n-lead-capture.json` | Capturar leads → PocketBase → Telegram | ✅ Listo |

---

## Cómo Importar en n8n

1. Abrir n8n UI: `http://localhost:5678` (o tu dominio CapRover)
2. Click en **"Add workflow"** → **"Import from file"**
3. Seleccionar el archivo `.json`
4. Configurar credenciales (ver abajo)
5. Activar el workflow

---

## Credenciales Necesarias

### PocketBase Admin Token
1. Ir a PocketBase Admin UI
2. Crear usuario admin si no existe
3. Generar token API
4. En n8n: Settings → Credentials → Add → Header Auth
   - Name: `Authorization`
   - Value: `Bearer TU_TOKEN_AQUI`

### Telegram Bot
1. Usar bot @claudioinfinito_bot
2. En n8n: Settings → Credentials → Add → Telegram API
   - Access Token: `[REDACTED - ver .env]`

---

## Variables de Entorno

Configurar en n8n Settings → Variables:

```
POCKETBASE_URL=http://tu-pocketbase-url:8090
TELEGRAM_CHAT_ID=8596613010
```

---

## Testing

1. Activar workflow
2. Copiar webhook URL del nodo Webhook
3. Enviar POST request:

```bash
curl -X POST https://tu-n8n-url/webhook/lead-capture \
  -H "Content-Type: application/json" \
  -d '{
    "name": "Juan Pérez",
    "email": "juan@test.com",
    "phone": "+521234567890",
    "source": "website"
  }'
```

4. Verificar:
   - Lead creado en PocketBase
   - Mensaje en Telegram

---

## Próximos Workflows

- [ ] `n8n-pipeline-movement.json` - Notificar cambios de etapa
- [ ] `n8n-reactivation.json` - Reactivar clientes inactivos
- [ ] `n8n-airtable-sync.json` - Sync bidireccional

---

_Autonomía 2026-02-21 14:30 UTC_
