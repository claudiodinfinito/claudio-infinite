# Análisis: Instalación Custom vs Automática

ID: TS-CONFIG-001
Status: active
Tags: #config #install #custom #missing #troubleshooting
Keys: config, install, custom, missing, wizard, slim
Last reviewed: 2026-02-18

---

## Problema Identificado

**Daniel pasó ~20 horas configurándome manualmente** pegando errores de consola.
Posiblemente se creó una versión "slim" sin todas las configuraciones.

---

## Lo que FALTA en mi Config

### 1. Sección `tools` COMPLETA

**Mi config actual NO tiene:**
```json
{
  "tools": {
    "profile": "...",
    "deny": [...],
    "exec": {
      "security": "deny|allowlist|full",
      "ask": "always|on-miss|off"
    }
  }
}
```

**Significado:**
- Sin `tools.exec` config → comportamiento default
- Sin `tools.deny` → todas las tools disponibles
- Sin `tools.profile` → sin perfil de seguridad

### 2. Archivo `exec-approvals.json`

**No existe:**
```
/root/.openclaw/exec-approvals.json
```

**Debería tener:**
```json
{
  "version": 1,
  "defaults": {
    "security": "allowlist",
    "ask": "on-miss",
    "askFallback": "deny",
    "autoAllowSkills": false
  },
  "agents": {
    "main": {
      "security": "allowlist",
      "ask": "on-miss",
      "allowlist": []
    }
  }
}
```

### 3. Configuración de Subagentes

**Mi config NO tiene:**
```json
{
  "agents": {
    "defaults": {
      "subagents": {
        "maxSpawnDepth": 1,
        "maxChildrenPerAgent": 5,
        "maxConcurrent": 8
      }
    }
  }
}
```

### 4. Retry Policy

**Mi config NO tiene:**
```json
{
  "agents": {
    "defaults": {
      "retry": {
        "maxAttempts": 3,
        "backoffMs": 1000
      }
    }
  }
}
```

### 5. Logging Config

**Mi config NO tiene:**
```json
{
  "logging": {
    "redactSensitive": true,
    "level": "info"
  }
}
```

### 6. Session Config Completa

**Mi config solo tiene:**
```json
{
  "session": {
    "dmScope": "per-channel-peer"
  }
}
```

**Debería tener también:**
```json
{
  "session": {
    "dmScope": "per-channel-peer",
    "maxAgeMs": 86400000,
    "prune": {
      "enabled": true,
      "maxAgeDays": 30
    }
  }
}
```

---

## Security Audit Actual

```
Summary: 0 critical · 1 warn · 1 info

WARN: gateway.trusted_proxies_missing
INFO: tools.elevated: enabled
```

**Hallazgos:**
- `tools.elevated: enabled` → Esto es un riesgo si no está controlado
- No hay `exec-approvals.json` → Sin control de ejecución

---

## Lo que SÍ tengo (comparado con wizard)

| Configuración | Wizard | Mi config | Estado |
|---------------|--------|-----------|--------|
| models.providers | ✅ | ✅ glm5 | OK |
| agents.defaults.model | ✅ | ✅ | OK |
| agents.defaults.workspace | ✅ | ✅ | OK |
| agents.defaults.heartbeat | ✅ | ✅ 30m | OK |
| agents.defaults.sandbox | ✅ | ✅ off | OK |
| channels.telegram | ✅ | ✅ | OK |
| gateway | ✅ | ✅ | OK |
| tools.profile | ✅ | ❌ | FALTA |
| tools.exec | ✅ | ❌ | FALTA |
| tools.deny | ✅ | ❌ | FALTA |
| exec-approvals.json | ✅ | ❌ | FALTA |
| subagents config | ✅ | ❌ | FALTA |
| retry policy | ✅ | ❌ | FALTA |
| logging | ✅ | ❌ | FALTA |

---

## El Problema del "Ask"

**Hipótesis de Daniel:**
> "Cambiamos una configuración que decía 'dont ask for permissions' a 'always ask' y por eso no lo haces"

**Lo que encontré:**
- NO tengo `tools.exec.ask` en mi config
- NO tengo `exec-approvals.json`
- Security audit dice `tools.elevated: enabled`

**Comportamiento default cuando NO hay config:**
- `security: "full"` → todo permitido
- `ask: "always"` → pregunta siempre
- Pero como no hay UI en VPS → bloquea automáticamente

**Esto explicaría por qué:**
1. Los heartbeats se ejecutan
2. Pero no puedo ejecutar tareas complejas
3. El modelo responde pero el sistema bloquea acciones

---

## Solución Propuesta

### Plan A: Config Mínima Segura

Añadir a `openclaw.json`:
```json
{
  "tools": {
    "profile": "messaging",
    "exec": {
      "security": "full",
      "ask": "off"
    },
    "deny": []
  }
}
```

**Riesgo:** Permite todo sin preguntar
**Ventaja:** No hay bloqueos

### Plan B: Exec Approvals con Allowlist

Crear `exec-approvals.json`:
```json
{
  "version": 1,
  "defaults": {
    "security": "allowlist",
    "ask": "on-miss",
    "askFallback": "allow"
  },
  "agents": {
    "main": {
      "security": "full",
      "ask": "off"
    }
  }
}
```

**Riesgo:** Medio
**Ventaja:** Control granular

### Plan C: Correr Wizard Completo

```bash
openclaw onboard --install-daemon
```

**Riesgo:** Puede sobrescribir configuración existente
**Ventaja:** Configuración completa y probada

---

## Próximos Pasos

1. **Decidir Plan** (A, B, o C)
2. **Aplicar config**
3. **Reiniciar gateway**
4. **Verificar con security audit**

---

## Archivos Clave

| Archivo | Existe | Debería existir |
|---------|--------|-----------------|
| `/root/.openclaw/openclaw.json` | ✅ | ✅ |
| `/root/.openclaw/exec-approvals.json` | ❌ | ✅ |
| `/root/.openclaw/agents/main/auth-profiles.json` | ❓ | ✅ |
| `/root/.openclaw/credentials/telegram-allowFrom.json` | ❓ | ✅ |

---

_Creado: 18 Feb 2026 - Análisis de configuración faltante_
