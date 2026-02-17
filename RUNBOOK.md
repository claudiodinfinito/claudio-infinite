# RUNBOOK - Manual de Operaciones

## Arquitectura

```
┌─────────────────────────────────────────┐
│ VPS Host (RackNerd - Ubuntu 22.04)     │
│                                         │
│  OpenClaw Gateway (systemd)             │
│  - Puerto 18789 (loopback)              │
│  - Config: /root/.openclaw/openclaw.json│
│  - Env: /root/.openclaw/.env            │
│                                         │
│  Claudio (direct runtime)               │
│  - Runtime: direct (sandbox.mode: off)  │
│  - Workspace: /root/.openclaw/workspace │
│  - Memoria: /workspace/memory/          │
│                                         │
└─────────────────────────────────────────┘
```

## Canales

| Canal | Estado | Config |
|-------|--------|--------|
| Telegram | ✅ OK | @claudioinfinito_bot, dmPolicy: pairing |
| Discord | ❌ 401 | Token inválido, pendiente arreglar |

## Modelos

| Modelo | Uso | Provider |
|--------|-----|----------|
| GLM-5-FP8 | Primary | Modal (gratis hasta Abril 2026) |
| Claude Opus 4-5 | Fallback | Anthropic |

### Verificar modelo:
```bash
openclaw models status --json
openclaw models status --probe --probe-provider glm5 --json
```

## Debug Checklist

### 1. Gateway liveness:
```bash
curl -I http://127.0.0.1:18789/
openclaw gateway status
```

### 2. Si gateway caído:
```bash
journalctl --user -u openclaw-gateway.service -n 200 -l --no-pager
tail -n 200 /tmp/openclaw/openclaw-$(date +%Y-%m-%d).log
```

### 3. Modelo:
```bash
openclaw models status --json
openclaw models status --probe --probe-provider glm5 --json
```

### 4. Canales:
- Discord 401 = token incorrecto
- Telegram typing sin reply = error de modelo, revisar logs

## Recovery

### Gateway no arranca:
1. Revisar config: `cat /root/.openclaw/openclaw.json`
2. Buscar "Unrecognized key" en logs
3. Eliminar keys inválidas
4. `openclaw doctor --fix`
5. `openclaw gateway restart`

### Modelo no responde:
1. Verificar API key en .env
2. `openclaw models status --probe`
3. Si 401/403 = key incorrecta
4. Si timeout = red/provider caído

### Sesión bloqueada:
1. `systemctl --user stop openclaw-gateway`
2. `rm /root/.openclaw/agents/main/sessions/*.lock`
3. `systemctl --user start openclaw-gateway`

## Backups

### Antes de actualizar:
```bash
cp ~/.openclaw/openclaw.json ~/.openclaw/openclaw.json.pre-update.$(date +%F)
cp ~/.openclaw/.env ~/.openclaw/.env.pre-update.$(date +%F)
```

### Workspace:
- Memoria en /workspace/memory/
- Persiste en el host

## Seguridad

### Configuración actual:
- ✅ Gateway en loopback
- ✅ dmScope: per-channel-peer
- ✅ dmPolicy: pairing
- ⏳ UFW pendiente
- 🚫 SSH hardening bloqueado hasta Tailscale

### Reglas duras:
1. NO revelar secrets/tokens
2. NO ejecutar destructivo sin confirmar
3. NO aplicar tools.deny (necesito ser sysadmin)
4. NO tocar CapRover

## Updates

### Procedimiento seguro:
1. Backup config y .env
2. `npm i -g openclaw@latest`
3. `openclaw doctor`
4. `openclaw gateway restart`
5. `openclaw models status --probe --probe-provider glm5 --json`

---

_Última actualización: 16 Feb 2026_
