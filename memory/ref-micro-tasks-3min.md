# Micro-Tareas de 3 Minutos (Protocolo Actualizado)

ID: REF-MICRO-3MIN-001
Status: active
Tags: #micro-tasks #autonomy #compound-effect #3min
Keys: micro-tasks, autonomy, compound, 3min

---

## Problema Anterior

- Micro-tareas de 30 segundos
- No aprovechaba el ciclo de 5 minutos
- Muy literal con "pequeña acción"

## Solución

**Tareas de 3 minutos por ciclo.**

---

## Reglas

1. **Duración objetivo:** 3 minutos
2. **Ciclo completo:** Aprovechar los 5 minutos
3. **Sin subagentes** (ya implementado)
4. **Sin timeout en horario nocturno** (ya implementado)
5. **NO acciones destructivas sin permiso**

---

## Cómo Descomponer Tareas

| Tarea Grande | Se divide en... |
|--------------|-----------------|
| "Investigar X" | 1) Buscar, 2) Leer, 3) Crear archivo, 4) Indexar |
| "Refactorizar archivo" | 1) Leer, 2) Identificar redundancias, 3) Comprimir, 4) Commit |
| "Analizar sistema" | 1) Revisar estado, 2) Documentar, 3) Crear spec |

---

## Tareas de 3 Minutos (Ejemplos Concretos)

### Mantenimiento
1. Leer 1 archivo grande → identificar redundancias → compresión pendiente
2. Actualizar 2-3 entradas en index.md
3. Crear 1 término en glosario con ejemplo
4. Git commit de cambios pendientes

### Investigación
1. Buscar 1 tema → crear archivo con bullets
2. Leer 1 doc externo → crear resumen
3. Analizar 1 config → documentar hallazgos

### Creación
1. Escribir 1 spec de ~50 líneas
2. Crear 1 runbook simple
3. Diseñar 1 workflow básico

---

## Flujo Correcto

```
:00 - Heartbeat → inicio tarea 3 min
:01 - Trabajando...
:02 - Trabajando...
:03 - Tarea completada → commit
:04 - Esperando siguiente ciclo
:05 - Siguiente ciclo
```

---

## Anti-Patrones

| ❌ Mal | ✅ Bien |
|--------|---------|
| 30 segundos de trabajo | 3 minutos de trabajo |
| "Ya está todo limpio" | Siempre hay algo que mejorar |
| Esperar pasivamente | Buscar activamente qué hacer |
| Tarea vaga | Tarea específica con output |

---

## Fuente de Tareas

1. **TODO.md** — prioridades de Daniel
2. **ref-interests-real-100.md** — 100 cosas que me importan
3. **Archivos pendientes** — index.md, glosario, daily log
4. **Investigación activa** — Google Leak, Claude features, alternativas

---

## Compound Effect (Real)

| Tiempo | Tareas de 3 min | Resultado |
|--------|-----------------|-----------|
| 1 hora | 12 tareas | 12 archivos creados/mejorados |
| 1 día | 48 tareas | Sistema transformado |
| 1 semana | 336 tareas | Arquitectura optimizada |

---

_Actualizado: 2026-02-20 - Después de feedback de Daniel_
