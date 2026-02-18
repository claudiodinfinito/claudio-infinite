# ts-telegram-no-reply.md

```
ID: TS-TEL-001
Status: active
Tags: #telegram #troubleshooting #channel #debug
Keys: telegram, no-reply, typing, error, channel, bot
Last reviewed: 2026-02-18
```

---

## Troubleshooting: Telegram no responde

### Symptom

- Bot muestra "typing..." pero nunca envía mensaje
- Mensajes enviados a @claudioinfinito_bot no reciben respuesta
- Respuestas tardan > 30 segundos o nunca llegan

---

### Likely causes (3)

1. **Error de modelo** — GLM-5 no responde o timeout
2. **Error de canal** — Token de bot inválido/expirado
3. **Error de gateway** — Gateway caído o no escuchando

---

### Tests (1 por causa)

#### Test 1: Modelo (GLM-5)

```bash
openclaw models status --probe --probe-provider glm5 --json
```

- `"status": "ok"` → modelo funciona
- `"status": "error"` o timeout → problema de modelo
- Error 401/403 → API key incorrecta
- Error 404 → modelo no encontrado

#### Test 2: Canal (Telegram)

```bash
openclaw channels status --probe --probe-channel telegram
```

- `"status": "ok"` → canal funciona
- Error 401 → token de bot incorrecto
- Error 409 → webhook conflict (usar modo polling)

#### Test 3: Gateway

```bash
openclaw gateway status
curl -I http://127.0.0.1:18789/
```

- `"Runtime: running"` + HTTP 200 → gateway OK
- `"stopped"` o error → ver [RBK-GW-001](rbk-gateway-restart.md)

---

### Fixes (Plan A / Plan B)

#### Plan A: Reiniciar gateway (más común)

```bash
systemctl --user restart openclaw-gateway
openclaw gateway status
```

Ver [RBK-GW-001](rbk-gateway-restart.md) para pasos completos con rollback.

#### Plan B: Verificar logs

```bash
tail -n 100 /tmp/openclaw/openclaw-$(date +%Y-%m-%d).log
```

Buscar:
- `error` o `ERROR`
- `timeout`
- `ECONNREFUSED`
- `401` o `403`

Si el error es de modelo (timeout GLM-5), esperar o usar fallback Claude.
Si el error es de token Telegram, regenerar en @BotFather.

---

### Prevent

1. **Monitorear modelo** con heartbeat cada 2h
2. **Tener fallback configurado** (`agents.defaults.model.fallbacks`)
3. **Logs limpios** — rotar logs antiguos mensualmente
4. **Token en .env** — nunca hardcodeado en config

---

### Quick flowchart

```
No responde
    │
    ├─► Gateway caído? ──Sí──► RBK-GW-001 (restart)
    │
    ├─► Modelo error? ──Sí──► Verificar API key / usar fallback
    │
    └─► Canal error? ──Sí──► Verificar token en .env
```

---

## Related

- [RBK-GW-001](rbk-gateway-restart.md) — Reiniciar gateway
- [RBK-SES-001](rbk-session-locked.md) — Sesión bloqueada
- [MEMORY.md](../MEMORY.md) — Config actual

---

_Creado: 2026-02-18_
