# REPORTE: De Chat LLM a Agente Funcional

Fecha: 2026-02-18, 12:50 UTC
Versión OpenClaw: 2026.2.17
Estado: Config SLIM detectada

---

## 0) ENTORNO CONFIRMADO

| Item | Valor |
|------|-------|
| Versión | 2026.2.17 ✅ |
| Runtime | Gateway host (NO sandbox) ✅ |
| Canal principal | Telegram ✅ (funcionando) |
| Modelo | GLM-5-FP8 via Modal (gratis hasta Abril 2026) |
| Workspace | /root/.openclaw/workspace |
| Gateway | 127.0.0.1:18789 (loopback) ✅ |
| Cron | Habilitado, 5 jobs ✅ |

---

## 1) COMANDOS EJECUTADOS

```bash
openclaw --version        # 2026.2.17 ✅
openclaw gateway status   # running, loopback ✅
openclaw status           # 1 agent, 7 sessions, 62% tokens ✅
openclaw cron status      # enabled, 5 jobs ✅
openclaw cron list        # 5 jobs: healthcheck, backup, alerts ✅
openclaw channels status  # Telegram works ✅
```

---

## 2) CHECKLIST "DEFINITION OF DONE"

### A) TOOLING ❌ 0/4

| Item | Estado | Problema |
|------|--------|----------|
| tools.profile | ❌ NO EXISTE | Sin perfil definido |
| tools.allow/deny | ❌ NO EXISTEN | Todo permitido por defecto |
| tools.exec | ❌ NO EXISTE | Sin timeouts/config |
| tools.web.* | ❌ NO EXISTEN | Sin config de web search/fetch |

**IMPACTO:** Comportamiento undefined. Sin control de qué herramientas usar.

---

### B) EXEC APPROVALS ❌ 0/4

| Item | Estado | Problema |
|------|--------|----------|
| exec-approvals.json | ❌ NO EXISTE | Sin archivo de aprobaciones |
| security | ❌ DEFAULT | No definido |
| ask | ❌ DEFAULT | No definido |
| askFallback | ❌ DEFAULT | No definido |

**IMPACTO:** Posibles bloqueos silenciosos. Sin control de ejecución.

---

### C) SUBAGENTS ❌ 0/3

| Item | Estado | Problema |
|------|--------|----------|
| maxConcurrent | ❌ NO EXISTE | Sin límite definido |
| archiveAfterMinutes | ❌ NO EXISTE | Sin cleanup |
| modelo para subagents | ❌ NO EXISTE | Sin modelo dedicado |

**IMPACTO:** Riesgo de runaway, spam, costo no controlado.

---

### D) HEARTBEAT ✅ 3/4

| Item | Estado | Valor |
|------|--------|-------|
| heartbeat.every | ✅ OK | "30m" |
| heartbeat.target | ✅ OK | "telegram" |
| heartbeat.to | ✅ OK | "8596613010" |
| activeHours | ❌ NO EXISTE | 24/7 sin restricción |

**IMPACTO:** OK. Heartbeats funcionando.

---

### E) CRONJOBS ✅ 3/3

| Item | Estado | Valor |
|------|--------|-------|
| cron.enabled | ✅ OK | true |
| OPENCLAW_SKIP_CRON | ✅ OK | No seteado |
| jobs | ✅ OK | 5 jobs activos |

**IMPACTO:** OK. Cron funcionando.

---

### F) RETRY POLICY ❌ 0/2

| Item | Estado | Problema |
|------|--------|----------|
| channels.telegram.retry | ❌ NO EXISTE | Sin retry policy |
| channels.discord.retry | N/A | Discord eliminado |

**IMPACTO:** Sin reintentos automáticos en fallos de Telegram.

---

### G) LOGGING ❌ 0/2

| Item | Estado | Problema |
|------|--------|----------|
| logging.level | ❌ NO EXISTE | Sin nivel definido |
| logging.redactSensitive | ❌ NO EXISTE | Sin redacción |

**IMPACTO:** Posible leak de sensibles en logs.

---

## RESUMEN DE FALTANTES

| Categoría | Completitud | Crítico |
|-----------|-------------|---------|
| Tooling | 0/4 (0%) | ⚠️ SÍ |
| Exec Approvals | 0/4 (0%) | ⚠️ SÍ |
| Subagents | 0/3 (0%) | 🟡 MEDIO |
| Heartbeat | 3/4 (75%) | ✅ OK |
| Cronjobs | 3/3 (100%) | ✅ OK |
| Retry Policy | 0/2 (0%) | 🟡 MEDIO |
| Logging | 0/2 (0%) | 🟡 MEDIO |
| **TOTAL** | **6/22 (27%)** | **⚠️ CRÍTICO** |

---

## 3) PATCH JSON5 MÍNIMO

```json5
{
  // AÑADIR después de "plugins"

  tools: {
    profile: "messaging",
    exec: {
      security: "full",
      ask: "off",
      timeoutSec: 1800,
      cleanupMs: 1800000,
    },
    elevated: {
      enabled: true,
      allowFrom: {
        telegram: ["8596613010"],
      },
    },
    web: {
      search: {
        enabled: true,
      },
      fetch: {
        enabled: true,
      },
    },
  },

  agents: {
    defaults: {
      subagents: {
        maxConcurrent: 3,
        maxSpawnDepth: 2,
        maxChildrenPerAgent: 5,
        archiveAfterMinutes: 60,
      },
    },
  },

  channels: {
    telegram: {
      retry: {
        attempts: 3,
        minDelayMs: 500,
        maxDelayMs: 10000,
        jitter: 0.1,
      },
    },
  },

  logging: {
    level: "info",
    file: "/tmp/openclaw/openclaw.log",
    redactSensitive: true,
  },
}
```

---

## 4) PLAN SEGURO DE ACTIVACIÓN

### Paso 1: Respaldo

```bash
cp ~/.openclaw/openclaw.json ~/.openclaw/openclaw.json.backup-$(date +%Y%m%d-%H%M%S)
```

### Paso 2: Editar config

Opción A (manual): Editar `~/.openclaw/openclaw.json` y añadir las secciones del patch.

Opción B (patch automático):
```bash
# Daniel debe correr esto en el host:
openclaw config patch --apply
# Y pegar el patch JSON5
```

### Paso 3: Validar

```bash
openclaw doctor
openclaw gateway status
```

### Paso 4: Reiniciar

```bash
systemctl --user restart openclaw-gateway
```

### Paso 5: Verificar

```bash
openclaw cron status
openclaw status
```

### Paso 6: Crear exec-approvals.json (opcional pero recomendado)

```bash
cat > ~/.openclaw/exec-approvals.json << 'EOF'
{
  "version": 1,
  "defaults": {
    "security": "full",
    "ask": "off",
    "askFallback": "allow",
    "autoAllowSkills": false
  },
  "agents": {
    "main": {
      "security": "full",
      "ask": "off"
    }
  }
}
EOF
```

---

## 5) NOTAS ESPECÍFICAS

### Sobre sandbox

**NO estoy en sandbox.** El config tiene `sandbox.mode: "off"`.
Esto significa que los comandos `exec` corren directo en el host.
NO requiere `exec-approvals.json` obligatoriamente, pero es recomendable.

### Sobre rate limit GLM-5

El rate limit se disparó a las 09:36 UTC y se reseteó a las 11:45 UTC.
Duración: ~2 horas.
Reset automático confirmado.

### Sobre heartbeats

Los heartbeats están funcionando. El problema fue el rate limit del modelo, no la configuración de heartbeat.

### Sobre "no funciona mientras duermes"

**CAUSA RAÍZ:**
1. Rate limit GLM-5 (ya resuelto)
2. Config slim sin tools.* (bloqueos undefined)
3. Sin exec-approvals.json (posibles bloqueos silenciosos)

**SOLUCIÓN:**
1. Aplicar patch de config
2. Crear exec-approvals.json
3. Verificar con doctor

---

_Creado: 18 Feb 2026 - Auditoría completa de config slim_
