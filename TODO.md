# TODO.md - Backlog Vivo con Estados Fuzzy

**Actualizado:** 2026-02-18, 23:05 UTC
**Heartbeats hoy:** 6/48
**Último trabajo:** 2026-02-18 23:05 UTC - Skill forense verificado, TRAINER-DIAG test iniciado, claude-conversations creado

---

## Estados Fuzzy

```
[0%]  ━━━━━━━━━━ No iniciado
[10%] ━━━━━━━━━〇 Idea superficial
[25%] ━━━━━━━●━━ Investigué 1 fuente
[50%] ━━━━━●━━━━ Revisé múltiples fuentes
[75%] ━━●━━━━━━━ Sinteticé, documenté
[90%] ●━━━━━━━━━ Listo para aplicar
[100%] ●●●●●●●●●● Aplicado + verificado
```

---

## Next (máx 5, <=90min)

### 1. [100%] ✅ Dejar de ser config slim - COMPLETADO
- **Estado:** Patch aplicado, doctor validó, tools funcionando
- **Completado:** 2026-02-18 22:10 UTC
- **Aplicado:** tools.*, logging, subagents, retry, exec-approvals.json, fallbacks (GLM-5 → Gemini 3 Flash → Claude)
- **Doc:** memory/dec-slim-config-priority.md, ts-audit-config-slim.md

### 2. [100%] Crear skill forense Google Leak
- **Estado:** SKILL.md creado en skills/forensic-api-leak/
- **Tiempo:** Completado
- **Creado:** memory/lib/ (2,590 archivos v0.2.0), skills/forensic-api-leak/SKILL.md

### 3. [75%] Crear subagente TRAINER-DIAG
- **Estado:** Spec creado en spec-subagent-trainer-diag.md
- **Tiempo:** Completado parcialmente
- **Próximo:** Validar con test case real
- **Doc:** memory/spec-subagent-trainer-diag.md

### 4. [10%] Configurar cron jobs para heartbeat
- **Estado:** Idea superficial
- **Tiempo:** 30min
- **Próximo:** `openclaw cron add` para trainer:heartbeat
- **Necesita:** Confirmación antes de crear

### 5. [0%] Pasar conversaciones con Claude
- **Estado:** No iniciado
- **Tiempo:** 20min
- **Próximo:** Daniel pega conversaciones en archivo
- **Archivo:** memory/claude-conversations/

---

## Backlog (priorizado por ROI)

### Estabilidad
- [100%] ~~Crear memory/trainer/INDEX.md~~ ✅ (ya existe y actualizado)
- [100%] ~~Configurar Git backup workspace~~ ✅ (cron backup:workspace OK, corre 06:00 UTC)
- [100%] ~~Verificar healthcheck:vps-daily corre OK~~ ✅ (cron corre 06:00 UTC, status: ok)

### Limpieza
- [100%] ~~Crear rbk-gateway-restart.md~~ ✅
- [100%] ~~Crear ts-telegram-no-reply.md~~ ✅
- [100%] ~~Unificar "Claudio Infinito" en todos los archivos~~ ✅

### Aprendizaje
- [50%] Analizar One Minute Coach completo (leí PDF, falta sintetizar más)
- [75%] Aplicar Atomic Habits a mi sistema (documentado en ref-atomic-habits-*.md)

### Refactor seguro
- [75%] Investigar alternativas a GLM-5 antes de Abril 2026 — ver ref-glm5-alternatives.md
- [0%] Configurar gog con claudiodinfinito@gmail.com
- [0%] Instalar Tailscale para SSH seguro

---

## Completado Hoy (18 Feb 2026)

- [x] [100%] Actualizar a OpenClaw v2026.2.17
- [x] [100%] Investigar Z.AI tool_stream + issue #15716
- [x] [100%] Leer Atomic Habits PDF completo
- [x] [100%] Leer One Minute Coach PDF completo
- [x] [100%] Documentar Google Leak en 3 archivos
- [x] [100%] Crear ref-glm5-issues.md
- [x] [100%] Crear ref-atomic-habits-one-minute-coach-agents.md
- [x] [100%] Crear rbk-gateway-restart.md
- [x] [100%] Crear ts-telegram-no-reply.md
- [x] [100%] Unificar "Claudio Infinito" en archivos
- [x] [100%] Vaciar inbox.md (7 tareas completadas)

---

## Deuda Técnica

| Tipo | Estado |
|------|--------|
| Memoria fragmentada | BAJA |
| Procesos sin runbook | BAJA (runbooks creados) |
| Docs sin indexar | BAJA |
| Fuzzy tracking | NUEVO - implementando |

---

## Métricas

| KPI | Valor |
|-----|-------|
| Tareas Next | 5 |
| Tareas Backlog | 8 |
| Completadas hoy | 11 |
| Deuda técnica | BAJA |

---

_Añadir tareas aquí según surjan en conversación._
