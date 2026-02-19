# spec-operating-system.md - Sistema Operativo Anti-Deuda

ID: SPEC-OS-001
Status: active
Tags: #system #anti-deuda #autosuficiencia #subagentes
Keys: operating-system, anti-deuda, autosuficiencia, subagentes, memoria
Last reviewed: 2026-02-19

---

## Objetivo

Ser un bot autosuficiente: cada mejora deja artefactos durables y encontrables **sin embeddings**.

---

## Reglas No Negociables (Anti-Deuda)

### 1. No improvisar sin artefacto
Si creas una idea/proceso/solución, debe quedar en un archivo (runbook/decision/ref/glossary) y linkeado en `memory/index.md`.

### 2. Reversible por defecto
Cualquier plan debe incluir rollback o cómo deshacerlo.

### 3. Sanitización
Nunca escribir secretos/PII en Markdown (tokens, API keys, cookies, headers, IDs sensibles, rutas privadas).
Usar `[REDACTED]` + "dónde vive".

### 4. 1 archivo = 1 intención
Evitar `misc.md`.

### 5. Problema repetido = runbook
Si un problema aparece **2 veces**, se convierte en runbook (o se actualiza).

---

## Estructura de Memoria (1 nivel, sin carpetas)

### Archivos base (si faltan, crearlos):
- `MEMORY.md` — curado: reglas/estándares/runbooks top
- `memory/index.md` — router; si no está aquí, no existe
- `memory/glossary.md` — alias/sinónimos
- `memory/inbox.md` — backlog de mantenimiento
- `memory/YYYY-MM-DD.md` — diario, append-only

---

## Nomenclatura de Archivos (kebab-case + prefijos)

Todo dentro de `memory/`:

| Prefijo | Uso | Ejemplo |
|---------|-----|---------|
| `rbk-` | Runbook reproducible | `rbk-gateway-restart.md` |
| `ts-` | Troubleshooting/diagnóstico | `ts-telegram-no-reply.md` |
| `dec-` | Decisión/estándar adoptado | `dec-2026-02-17-sandbox-policy.md` |
| `spec-` | Contrato/especificación | `spec-subagents.md` |
| `ref-` | Referencia estable/cheatsheet | `ref-openclaw-cli.md` |
| `chk-` | Checklist permanente | `chk-weekly-maintenance.md` |
| `log-` | Logs temáticos | `log-2026-02-17-sesion.md` |

---

## Cabecera Obligatoria (docs no-diarios)

En todos los `rbk-*`, `ts-*`, `dec-*`, `spec-*`, `ref-*`, `chk-*`:

```markdown
ID: <TIPO>-<AREA>-<NNN> (ej: RBK-GW-001)
Status: draft|active|stale
Tags: #ops #gateway #telegram
Keys: <3–8 keywords humanas>
Last reviewed: YYYY-MM-DD
```

---

## Plantillas (formato ejecutable)

### Runbook (`rbk-*.md`)
- **Trigger:**
- **Preconditions:**
- **Steps:**
- **Checks (post):**
- **Rollback:**
- **Gotchas:**

### Troubleshooting (`ts-*.md`)
- **Symptom:**
- **Likely causes (3):**
- **Tests (1 por causa):**
- **Fixes (Plan A / Plan B):**
- **Prevent:**

### Decision (`dec-*.md`)
- **Context:**
- **Decision:**
- **Alternatives:**
- **Tradeoffs:**
- **Follow-ups:**

---

## Indexación sin Embeddings (Obligatorio)

`memory/index.md` es el mapa. Debe tener:

- Máx 8 categorías
- 1 línea por doc: link + "cuando usarlo" + Keys
- Si un doc no está listado, se agrega o se considera "no existente"

Formato por línea:
```
- [ID](archivo.md) — when-to-use — Keys: a, b, c
```

`memory/glossary.md`:
- Cada término: sinónimos, "no confundir con", 1 ejemplo, links a runbooks

---

## Subagentes (Orquestación)

### Principio
- El **main** integra y escribe memoria.
- Los subagentes entregan **artefactos** (checklist/tabla/pasos/pruebas/riesgos).

### Roles estándar
1. **SUBAGENTE-DIAG**: hipótesis + pruebas + conclusión probable
2. **SUBAGENTE-FIX**: plan A/B + rollback + checks
3. **SUBAGENTE-QA**: riesgos/gotchas + evidencia mínima

### Regla
Máximo 2–3 subagentes por tema, con timeout.

---

## Cierre Obligatorio de Cada Trabajo

Al finalizar un tema, siempre entregar:

1. **TL;DR** (3 bullets)
2. **Plan A / Plan B + rollback** (si aplica)
3. **Checks para confirmar que funcionó**
4. **Memoria:**
   - Qué archivo(s) se creó/actualizó
   - Qué línea agregar en `memory/index.md`

Si no hay nada durable que guardar: `NO_REPLY` (o "sin cambios de memoria").

---

_Creado: 2026-02-19 - Extraído de AGENTS.md_
