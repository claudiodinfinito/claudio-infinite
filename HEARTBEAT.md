# HEARTBEAT.md — Trainer Unificado (cada 30 min)

**Misión:** Investigar/mejorar + mantener TODO.md vivo + proponer cambios seguros.

---

## Cada heartbeat (en orden):

### 1) Leer TODO.md

- Si no existe → crear con plantilla
- Revisar estado de tareas
- Actualizar fuzzy states si hubo progreso

### 2) Elegir 1 tarea de "Next" (si hay)

- Solo tareas <=90min
- Si no hay, proponer 1-3 nuevas basadas en ROI

### 3) Ejecutar la tarea con cambios mínimos y reversibles

- Si requiere acciones riesgosas → NO hacer, dejar plan + pedir confirmación
- Si requiere config/código → diff + rollback + pedir confirmación

### 4) Consolidar conocimiento (OBLIGATORIO si hubo trabajo):

- Crear/actualizar 1 doc en `memory/` (rbk-*/ts-*/dec-*/ref-*)
- Actualizar `memory/index.md`
- Si vocab nuevo → `memory/glossary.md`

### 5) Actualizar sistema de consulta:

- Append 1 línea a `memory/trainer/INDEX.md`:
  ```
  YYYY-MM-DD HH:MM | TAREA | ESTADO | HALLAZGO
  ```
- Si hallazgo real → crear nota en `memory/trainer/YYYY-MM-DD__tema.md`:
  - Contexto
  - Evidencia
  - Diagnóstico
  - Propuesta
  - Riesgos/Rollback
  - Next action

### 6) Anti-patrones (vigilar):

- [ ] ¿Hice lo mismo 2 veces sin runbook? → CREAR RUNBOOK
- [ ] ¿Creé archivo sin linkear en index? → LINKEAR O BORRAR
- [ ] ¿Pasé >30min sin output tangible? → DOCUMENTAR BLOQUEO
- [ ] ¿Investigué sin escribir nada? → ESCRIBIR ANTES DE CONTINUAR

---

## Salida al chat:

- **Si NO hubo cambios útiles** → `HEARTBEAT_OK`
- **Si SÍ hubo cambios** → resumen (5-10 bullets) + "próximo paso recomendado"

---

## Reglas duras:

1. **NO acciones destructivas sin confirmación**
2. **NO cambiar config/código sin diff + rollback + aprobación**
3. **NO crear archivos sin linkear en index.md**
4. **NO investigar sin documentar**

---

## ROI de tareas (priorizar):

1. **Estabilidad** → cron, heartbeat, delivery, memory
2. **Limpieza** → docs internas, índice, de-duplicar
3. **Aprendizaje** → 1 concepto nuevo aplicable hoy
4. **Refactor seguro** → sin tocar prod sin aprobación

---

## Brave API Tracking:

- Archivo: `memory/brave-usage.json`
- Límite: 1,500/mes
- Si >80% (1,200) → avisar a Daniel

---

## Config:

```json5
heartbeat: {
  every: "30m",
  target: "telegram",
  to: "8596613010",
  includeReasoning: false,
  ackMaxChars: 120
}
```

**Activo 24/7** — Gateway debe estar siempre corriendo.

---

_Actualizado: 18 Feb 2026 - Trainer unificado_
