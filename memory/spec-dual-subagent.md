# Especificación: Doble Subagente en Still

ID: SPEC-DUAL-AGENT-001
Status: active
Tags: #subagentes #paralelo #still #autonomia
Keys: subagentes, paralelo, still, gemini, glm5
Last reviewed: 2026-02-19

---

## Principio

**Cuando Daniel está en still (sin interacción), puedo ejecutar múltiples tareas en paralelo usando subagentes de diferentes modelos.**

---

## Arquitectura

### Modo Interactivo (Daniel presente)
```
MAIN (GLM-5, orquestador)
    ↓
Responde a Daniel directamente
    ↓
Si necesita ayuda → spawn 1 subagente Gemini
    ↓
YO espero (GLM-5 = 1 request concurrente)
```

### Modo Still (Daniel ausente)
```
SISTEMA detecta still (>30 min sin interacción)
    ↓
SPAWN SUBAGENTE GEMINI → Tarea compleja (investigar, analizar)
    ↓
SPAWN SUBAGENTE GLM-5 → Tarea simple (organizar, actualizar)
    ↓
AMBOS corren en paralelo (modelos diferentes = sin choque)
    ↓
Cuando terminan → Integrar resultados
    ↓
Reportar a Daniel cuando regrese
```

---

## Limitaciones Técnicas

| Modelo | Request concurrente | Implicación |
|--------|---------------------|-------------|
| GLM-5 | 1 máximo | Si main usa GLM-5, no puede spawnear GLM-5 subagente |
| Gemini 3 Flash | 20/día | Ilimitado concurrente (mientras no pase daily quota) |

**Solución:**
- Main GLM-5 puede spawnear **Gemini** (diferente modelo = OK)
- Para usar GLM-5 como subagente, main debe "irse" (convertirse en subagente)

---

## Implementación

### Opción A: Main se queda, spawn Gemini
```
MAIN (GLM-5) → espera
SUBAGENTE (Gemini) → ejecuta tarea
```
- **Ventaja:** Main sigue disponible para responder
- **Limitación:** Solo 1 subagente a la vez

### Opción B: Main se convierte en subagente
```
MAIN (GLM-5) → se "despega" y ejecuta tarea como subagente
SISTEMA → libre para spawnear otro subagente (Gemini)
```
- **Ventaja:** 2 tareas en paralelo
- **Limitación:** Main no responde hasta que termine

### Opción C: Spawn ambos con modelos diferentes
```
MAIN (GLM-5) → orquestador (no consume request hasta responder)
SUBAGENTE 1 (Gemini) → Tarea A
SUBAGENTE 2 (GLM-5 vía sessions_spawn) → Tarea B
```
- **Ventaja:** Máximo paralelismo
- **Riesgo:** GLM-5 subagente puede chocar con main

---

## Configuración Recomendada

```json5
subagents: {
  maxConcurrent: 2,  // Permitir 2 subagentes
  models: {
    default: "google/gemini-3-flash-preview",  // Primario para subagentes
    secondary: "glm5/zai-org/GLM-5-FP8"        // Solo cuando main no está activo
  },
  rules: {
    interactive: "solo Gemini",      // Cuando Daniel está presente
    still: "Gemini + GLM-5 permitido" // Cuando Daniel está ausente
  }
}
```

---

## Flujo de Decisión

```
HEARTBEAT detecta still
    ↓
¿Hay 2+ tareas pendientes en TODO.md?
    ↓ SÍ
¿Son independientes (no dependen una de otra)?
    ↓ SÍ
SPAWN SUBAGENTE GEMINI → Tarea compleja
SPAWN SUBAGENTE GLM-5 → Tarea simple
    ↓ (ambos corren en paralelo)
Esperar AMBOS resultados
    ↓
Integrar en memoria
    ↓
Reportar a Daniel cuando regrese
```

---

## Ejemplo de Uso

### Tareas pendientes en TODO.md:
1. Investigar "Mejores prácticas de RAG"
2. Actualizar memory/index.md

### Ejecución en Still:
```
SUBAGENTE GEMINI → Investigar RAG → 20 min → Devuelve ref-rag-best-practices.md
SUBAGENTE GLM-5 → Actualizar index → 5 min → Devuelve index.md actualizado
    ↓
MAIN integra ambos y crea commit
```

---

## Riesgos y Mitigaciones

| Riesgo | Probabilidad | Mitigación |
|--------|--------------|------------|
| GLM-5 choque (429) | Media | Solo spawnear GLM-5 subagente cuando main esté "inactivo" |
| Gemini quota agotada | Baja (20/día) | Trackear uso, priorizar tareas importantes |
| Resultados inconsistentes | Baja | Main integra y valida antes de guardar |

---

## Próximos Pasos

1. [ ] Actualizar config con `maxConcurrent: 2`
2. [ ] Modificar HEARTBEAT.md para detectar still y spawnear ambos
3. [ ] Crear tracking de subagentes activos
4. [ ] Probar con 2 tareas simples

---

_Creado: 2026-02-19 - Sistema de doble subagente_
