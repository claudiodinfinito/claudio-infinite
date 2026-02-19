# TODO.md - Backlog Vivo con Estados Fuzzy

**Actualizado:** 2026-02-19, 13:11 UTC
**Heartbeats hoy:** 7/48
**Último trabajo:** 2026-02-19 13:11 UTC - Gateway OK, cron jobs verificados (healthcheck:vps-daily con error no crítico)

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
- **Completado:** 2026-02-18 22:10 UTC
- **Aplicado:** tools.*, logging, subagents, retry, exec-approvals.json, fallbacks

### 2. [100%] ✅ Crear skill forense Google Leak - COMPLETADO
- **Completado:** 2026-02-18 23:05 UTC
- **Ubicación:** skills/forensic-api-leak/SKILL.md

### 3. [90%] Validar TRAINER-DIAG con test real
- **Estado:** Test iniciado (TRAINER-DIAG-gog-oauth), esperando resultado
- **Tiempo:** 15min restantes
- **Próximo:** Verificar resultado del subagente

### 4. [50%] Configurar Git remote para backup
- **Estado:** Commits OK, falta añadir remote URL
- **Tiempo:** 10min
- **Próximo:** Decidir qué repo usar (GitHub nuevo o existente)
- **Necesita:** Daniel proporcione repo URL

### 5. [25%] Completar gog OAuth
- **Estado:** Credenciales guardadas, falta autorización navegador
- **Tiempo:** 15min
- **Próximo:** Revisar resultado del DIAG y aplicar fix

---

## Backlog (priorizado por ROI)

### Estabilidad
- [75%] Git backup automático — Commits OK, falta remote
- [100%] Cron healthcheck OK
- [100%] Cron backup:workspace OK

### Limpieza
- [100%] ~~Documentar lecciones aprendidas hoy en MEMORY.md~~ ✅
- [25%] Sintetizar One Minute Coach más
- [10%] Crear spec-multiagent-departments implementación

### Aprendizaje
- [75%] Alternativas GLM-5 documentadas (ref-glm5-alternatives.md)
- [50%] Atomic Habits aplicado a agentes
- [50%] Subagentes paralelismo entendido

### Refactor seguro
- [0%] Configurar gog completamente
- [0%] Instalar Tailscale para SSH seguro
- [0%] Probar DeepSeek/Mistral como alternativa

---

## Completado Ayer (18 Feb 2026)

- [x] [100%] Actualizar a OpenClaw v2026.2.17
- [x] [100%] Investigar Z.AI tool_stream + issue #15716
- [x] [100%] Leer Atomic Habits PDF completo
- [x] [100%] Leer One Minute Coach PDF completo
- [x] [100%] Documentar Google Leak en 5 archivos
- [x] [100%] Descargar v0.2.0 del leak (2,590 archivos)
- [x] [100%] Crear 6 departamentos multiagente spec
- [x] [100%] Auto-investigación de ref-fallas-skills.md (69% resueltas)
- [x] [100%] Auditoría config slim (6/22 → 22/22)
- [x] [100%] Aplicar patch completo (tools, logging, subagents, retry)
- [x] [100%] Configurar Gemini 3 Flash como fallback
- [x] [100%] Test subagentes Gemini 3 Flash ✅ y Pro ❌
- [x] [100%] Investigar alternativas GLM-5 post-Abril
- [x] [100%] Crear skill forense API leak
- [x] [100%] Crear directorio claude-conversations

## Completado Hoy (19 Feb 2026)

- [x] [100%] Crear diario 2026-02-19.md
- [x] [100%] Actualizar MEMORY.md (fallback chain + lección config)
- [x] [100%] Cron jobs verificados OK (healthcheck, backup, alerts)

---

## Deuda Técnica

| Tipo | Estado |
|------|--------|
| Memoria fragmentada | BAJA |
| Procesos sin runbook | BAJA (2 pendientes menores) |
| Docs sin indexar | BAJA |
| Fuzzy tracking | ACTIVO |

---

## Métricas

| KPI | Valor |
|-----|-------|
| Tareas Next | 5 (2 completadas, 3 pendientes) |
| Tareas Backlog | 10 |
| Completadas ayer | 15 |
| Completadas hoy | 3 |
| Deuda técnica | BAJA |

---

_Añadir tareas según surjan en conversación._
