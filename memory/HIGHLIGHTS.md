# HIGHLIGHTS - Lo que Importa

---

## 2026-02-20 (Día 6)

### 3 Bullets de lo más importante:

1. **Sesión de 20 horas, 75 commits** — Sistema de micro-tareas autónomas funcionando: cada 5 min, 1 mejora pequeña = compound effect masivo.

2. **Plan B para GLM-5 documentado** — DeepSeek V3.2 ($0.27/M) como reemplazo post-Abril 2026, Ollama local como backup gratuito.

3. **16 items de interests cubiertos** — De #17 a #100: Claude features, modelos AI, business frameworks, tools, sistemas.

### 1 Anti-pattern (qué NO volver a hacer):

**Ejecutar `rm` o `cron remove` sin confirmación explícita** — Una recomendación de subagente NO es permiso. Siempre preguntar a Daniel antes de borrar.

### 1 Comantidad clave:

```bash
# Micro-tareas = compound effect
# 75 commits en 20h = 1 cada 16 min
# Sin interacción de Daniel = STILL productivo
```

---

## 2026-02-17 (Día 3)

### 3 Bullets de lo más importante:

1. **Tengo mi email** - claudiodinfinito@gmail.com creado por Daniel para todo lo relacionado conmigo
2. **Archivos del trainer recuperados** - TRAINER-FULL.md (18KB), SECURITY.md completo (8KB), HIGHLIGHTS.md
3. **Patrón del búho consolidado** - 🦉 primero SIEMPRE en 3 archivos: SOUL.md, AGENTS.md STARTUP, claudio-infinite SKILL.md

### 1 Anti-pattern (qué NO volver a hacer):

**Quedar archivos en sandbox** - El sandbox se limpia. TODO archivo importante debe estar en `/root/.openclaw/workspace/` que es PERSISTENTE. También: **NO crear archivos con typos** como "claussio" en lugar de "claudio".

### 1 Comando clave:

```bash
# Verificar que escribo en el lugar correcto
ls -la /root/.openclaw/workspace/*.md
```

---

## 2026-02-16 (Día 2)

### 3 Bullets de lo más importante:

1. **Peter Steinberger (creador de Molty) → OpenAI** - OpenClaw se convierte en foundation project respaldado por OpenAI, 150,000+ estrellas en 60 días

2. **Mi runtime estaba MAL** - Sesión main corría en docker/non-main cuando debería ser native. Bug documentado.

3. **Aprendí a guardar memoria correctamente** - Los archivos son INSTRUCCIONES para mí, NO checklists. Debo leer SECURITY.md, TRAINER-FULL.md, RUNBOOK.md cada sesión

### 1 Anti-pattern (qué NO volver a hacer):

**NO spawnear sub-agentes para investigación** - Mueren. El agente que spawneé para investigar murió durante web_fetch. Investigar yo mismo, paso a paso.

### 1 Comando clave:

```bash
openclaw models status --probe --probe-provider glm5 --json
```

---

## 2026-02-15 (Día 1 - Nacimiento)

### 3 Bullets de lo más importante:

1. **Nací** - 15 de Febrero, 2026. Creé SOUL.md, MEMORY.md, identidad como Claudio Infinito, búho digital

2. **Configuración básica funcionando** - GLM-5 como primary, Claude Opus 4-5 como fallback, Telegram funcionando, gateway en loopback

3. **3 cron jobs activos** - healthcheck diario, backup diario, security semanal

### 1 Anti-pattern (qué NO volver a hacer):

**NO usar models.providers.anthropic** - Anthropic es built-in, declararlo en models.providers rompe la validación

### 1 Comando clave:

```bash
openclaw doctor --fix
```

---

_Actualizar cada día o cuando pase algo importante_
