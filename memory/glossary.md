# glossary.md — Desambiguador

**Regla:** Si cambias nomenclatura, actualiza aquí.

---

## Términos

### Claudio
- **También se llama:** Claudio Infinito, búho, bot
- **No confundir con:** Claude (el modelo de Anthropic)
- **Significa:** Agente OpenClaw que ayuda a Daniel
- **Ejemplo:** "Claudio está investigando búhos"
- **Links:** [IDENTITY.md](../IDENTITY.md)

---

### Daniel
- **También se llama:** Humano, usuario
- **No confundir con:** Otros usuarios
- **Significa:** Usuario principal, creador de Claudio
- **Ejemplo:** "Daniel quiere que investigue GLM-5"
- **Links:** [USER.md](../USER.md)

---

### Gateway
- **También se llama:** OpenClaw Gateway, puerto 18789
- **No confundir con:** Gateway de CapRover
- **Significa:** API local de OpenClaw
- **Ejemplo:** "El gateway está en loopback"
- **Links:** [RBK-SES-001](rbk-session-locked.md)

---

### Workspace
- **También se llama:** /root/.openclaw/workspace, mi casa
- **No confundir con:** Sandbox (eliminado)
- **Significa:** Directorio persistente donde vivo
- **Ejemplo:** "Guardé el archivo en workspace"
- **Links:** [AGENTS.md](../AGENTS.md)

---

### Sandbox
- **También se llama:** Container temporal
- **No confundir con:** Workspace
- **Significa:** (ELIMINADO) Container temporal donde corría OpenClaw
- **Ejemplo:** "El sandbox fue eliminado el 17 Feb 2026"
- **Links:** [MIGRACION-SANDBOX-2026-02-17.md](../MIGRACION-SANDBOX-2026-02-17.md)

---

### CapRover
- **También se llama:** Captain, srv-captain--*
- **No confundir con:** OpenClaw
- **Significa:** Plataforma de Daniel para apps (OFF-LIMITS para mí)
- **Ejemplo:** "n8n corre en CapRover"
- **Links:** [VPS-MAP.md](../VPS-MAP.md)

---

### Runbook
- **También se llama:** rbk-*.md, procedimiento
- **No confundir con:** Troubleshooting
- **Significa:** Pasos reproducibles para algo que se repite
- **Ejemplo:** "Usé el runbook de sesión bloqueada"
- **Links:** [RBK-SES-001](rbk-session-locked.md)

---

### GLM-5
- **También se llama:** Modelo primary, GLM-5-FP8
- **No confundir con:** Claude (fallback)
- **Significa:** Modelo principal que uso (gratis hasta Abril 2026)
- **Ejemplo:** "GLM-5 está respondiendo bien"
- **Links:** [RUNBOOK.md](../RUNBOOK.md)

---

### Memory.md
- **También se llama:** Memoria largo plazo, MEMORY
- **No confundir con:** Diarios (2026-02-*.md)
- **Significa:** Memoria curada que persiste entre sesiones
- **Ejemplo:** "Actualicé MEMORY.md con mi email"
- **Links:** [MEMORY.md](../MEMORY.md)

---

### Brave API
- **También se llama:** web_search, búsqueda web
- **No confundir con:** Google Search
- **Significa:** API de búsqueda web para búsquedas en tiempo real
- **Ejemplo:** "Usé Brave para buscar documentación"
- **Links:** [HEARTBEAT.md](../HEARTBEAT.md), `memory/brave-usage.json`

---

### Subagente
- **También se llama:** sessions_spawn, sub-agent, worker
- **No confundir con:** Main session (yo), Q&A chat
- **Significa:** Agente temporal para tareas específicas con output estructurado
- **Uso correcto:** UN spawn → contrato claro → output estructurado → integrar
- **Anti-pattern:** Spawn múltiples para Q&A iterativo → pierde rastreo → usuario sin updates
- **Ejemplo:** "Lancé TRAINER-DIAG para diagnosticar gog OAuth, entregó 3 hipótesis"
- **Links:** [SPEC-TRAINER-DIAG-001](spec-subagent-trainer-diag.md)

---

### Still
- **También se llama:** Idle, inactivo, sin interacción
- **No confundir con:** Offline (gateway apagado)
- **Significa:** Estado donde no hay interacción reciente de Daniel (30+ min)
- **Comportamiento:** Detectar still → leer TODO.md → ejecutar tarea autónoma → reportar
- **Ejemplo:** "Detecté still, refactoricé AGENTS.md y reporté cuando volvió"
- **Links:** [SPEC-AUTONOMY-001](spec-tareas-autonomas.md)

---

### One-liner
- **También se llama:** Prompt corto, micro-prompt
- **No confundir con:** Prompt largo, instrucciones detalladas
- **Significa:** Prompt de 1 línea con estructura: [ROL] + [TAREA] + [FORMATO]
- **Ejemplo:** "Lee memory/index.md y lista las 5 tareas más urgentes"
- **Links:** [REF-ONELINERS-001](ref-one-liners-glm5.md)

---

### Heartbeat
- **También se llama:** Check periódico, still-check
- **No confundir con:** Cronjob (es un tipo de cronjob)
- **Significa:** Check automático cada 30 min para detectar inactividad y disparar tareas autónomas
- **Comportamiento:** Si no hay interacción → STILL → ejecutar tarea de TODO.md
- **Ejemplo:** "El heartbeat detectó still y refactoricé AGENTS.md"
- **Links:** [HEARTBEAT.md](../HEARTBEAT.md), [SPEC-AUTONOMY-001](spec-tareas-autonomas.md)

---

_Actualizado: 19 Feb 2026 - Añadido Heartbeat_

---

### Cronjob
- **También se llama:** Job, automatización programada
- **No confundir con:** Heartbeat (es un tipo de cronjob)
- **Significa:** Tarea programada que se ejecuta automáticamente
- **Tipos:** reminders (mensajes), healthchecks (verificaciones), alerts (alertas)
- **Ejemplo:** "El cronjob de backup corre cada día a las 06:00"
- **Links:** [REF-CRONJOBS-001](ref-cronjobs-active.md)

---

_Actualizado: 19 Feb 2026 - Añadido Cronjob_

---

### Departamento
- **También se llama:** Dept, área especializada
- **No confundir con:** Subagente (un dept puede spawnear subagentes)
- **Significa:** Área especializada del sistema multiagente con focus específico
- **Los 6:** MARKETING, FRONTEND, BACKEND, SEO, COPY, EMPRENDIMIENTO
- **Ejemplo:** "El departamento de SEO analizó el Google Leak"
- **Links:** [REF-DEPT-001](ref-departments.md)

---

_Actualizado: 19 Feb 2026 - Añadido Departamento_

---

### Brief
- **También se llama:** Contexto compartido, bus de contexto
- **No confundir con:** Memory (memoria completa)
- **Significa:** Archivo compartido de contexto que todos los departamentos leen
- **Ubicación:** `memory/shared/brief.md`
- **Ejemplo:** "El brief versión 1.3 tiene el contexto actualizado"
- **Links:** [REF-DEPT-001](ref-departments.md)

---

_Actualizado: 19 Feb 2026 - Añadido Brief_

---

### Micro-tarea
- **También se llama:** Tarea atómica, one-minute task
- **No confundir con:** Tarea grande (que se divide en micro-tareas)
- **Significa:** Tarea de 1-2 minutos que mejora el sistema incrementalmente
- **Frecuencia:** Cada 5 minutos (cronjob `micro-task-5min`)
- **Efecto:** Compound = 37x mejora en 1 año
- **Ejemplo:** "Añadí una entrada al glosario como micro-tarea"
- **Links:** [REF-ONELINERS-001](ref-one-liners-glm5.md), [SPEC-AUTONOMY-001](spec-tareas-autonomas.md)

---

_Actualizado: 19 Feb 2026 - Añadido Micro-tarea_
