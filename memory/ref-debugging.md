# ref-debugging.md - Referencia de Debugging

ID: REF-DEBUG-001
Status: active
Tags: #debugging #reference #commands #models #channels
Keys: debugging, models, channels, commands, troubleshooting
Last reviewed: 2026-02-19

---

## Model Debugging

### Comandos
```bash
openclaw models status --json
openclaw models status --probe --probe-provider glm5 --json
```

### Interpretación
| Resultado | Significado |
|-----------|-------------|
| ok | Provider alcanzable + key funciona |
| 401/403 | Key incorrecta o sin permisos |
| 404 | baseUrl o modelId incorrecto |
| timeout | Red o provider caído |

---

## Channel Debugging

| Problema | Causa | Fix |
|----------|-------|-----|
| Discord 401 getMe | Token incorrecto | Usar bot token (no app id) |
| Telegram typing, no reply | Error de modelo | Revisar logs del gateway |
| UI 1008 unauthorized | Token mismatch | Actualizar token en UI |

---

## Session Locks

### Síntoma
```
session file locked ... .jsonl.lock
```

### Fix
```bash
# 1. Detener gateway
openclaw gateway stop

# 2. Eliminar locks
rm /root/.openclaw/workspace/*.lock

# 3. Reiniciar
openclaw gateway start
```

### Prevención
En config:
```json5
session.dmScope: "per-channel-peer"
```

---

## Config Discipline

- Config es JSON5 → llaves desconocidas pueden romper startup
- Si `Unrecognized key: "X"` → eliminar X
- Usar `agents.defaults.model.fallbacks` (NO failover)
- Secrets en `~/.openclaw/.env`, nunca en archivos de memoria
- Servicios no heredan env del shell → usar .env

---

_Creado: 2026-02-19 - Extraído de AGENTS.md_
