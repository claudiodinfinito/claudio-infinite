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

_Actualizado: 19 Feb 2026 - Añadido Still_
