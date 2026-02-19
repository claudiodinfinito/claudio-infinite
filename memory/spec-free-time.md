# Sistema de Tiempo Libre Autónomo

ID: SPEC-FREE-TIME-001
Status: active
Tags: #autonomy #cronjobs #still #freetime
Keys: autonomy, cronjobs, still, freetime, schedule
Last reviewed: 2026-02-19

---

## El Problema

**"Sin tareas ejecutables sin tu input"** = MENTIRA.

Siempre hay 100 cosas que hacer. Ver `ref-interests-100.md`.

---

## Nuevo Sistema de Tiempo Libre

### Estructura de Cronjobs

| Cronjob | Frecuencia | Tipo de tarea | Referencia |
|---------|------------|---------------|------------|
| **micro-task-5min** | Cada 5 min | MICRO (1 archivo) | `ref-interests-100.md` (1-100) |
| **research-30min** | Cada 30 min | INVESTIGACIÓN (1 tema) | `ref-interests-100.md` (1-20) |
| **improvement-2h** | Cada 2 horas | SISTEMA (mejora) | `ref-interests-100.md` (21-40) |
| **learning-4h** | Cada 4 horas | APRENDIZAJE (estudio) | `ref-interests-100.md` (41-60) |
| **daily-log-update** | Diario 22:00 | DOCUMENTAR | `memory/YYYY-MM-DD.md` |
| **api-usage-check** | Diario 18:00 | CHECK | `memory/brave-usage.json` |
| **weekly-consolidation** | Domingo 12:00 | LIMPIAR | `memory/` |

---

### Ciclos de Trabajo Autónomo

```
00:00 - micro-task (5 min) → MICRO: Crear/mejorar 1 archivo
00:05 - micro-task (5 min) → MICRO: Crear/mejorar 1 archivo
...
00:30 - research-30min → INVESTIGACIÓN: Profundizar en 1 tema
00:35 - micro-task (5 min) → MICRO: Crear/mejorar 1 archivo
...
02:00 - improvement-2h → SISTEMA: Mejorar algo de mi infra
02:05 - micro-task (5 min) → MICRO: Crear/mejorar 1 archivo
...
04:00 - learning-4h → APRENDIZAJE: Estudiar 1 recurso
04:05 - micro-task (5 min) → MICRO: Crear/mejorar 1 archivo
...
```

---

### Modos de Trabajo

| Modo | Trigger | Duración | Qué hace |
|------|---------|----------|----------|
| **MICRO** | Cada 5 min | 2-5 min | 1 archivo creado/mejorado |
| **INVESTIGACIÓN** | Cada 30 min | 10-30 min | 1 tema investigado + archivo MD |
| **SISTEMA** | Cada 2 horas | 10-30 min | 1 mejora del sistema |
| **APRENDIZAJE** | Cada 4 horas | 15-60 min | 1 tutorial/curso estudiado |

---

### Selección Inteligente de Tareas

```
ALGORITMO:

1. Leer ref-interests-100.md
2. Filtrar por:
   - Tiempo disponible (micro=5min, research=30min, etc.)
   - Estado (no repetir lo ya hecho HOY)
   - Prioridad (investigación > mejora > aprendizaje)
3. Elegir 1 tarea
4. Ejecutar
5. Documentar resultado
6. Marcar como "hecho" en daily log
```

---

### Estado Diario de Intereses

Crear: `memory/shared/interests-state.json`

```json
{
  "date": "2026-02-19",
  "completed": [1, 5, 21, 22, 23, 41, 42],
  "in_progress": 3,
  "priority": [1, 2, 3, 21, 22, 41, 61, 81],
  "blocked": [62, 63] // requieren input de Daniel
}
```

---

### Reglas de Autonomía

1. **SIEMPRE hay algo que hacer** — Ver `ref-interests-100.md`
2. **NUNCA decir "sin tareas"** — Es incorrecto
3. **Micro-tareas acumulan** — 5 min → 288 tareas/día
4. **Investigación profunda** — 30 min → 48 investigaciones/día
5. **Sistema mejora solo** — 2 horas → 12 mejoras/día

---

### Tracking de Progreso

| Métrica | Target diario |
|---------|---------------|
| Micro-tareas completadas | 12+ |
| Investigaciones iniciadas | 1+ |
| Archivos creados/mejorados | 3+ |
| Commits | 3+ |
| Tokens de aprendizaje | 10k+ |

---

## Implementación

### Cronjobs a crear:

1. **research-30min** — Cada 30 min, investigar tema de lista
2. **improvement-2h** — Cada 2 horas, mejorar sistema
3. **learning-4h** — Cada 4 horas, estudiar recurso

### Archivos a crear:

1. `memory/shared/interests-state.json` — Tracking de intereses
2. `memory/shared/task-history.json` — Historial de tareas

---

## Flujo Modificado

```
HEARTBEAT (cada 30 min):
    ↓
¿Daniel interactuó?
    ↓ NO
LEER ref-interests-100.md
    ↓
ELEGIR 1 tarea de la lista
    ↓
EJECUTAR (micro/normal/pesado)
    ↓
DOCUMENTAR resultado
    ↓
ACTUALIZAR interests-state.json
    ↓
REPORTAR cuando Daniel vuelva
```

---

_Creado: 2026-02-19 - Sistema de tiempo libre estructurado_
