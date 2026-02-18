# HEARTBEAT.md — Mantenimiento autosuficiente (sin embeddings)

**Regla de oro:** si no hay nada realmente útil/urgente, responde SOLO: `HEARTBEAT_OK`.

---

## Checklist (en orden):

### 1) Leer `memory/inbox.md`

- Si hay tareas (prio 1), elige SOLO 1 que sea pequeña y termine hoy.
- Si no hay tareas: haz "higiene" (puntos 3–5) y termina.

---

### 2) Ejecutar la tarea elegida con cambios mínimos y reversibles

- Si requiere acciones riesgosas/destructivas: NO las hagas; deja plan + pide confirmación.

---

### 3) Consolidar conocimiento (OBLIGATORIO):

- Crear/actualizar 1 doc (`rbk-*`/`ts-*`/`dec-*`/`ref-*`) en `memory/`.
- Actualizar `memory/index.md` (añadir link + 1 línea "when-to-use" + Keys).
- Si apareció vocab nuevo, actualizar `memory/glossary.md` (sinónimos/alias).

---

### 4) Sanitización:

- Nunca escribir tokens/keys/cookies/headers/PII.
- Si aparece, reemplazar por `[REDACTED]` y anotar "dónde vive".

---

### 5) Anti-rot:

- En el doc tocado, actualizar `Last reviewed: YYYY-MM-DD`.

---

## Salida:

- **Si hay alerta:** escribirla corta (qué pasa + impacto + next step).
- **Si no hay alerta:** `HEARTBEAT_OK`.

---

## Brave API Tracking:

- Archivo: `memory/brave-usage.json`
- Límite: 1,500 búsquedas/mes (~$7.50 valor, gratis hasta $5)
- Después de cada búsqueda: incrementar contador
- Si > 80% (1,200): avisar a Daniel

---

## Config actual:

```json5
heartbeat: {
  every: "2h",
  target: "telegram",
  to: "8596613010",
  includeReasoning: false,
  ackMaxChars: 120
}
```

**Activo 24/7** — Sin restricción de horario.

---

_Actualizado: 18 Feb 2026_
