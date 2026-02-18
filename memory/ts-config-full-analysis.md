# Análisis Completo: Config Faltante vs Repo Oficial

ID: TS-CONFIG-FULL-001
Status: active
Tags: #config #missing #wizard #troubleshooting #openclaw
Keys: config, missing, wizard, troubleshooting, openclaw, full-analysis
Last reviewed: 2026-02-18

---

## Mi Config Actual

```json
{
  "meta": { "lastTouchedVersion": "2026.2.15" },
  "wizard": { "lastRunAt": "2026-02-17T23:06:01.996Z", "lastRunCommand": "doctor" },
  "models": {
    "mode": "merge",
    "providers": {
      "glm5": {
        "baseUrl": "https://api.us-west-2.modal.direct/v1",
        "apiKey": "${GLM_API_KEY}",
        "api": "openai-completions",
        "models": [{ "id": "zai-org/GLM-5-FP8", "name": "GLM-5-FP8" }]
      }
    }
  },
  "agents": {
    "defaults": {
      "model": {
        "primary": "glm5/zai-org/GLM-5-FP8",
        "fallbacks": ["anthropic/claude-opus-4-5"]
      },
      "workspace": "/root/.openclaw/workspace",
      "memorySearch": { "enabled": true, "provider": "gemini" },
      "thinkingDefault": "off",
      "heartbeat": { "every": "30m", "includeReasoning": false, "target": "telegram", "to": "8596613010" },
      "sandbox": { "mode": "off" }
    }
  },
  "commands": { "native": "auto", "nativeSkills": "auto" },
  "session": { "dmScope": "per-channel-peer" },
  "channels": {
    "telegram": {
      "enabled": true,
      "dmPolicy": "pairing",
      "botToken": "${TELEGRAM_BOT_TOKEN}",
      "groupPolicy": "disabled",
      "streamMode": "partial"
    }
  },
  "gateway": {
    "port": 18789,
    "mode": "local",
    "bind": "loopback",
    "auth": { "mode": "token", "token": "${OPENCLAW_GATEWAY_TOKEN}" }
  },
  "plugins": { "entries": { "telegram": { "enabled": true } } }
}
```

---

## Secciones FALTANTES Completas

### 1. `tools` (CRÍTICO)

**Lo que DEBERÍA tener:**

```json5
{
  tools: {
    // Perfil de seguridad
    profile: "messaging",  // minimal | messaging | full

    // Tools denegadas explícitamente
    deny: [],  // ["gateway", "cron", "sessions_spawn"]

    // Configuración de ejecución
    exec: {
      security: "full",  // deny | allowlist | full
      ask: "off",        // always | on-miss | off
      askFallback: "deny",
      autoAllowSkills: false
    },

    // Filesystem
    fs: {
      workspaceOnly: true,
      allow: ["~/projects/**"],
      deny: ["~/.ssh/**", "~/.gnupg/**"]
    },

    // Browser
    browser: {
      security: "deny",
      ask: "always"
    },

    // Web
    web: {
      search: {
        apiProvider: "brave",
        apiKey: "${BRAVE_API_KEY}"
      },
      fetch: {
        allowList: ["*"],
        denyList: []
      }
    },

    // Elevated mode
    elevated: {
      enabled: false,
      allowFrom: []
    }
  }
}
```

**Mi config:**
- ❌ NO tiene `tools`
- ❌ Sin control de exec
- ❌ Sin profile de seguridad
- ❌ Sin allowlists/denylists

---

### 2. `exec-approvals.json` (CRÍTICO)

**Archivo separado que NO existe:**

```json
// ~/.openclaw/exec-approvals.json
{
  "version": 1,
  "socket": {
    "path": "~/.openclaw/exec-approvals.sock",
    "token": "base64url-token"
  },
  "defaults": {
    "security": "allowlist",
    "ask": "on-miss",
    "askFallback": "deny",
    "autoAllowSkills": false
  },
  "agents": {
    "main": {
      "security": "full",
      "ask": "off",
      "allowlist": [
        {
          "id": "uuid",
          "pattern": "/usr/bin/*",
          "lastUsedAt": 1737150000000
        }
      ]
    }
  }
}
```

**Mi config:**
- ❌ Archivo NO existe
- ❌ Sin control de aprobaciones

---

### 3. `agents.defaults.subagents`

**Lo que DEBERÍA tener:**

```json5
{
  agents: {
    defaults: {
      subagents: {
        maxSpawnDepth: 1,          // 1 = no nesting, 2 = sub->sub
        maxChildrenPerAgent: 5,    // max hijos por sesión
        maxConcurrent: 8,          // max globales
        defaultCleanup: "delete",  // delete | keep
        defaultRunTimeoutSeconds: 600,
        defaultModel: null         // hereda del main
      }
    }
  }
}
```

**Mi config:**
- ❌ NO tiene subagents config
- ⚠️ Usando defaults implícitos

---

### 4. `agents.defaults.retry`

**Lo que DEBERÍA tener:**

```json5
{
  agents: {
    defaults: {
      retry: {
        enabled: true,
        maxAttempts: 3,
        backoffMs: 1000,
        retryOn: ["rate_limit", "timeout", "server_error"]
      }
    }
  }
}
```

**Mi config:**
- ❌ NO tiene retry policy
- ⚠️ Sin reintentos automáticos

---

### 5. `logging`

**Lo que DEBERÍA tener:**

```json5
{
  logging: {
    level: "info",  // debug | info | warn | error
    redactSensitive: true,
    maxFileSizeMb: 10,
    maxFiles: 5,
    console: {
      enabled: true,
      level: "info"
    }
  }
}
```

**Mi config:**
- ❌ NO tiene logging config
- ⚠️ Sin redacción de sensibles

---

### 6. `session` completo

**Lo que DEBERÍA tener:**

```json5
{
  session: {
    dmScope: "per-channel-peer",
    reset: {
      mode: "daily",      // off | daily | weekly
      atHour: 4,          // hora UTC
      idleMinutes: 120    // idle antes de reset
    },
    prune: {
      enabled: true,
      maxAgeDays: 30,
      maxSessions: 100
    },
    lock: {
      enabled: true,
      timeoutMs: 30000
    }
  }
}
```

**Mi config:**
- ✅ Tiene dmScope
- ❌ NO tiene reset
- ❌ NO tiene prune
- ❌ NO tiene lock

---

### 7. `cron` config

**Lo que DEBERÍA tener:**

```json5
{
  cron: {
    enabled: true,
    maxConcurrentRuns: 2,
    sessionRetention: "24h",
    stagger: {
      enabled: true,
      maxDelayMs: 60000
    }
  }
}
```

**Mi config:**
- ❌ NO tiene cron config
- ⚠️ Cron jobs existen pero sin config general

---

### 8. `hooks` (webhooks)

**Lo que DEBERÍA tener:**

```json5
{
  hooks: {
    enabled: false,  // activar si se necesita
    token: "shared-secret",
    path: "/hooks",
    defaultSessionKey: "hook:ingress",
    allowRequestSessionKey: false,
    allowedSessionKeyPrefixes: ["hook:"],
    mappings: []
  }
}
```

**Mi config:**
- ❌ NO tiene hooks config

---

### 9. `gateway.reload`

**Lo que DEBERÍA tener:**

```json5
{
  gateway: {
    // ... existing ...
    reload: {
      mode: "hybrid",  // hybrid | hot | restart | off
      debounceMs: 300
    },
    trustedProxies: ["127.0.0.1"],
    remote: {
      enabled: false,
      auth: { mode: "token" }
    }
  }
}
```

**Mi config:**
- ❌ NO tiene reload config
- ❌ NO tiene trustedProxies (warning en audit)
- ❌ NO tiene remote config

---

### 10. `env` (inline)

**Lo que DEBERÍA tener:**

```json5
{
  env: {
    // Variables inline (opcional)
    // BRAVE_API_KEY: "...",
    // ELEVENLABS_API_KEY: "...",

    shellEnv: {
      enabled: false,
      timeoutMs: 15000
    }
  }
}
```

**Mi config:**
- ❌ NO tiene env block
- ⚠️ Depende solo de ~/.openclaw/.env

---

### 11. `messages` (media)

**Lo que DEBERÍA tener:**

```json5
{
  messages: {
    maxChars: 100000,
    chunking: {
      enabled: true,
      maxChars: 4000,
      overlapChars: 200
    }
  }
}
```

**Mi config:**
- ❌ NO tiene messages config

---

### 12. `agents.defaults.groupChat`

**Lo que DEBERÍA tener:**

```json5
{
  agents: {
    defaults: {
      groupChat: {
        mentionPatterns: ["@claudio", "claudio"],
        requireMention: true,
        activation: "mention"  // mention | always
      }
    }
  }
}
```

**Mi config:**
- ❌ NO tiene groupChat config

---

### 13. `agents.defaults.models` (alias)

**Lo que DEBERÍA tener:**

```json5
{
  agents: {
    defaults: {
      models: {
        "glm5/zai-org/GLM-5-FP8": { alias: "GLM-5" },
        "anthropic/claude-opus-4-5": { alias: "Claude" }
      }
    }
  }
}
```

**Mi config:**
- ❌ NO tiene aliases
- ⚠️ Sin nombres cortos para modelos

---

## Resumen: Lo que FALTA

| Sección | Severidad | Estado |
|---------|-----------|--------|
| `tools` | 🔴 CRÍTICO | Falta completa |
| `exec-approvals.json` | 🔴 CRÍTICO | Archivo no existe |
| `agents.defaults.subagents` | 🟡 MEDIO | Default implícito |
| `agents.defaults.retry` | 🟡 MEDIO | Sin reintentos |
| `logging` | 🟢 BAJO | Default implícito |
| `session.reset/prune/lock` | 🟡 MEDIO | Parcial |
| `cron` config | 🟢 BAJO | Jobs existen sin config |
| `hooks` | 🟢 BAJO | No usado |
| `gateway.reload/trustedProxies` | 🟡 MEDIO | Warning en audit |
| `env` inline | 🟢 BAJO | Usa .env |
| `messages` | 🟢 BAJO | Default OK |
| `groupChat` | 🟡 MEDIO | Parcial |
| `models aliases` | 🟢 BAJO | Sin nombres cortos |

---

## Config Completa Recomendada

```json5
{
  meta: { lastTouchedVersion: "2026.2.17" },

  models: {
    mode: "merge",
    providers: {
      glm5: {
        baseUrl: "https://api.us-west-2.modal.direct/v1",
        apiKey: "${GLM_API_KEY}",
        api: "openai-completions",
        models: [{ id: "zai-org/GLM-5-FP8", name: "GLM-5-FP8" }]
      }
    }
  },

  agents: {
    defaults: {
      model: {
        primary: "glm5/zai-org/GLM-5-FP8",
        fallbacks: ["anthropic/claude-opus-4-5"]
      },
      models: {
        "glm5/zai-org/GLM-5-FP8": { alias: "GLM-5" },
        "anthropic/claude-opus-4-5": { alias: "Claude" }
      },
      workspace: "/root/.openclaw/workspace",
      memorySearch: { enabled: true, provider: "gemini" },
      thinkingDefault: "off",
      heartbeat: {
        every: "30m",
        includeReasoning: false,
        target: "telegram",
        to: "8596613010"
      },
      sandbox: { mode: "off" },
      subagents: {
        maxSpawnDepth: 1,
        maxChildrenPerAgent: 5,
        maxConcurrent: 8,
        defaultCleanup: "delete"
      },
      retry: {
        enabled: true,
        maxAttempts: 3,
        backoffMs: 1000
      },
      groupChat: {
        mentionPatterns: ["@claudio", "claudio"],
        requireMention: true
      }
    }
  },

  commands: { native: "auto", nativeSkills: "auto" },

  session: {
    dmScope: "per-channel-peer",
    reset: { mode: "daily", atHour: 4, idleMinutes: 120 },
    prune: { enabled: true, maxAgeDays: 30 }
  },

  channels: {
    telegram: {
      enabled: true,
      dmPolicy: "pairing",
      botToken: "${TELEGRAM_BOT_TOKEN}",
      groupPolicy: "disabled",
      streamMode: "partial"
    }
  },

  tools: {
    profile: "full",
    deny: [],
    exec: {
      security: "full",
      ask: "off",
      askFallback: "allow"
    },
    fs: { workspaceOnly: true },
    web: {
      search: { apiProvider: "brave" }
    },
    elevated: { enabled: false }
  },

  gateway: {
    port: 18789,
    mode: "local",
    bind: "loopback",
    auth: { mode: "token", token: "${OPENCLAW_GATEWAY_TOKEN}" },
    reload: { mode: "hybrid", debounceMs: 300 },
    trustedProxies: ["127.0.0.1"]
  },

  cron: {
    enabled: true,
    maxConcurrentRuns: 2,
    sessionRetention: "24h"
  },

  logging: {
    level: "info",
    redactSensitive: true
  },

  plugins: { entries: { telegram: { enabled: true } } }
}
```

---

## Archivos Adicionales a Crear

### 1. `~/.openclaw/exec-approvals.json`

```json
{
  "version": 1,
  "defaults": {
    "security": "full",
    "ask": "off",
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

---

## Próximos Pasos

1. **Aplicar config completa** → Reemplazar openclaw.json
2. **Crear exec-approvals.json** → Control de ejecución
3. **Reiniciar gateway** → Aplicar cambios
4. **Verificar con audit** → `openclaw security audit`

---

_Creado: 18 Feb 2026 - Análisis completo vs repo oficial_
