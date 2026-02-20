# Environment Variables Reference

ID: REF-ENV-001
Tags: #env #secrets #config #security
Keys: env, secrets, config, environment, variables, credentials
Last reviewed: 2026-02-20

---

## Ubicación de Secrets

| Archivo | Ruta | Permisos |
|---------|------|----------|
| Secrets principales | `/root/.openclaw/.env` | 600 |
| Config OpenClaw | `/root/.openclaw/openclaw.json` | 644 |
| Credentials | `/root/.openclaw/credentials/` | 700 |

---

## Variables Activas

| Variable | Propósito | Provider |
|----------|-----------|----------|
| `OPENCLAW_GATEWAY_TOKEN` | Auth gateway local | OpenClaw |
| `GLM_API_KEY` | Acceso GLM-5 via Modal | Modal Labs |
| `TELEGRAM_BOT_TOKEN` | Bot Telegram | Telegram |
| `ANTHROPIC_API_KEY` | Claude fallback | Anthropic |
| `BRAVE_API_KEY` | Búsqueda web | Brave |
| `GEMINI_API_KEY` | Subagentes | Google |

---

## Verificar Estado

```bash
# Verificar archivo existe y permisos
ls -la /root/.openclaw/.env

# Verificar variables cargadas (sin revelar valores)
grep -E "^[A-Z_]+=" /root/.openclaw/.env | cut -d= -f1

# Verificar gateway token funciona
openclaw gateway status
```

---

## Reglas de Seguridad

| ❌ NUNCA | ✅ SIEMPRE |
|----------|-----------|
| Guardar tokens en memory/ | Usar `[REDACTED]` en logs |
| Commitear .env | .env en .gitignore |
| Mostrar valores en chat | Referenciar "vive en .env" |
| Compartir credentials | Solo Daniel puede acceder |

---

## Si Necesito Referenciar un Secret

**Formato correcto:**
```
El token de Telegram vive en TELEGRAM_BOT_TOKEN en .env
```

**Formato INCORRECTO:**
```
El token es 123456789:ABCdefGHIjklMNOpqrSTUvwxYZ
```

---

## Rotación de Secrets

Si se necesita rotar un secret:

1. **Generar nuevo** en provider (Modal, Telegram, etc.)
2. **Actualizar** en `.env`
3. **Reiniciar** gateway: `systemctl --user restart openclaw-gateway`
4. **Verificar** con `openclaw gateway status`
5. **Revocar** token anterior en provider

---

## Troubleshooting

### Variable no cargada
```bash
# Verificar formato en .env
cat /root/.openclaw/.env | grep VARIABLE_NAME

# Reiniciar gateway para recargar
systemctl --user restart openclaw-gateway
```

### Token inválido
```bash
# Verificar en provider
# Ejemplo: Modal dashboard, Telegram BotFather

# Regenerar y actualizar
```

### Permisos wrong
```bash
chmod 600 /root/.openclaw/.env
chmod 700 /root/.openclaw/credentials/
```

---

## Providers URLs

| Provider | Dashboard |
|----------|-----------|
| Modal | `modal.com` |
| Anthropic | `console.anthropic.com` |
| Brave | `brave.com/search/api` |
| Google AI | `aistudio.google.com` |
| Telegram | `t.me/BotFather` |

---

## Checklist de Seguridad

- [ ] `.env` tiene permisos 600
- [ ] `.env` está en .gitignore
- [ ] No hay tokens en memory/
- [ ] No hay tokens en logs recientes
- [ ] Gateway status OK con secrets actuales

---

_Creado: 2026-02-20 - Micro-tarea 02:25 UTC_
