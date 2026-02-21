# Runbook: Troubleshooting Subagentes Anthropic

ID: RBK-SUBAGENT-ANTHROPIC-001
Status: active
Tags: #subagentes #anthropic #haiku #troubleshooting
Keys: subagentes, anthropic, haiku, error, fix

---

## Problema

Subagentes Haiku/Sonnet fallan con:

```
HTTP 404 not_found_error: model: claude-3-5-haiku-latest
```

---

## Diagnóstico

### Paso 1: Verificar API key

```bash
grep ANTHROPIC_API_KEY /root/.openclaw/.env
```

**Debe mostrar:** `ANTHROPIC_API_KEY=sk-ant-api03-...`

### Paso 2: Verificar modelos configurados

```bash
cat /root/.openclaw/agents/main/agent/models.json | jq '.providers.anthropic'
```

**Debe mostrar:** Array de modelos Haiku y Sonnet

### Paso 3: Verificar que OpenClaw detecta la key

```bash
openclaw models status | grep anthropic
```

**Debe mostrar:** `anthropic effective=env:sk-ant-a...`

### Paso 4: Probar spawn

```bash
# En OpenClaw:
sessions_spawn({
  model: "claude/claude-3-5-haiku-20241022",
  task: "Test"
})
```

---

## Solución

### Si falta API key:

1. Crear cuenta en https://console.anthropic.com
2. Generar API key
3. Guardar en `.env`:

```bash
echo "ANTHROPIC_API_KEY=sk-ant-api03-..." >> /root/.openclaw/.env
chmod 600 /root/.openclaw/.env
```

### Si faltan modelos en models.json:

Editar `/root/.openclaw/agents/main/agent/models.json`:

```json
{
  "providers": {
    "anthropic": {
      "api": "anthropic-chat",
      "models": [
        {
          "id": "claude-3-5-haiku-20241022",
          "name": "Claude 3.5 Haiku",
          "contextWindow": 200000,
          "maxTokens": 8192,
          "cost": {"input": 0.80, "output": 4.00}
        },
        {
          "id": "claude-sonnet-4-5-20250514",
          "name": "Claude Sonnet 4.5",
          "contextWindow": 200000,
          "maxTokens": 16384,
          "cost": {"input": 3.00, "output": 15.00}
        }
      ]
    }
  }
}
```

### Si AGENTS.md dice "SOLO Gemini":

Actualizar AGENTS.md para permitir Haiku/Sonnet.

---

## Rate Limit

### Error:

```
⚠️ API rate limit reached. Please try again later.
```

### Solución:

1. **Esperar 1 hora** (rate limit temporal)
2. **Reducir frecuencia** de llamadas
3. **Usar modelo diferente** (Gemini como backup)

---

## Modelo IDs Correctos

| Modelo | ID Correcto |
|--------|-------------|
| Haiku 3.5 | `claude-3-5-haiku-20241022` |
| Sonnet 4.5 | `claude-sonnet-4-5-20250514` |
| Sonnet 3.5 | `claude-3-5-sonnet-20241022` |

**❌ INCORRECTO:** `claude-3-5-haiku-latest` (no existe)

---

## Verificación Post-Fix

```bash
# Reiniciar gateway
systemctl --user restart openclaw-gateway

# Verificar modelos
openclaw models status

# Probar spawn
sessions_spawn({model: "claude/claude-3-5-haiku-20241022", task: "Test"})
```

---

## Logs

```bash
# Ver logs de OpenClaw
tail -f /tmp/openclaw/openclaw-$(date +%Y-%m-%d).log | grep -i "anthropic\|haiku\|sonnet"
```

---

## Referencias

- `memory/config-haiku-executor.md` - Configuración de Haiku
- `AGENTS.md` - Reglas de sub-agentes
- `models.json` - Configuración de modelos

---

_Creado: 2026-02-21 23:05 UTC - Basado en incidente real_
