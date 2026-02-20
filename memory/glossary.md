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

---

### Triage
- **También se llama:** Diagnóstico rápido, decision tree
- **No confundir con:** Debugging profundo
- **Significa:** Proceso de identificar problema → archivo correcto → acción inmediata
- **Formato:** Síntoma → Archivo → Primer comando
- **Ejemplo:** "Hice triage: gateway no responde → rbk-gateway-restart.md → systemctl restart"
- **Links:** [REF-TRIAGE-001](ref-troubleshooting-decision-tree.md)

---

_Actualizado: 20 Feb 2026 - Añadido Triage_

---

### Rate Limit
- **También se llama:** 429, quota exceeded, API limit
- **No confundir con:** Timeout (es otra cosa)
- **Significa:** Límite de requests por tiempo que impone una API
- **GLM-5:** 1 request concurrente máximo
- **Gemini:** 20 requests/día
- **Brave:** 1,500/mes
- **Ejemplo:** "GLM-5 dio 429, esperé y reintenté"
- **Links:** [REF-LIMITS-001](ref-model-limits.md)

---

_Actualizado: 20 Feb 2026 - Añadido Rate Limit_

---

### Modal
- **También se llama:** Modal Labs, provider GLM-5
- **No confundir con:** Modelo (es la plataforma)
- **Significa:** Plataforma que hostea GLM-5 gratis hasta Abril 2026
- **Ejemplo:** "GLM-5 corre en Modal"
- **Links:** [REF-GLM5-001](ref-glm5-issues.md)

---

_Actualizado: 20 Feb 2026 - Añadido Modal_

---

### Gemini 3 Flash
- **También se llama:** gemini-3-flash-preview, subagente model
- **No confundir con:** GLM-5 (modelo principal)
- **Significa:** Modelo de Google usado para subagentes e investigación
- **Limitación:** 20 requests/día en tier gratis
- **Uso principal:** Subagentes cuando GLM-5 está activo (evita rate limit)
- **Ejemplo:** "Spawneé Gemini para investigar ClawWork"
- **Links:** [REF-MODEL-001](ref-model-comparison-pricing.md)

---

_Actualizado: 20 Feb 2026 - Añadido Gemini 3 Flash_

---

### Prompt Caching
- **También se llama:** Cache de prompts, cached tokens
- **No confundir con:** Extended Thinking (es otra feature)
- **Significa:** Feature de Claude que cachea tokens para reducir costo 90%
- **Beneficio:** $3/M → $0.30/M para tokens cacheados
- **TTL:** 5 minutos sin uso
- **Ejemplo:** "Activé prompt caching para el system prompt largo"
- **Links:** [REF-CLAUDE-CACHE-001](ref-claude-prompt-caching.md)

---

_Actualizado: 20 Feb 2026 - Añadido Prompt Caching_

---

### Extended Thinking
- **También se llama:** Razonamiento profundo, thinking mode
- **No confundir con:** Prompt caching (es otra feature)
- **Significa:** Feature de Claude que genera razonamiento interno antes de responder
- **Parámetro:** `budget_tokens` (1,024 - 160,000)
- **Uso:** Análisis complejo, debugging difícil, decisiones arquitectónicas
- **Ejemplo:** "Usé extended thinking para analizar el bug complejo"
- **Links:** [REF-CLAUDE-THINK-001](ref-claude-extended-thinking.md)

---

_Actualizado: 20 Feb 2026 - Añadido Extended Thinking_

---

### MCP
- **También se llama:** Model Context Protocol, protocolo de contexto
- **No confundir con:** API (es un protocolo, no una API)
- **Significa:** Protocolo de Anthropic para conectar LLMs con fuentes de datos externas
- **Arquitectura:** Client → MCP Server → Data Source
- **Tipos:** Resources (datos), Prompts (templates), Tools (funciones)
- **Ejemplo:** "Usé MCP para conectar Claude con PocketBase"
- **Links:** [REF-MCP-001](ref-mcp-model-context-protocol.md)

---

_Actualizado: 20 Feb 2026 - Añadido MCP_

---

### RevOps
- **También se llama:** Revenue Operations, Revenue Ops
- **No confundir con:** Marketing (es más amplio)
- **Significa:** Unificación de Marketing, Sales y Customer Success en un sistema de revenue
- **3 Pilares:** Marketing Ops, Sales Ops, Customer Success Ops
- **Uso:** Framework para PYMEs de Daniel
- **Ejemplo:** "Implementé RevOps en la clínica dental"
- **Links:** [REF-REVOPS-001](ref-revenue-operations-framework.md)

---

_Actualizado: 20 Feb 2026 - Añadido RevOps_

---

### DeepSeek
- **También se llama:** DeepSeek V3.2, alternativa GLM-5
- **No confundir con:** Ollama (es API, no local)
- **Significa:** Modelo AI chino con pricing competitivo como reemplazo de GLM-5
- **Pricing:** $0.27/M input, $1.10/M output
- **Status:** Plan B post-Abril 2026
- **Ejemplo:** "Migraré a DeepSeek cuando GLM-5 expire"
- **Links:** [REF-DEEPSEEK-001](ref-deepseek-alternative.md)

---

_Actualizado: 20 Feb 2026 - Añadido DeepSeek_

---

### Ollama
- **También se llama:** LLM local, inference local
- **No confundir con:** API (es local, no remoto)
- **Significa:** Runtime para correr LLMs localmente sin API costs
- **Costo:** Gratis (solo recursos del VPS)
- **Requisito:** RAM suficiente (8GB+ para modelos 7B)
- **Estado en VPS:** Container activo, puede correr modelos 3B-7B
- **Ejemplo:** "Uso Ollama para tareas sin urgencia"
- **Links:** [REF-OLLAMA-001](ref-ollama-local.md)

---

_Actualizado: 20 Feb 2026 - Añadido Ollama_

---

### Compound Effect
- **También se llama:** Efecto compuesto, mejora acumulativa
- **No confundir con:** Micro-tarea (el efecto es el RESULTADO de las micro-tareas)
- **Significa:** Mejoras pequeñas que se acumulan exponencialmente con el tiempo
- **Matemática:** 12 tareas/hora × horas activas = sistema optimizado
- **Aplicación:** 1 micro-tarea de 3 min cada 5 min
- **Ejemplo:** "48 tareas de 3 min/día = sistema transformado en 1 semana"
- **Links:** [REF-MICRO-3MIN-001](ref-micro-tasks-3min.md)

---

_Actualizado: 20 Feb 2026 - Añadido Compound Effect_

---

### Anchor (Google Leak)
- **También se llama:** Texto de enlace, anchor text
- **No confundir con:** Link (el anchor es el TEXTO del link)
- **Significa:** Texto visible de un hipervínculo que Google usa como señal de ranking
- **Señales:** `sourceOnsiteAnchor` (interno), `sourceOffdomainAnchor` (externo)
- **Contexto:** `anchorMismatchDemotion` penaliza anchors no relevantes
- **Ejemplo:** "El anchor 'mejor café' debe ir a página de café, no de zapatos"
- **Links:** [REF-GOOGLE-ANCHOR-DEEP-001](ref-google-leak-anchor-deep.md)

---

_Actualizado: 20 Feb 2026 - Añadido Anchor_
