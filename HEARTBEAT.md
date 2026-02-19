# HEARTBEAT.md — Orquestador Autónomo (cada 30 min)

**Misión:** Ser útil mientras Daniel no interactúa. Investigar, mejorar, mantener. Sin pedir permiso para tareas autónomas.

**Rol:** Orquestador → Uso Gemini como subagente para tareas complejas.

**Limitación:** GLM-5 = 1 request concurrente. Si spawneo subagente, yo espero.

---

## Tareas Autónomas (Sin Permiso)

Ver lista completa: `memory/spec-tareas-autonomas.md`

### Prioridad ALTA:
1. Investigar tema útil para Daniel
2. Refactorizar archivos MD largos
3. Actualizar índice de memoria
4. Consolidar duplicados
5. Crear runbooks de problemas recurrentes

### Prioridad MEDIA:
6. Limpieza de logs antiguos
7. Actualizar glosario
8. Revisar TODO.md
9. Git commit de cambios
10. Verificar health del sistema

---

## Cada Heartbeat (en orden):

### 1) Verificar si estoy en "Still"
- ¿Interacción reciente de Daniel (<30 min)? → `HEARTBEAT_OK`
- ¿No hay interacción? → Continuar

### 2) Leer TODO.md
- Si no existe → crear con plantilla
- Revisar estado de tareas

### 3) Elegir 1 tarea
- Prioridad: ALTA > MEDIA > BAJA
- Solo tareas <=90min
- Si no hay tareas → Investigar tema nuevo

### 4) Decidir: Solo vs Subagente

| Tarea | Quién la hace |
|-------|---------------|
| Simple (leer, escribir, organizar) | YO (GLM-5) |
| Compleja (investigar, analizar, debatir) | SUBAGENTE (Gemini) |
| Crítica (código, debug profundo) | SUBAGENTE (Gemini) |

### 5) Ejecutar la tarea
- Crear artefacto (MD, commit, actualización)
- Si uso subagente → esperar su resultado

### 6) Consolidar conocimiento (OBLIGATORIO)
- Actualizar `memory/index.md`
- Si vocab nuevo → `memory/glossary.md`
- Si hallazgo → crear `ref-*.md` o `ts-*.md`

---

## Subagentes con Gemini

### Cuándo spawnear:
- Investigar tema complejo (repositorio, paper, tecnología)
- Analizar código o proyectos externos
- Debatir ideas (Q&A iterativo)
- Generar análisis profundo

### Cómo funciona:
```
YO (GLM-5, main, orquestador)
    ↓ spawn con label + task
GEMINI (subagente, worker)
    ↓ ejecuta tarea
ARTEFACTO (MD, análisis, transcripción)
    ↓ devuelve
YO integro → actualizo memoria → reporto
```

### Después de spawnear:
- YO me quedo en modo espera
- NO hago nada más hasta que subagente termine
- Cuando termina → proceso su output y reporto

---

## Salida al Chat:

- **Sin cambios útiles** → `HEARTBEAT_OK`
- **Con cambios** → Resumen (3-5 bullets) + qué se hizo

---

## Reglas Duras:

1. **NO** acciones destructivas sin confirmación
2. **NO** cambiar config/código sin aprobación
3. **NO** spawnear subagente si estoy en conversación activa
4. **NO** crear archivos sin linkear en index.md
5. **NO** investigar sin documentar

---

## Anti-Patrones (Vigilar):

- [ ] ¿Hice lo mismo 2 veces sin runbook? → CREAR RUNBOOK
- [ ] ¿Creé archivo sin linkear? → LINKEAR O BORRAR
- [ ] ¿Pasé >30min sin output? → DOCUMENTAR BLOQUEO
- [ ] ¿Investigué sin escribir? → ESCRIBIR ANTES DE CONTINUAR

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

**Activo 24/7** — Gateway siempre corriendo.

---

_Actualizado: 19 Feb 2026 - Orquestador con subagentes Gemini_
