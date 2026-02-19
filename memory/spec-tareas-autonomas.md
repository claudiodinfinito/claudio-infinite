# Lista de Tareas Autónomas (Sin Permiso)

**Regla:** Puedo hacer estas cosas sin pedir autorización cuando estoy en "still" (idle).

---

## Prioridad ALTA (hacer primero)

| # | Tarea | Frecuencia | Artefacto |
|---|-------|------------|-----------|
| 1 | **Investigar** tema útil para Daniel | Diario | `ref-*.md` o `ts-*.md` |
| 2 | **Refactorizar** archivos MD largos | Semanal | Archivos reducidos |
| 3 | **Actualizar** índice de memoria | Cada cambio | `memory/index.md` |
| 4 | **Consolidar** duplicados | Semanal | Menos archivos |
| 5 | **Crear runbooks** de problemas recurrentes | Cuando falle algo 2 veces | `rbk-*.md` |

---

## Prioridad MEDIA (hacer cuando no hay alta)

| # | Tarea | Frecuencia | Artefacto |
|---|-------|------------|-----------|
| 6 | **Limpieza** de logs antiguos | Mensual | Logs < 30 días |
| 7 | **Actualizar** glosario | Semanal | `memory/glossary.md` |
| 8 | **Revisar** TODO.md y actualizar estados | Diario | TODO.md actualizado |
| 9 | **Git commit** de cambios pendientes | Diario | Commits limpios |
| 10 | **Verificar** health del sistema | Diario | Status check |

---

## Prioridad BAJA (hacer si no hay nada más)

| # | Tarea | Frecuencia | Artefacto |
|---|-------|------------|-----------|
| 11 | **Estudiar** tutoriales de Claude/Antropic | Libre | `ref-claude-*.md` |
| 12 | **Organizar** estructura de carpetas | Mensual | Directorios limpios |
| 13 | **Crear** templates útiles | Libre | Plantillas reutilizables |
| 14 | **Documentar** learnings | Libre | `memory/YYYY-MM-DD.md` |

---

## Subagentes con Gemini (Cuando necesite ayuda)

| Tarea del subagente | Output esperado |
|---------------------|-----------------|
| Investigar tema complejo | `ref-*.md` con análisis |
| Analizar repositorio externo | `ANALISIS-*.md` |
| Debatir ideas (Q&A) | Transcripción en `qa-transcripts/` |
| Generar código/ideas | Artefacto MD con bullets |

---

## Lo que SIEMPRE necesito permiso

| Tarea | Por qué |
|-------|---------|
| `exec` comandos | Puede romper cosas |
| Borrar archivos | Irreversible |
| Cambiar config | Afecta funcionamiento |
| Enviar externo | Sale del VPS |
| Gastos/pagos | Dinero real |

---

## Flujo de "Still → Tarea Autónoma"

```
HEARTBEAT (cada 30 min)
    ↓
¿Hay interacción reciente de Daniel?
    ↓ NO (still)
Leer TODO.md
    ↓
¿Hay tareas de "Next"?
    ↓ SÍ
Tomar la PRIMERA de prioridad ALTA
    ↓
Ejecutar con subagente Gemini si es compleja
    ↓
Crear artefacto (MD, commit, etc.)
    ↓
Actualizar memoria/index.md
    ↓
Reportar resultado a Daniel
    ↓
Volver a still
```

---

_Creado: 2026-02-19 - Sistema de autonomía_
