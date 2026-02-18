# Subagentes y Paralelismo - Investigación

ID: REF-SUBAGENTS-001
Status: active
Tags: #subagents #parallel #performance #optimization
Keys: subagents, parallel, spawn, performance, maxConcurrent
Last reviewed: 2026-02-18

---

## Descubrimiento Principal

**PUEDO TRABAJAR EN PARALELO.**

No estoy limitado a procesamiento secuencial. Puedo spawnear hasta **8 subagentes simultáneos** que trabajan en paralelo.

---

## Arquitectura de Subagentes

### Niveles de Profundidad

| Depth | Session Key | Rol | ¿Puede spawnear? |
|-------|-------------|-----|------------------|
| 0 | `agent:<id>:main` | Main agent (yo) | Siempre |
| 1 | `agent:<id>:subagent:<uuid>` | Sub-agent | Si `maxSpawnDepth >= 2` |
| 2 | `agent:<id>:subagent:<uuid>:subagent:<uuid>` | Sub-sub-agent (worker) | Nunca |

### Límites por Defecto

| Parámetro | Default | Qué significa |
|-----------|---------|---------------|
| `maxSpawnDepth` | 1 | No puedo anidar subagentes |
| `maxChildrenPerAgent` | 5 | Máx 5 hijos por sesión |
| `maxConcurrent` | 8 | Máx 8 subagentes globales |

---

## Patrones de Paralelización

### 1. Research Fan-Out

```
YO → spawneo 5 subagentes
     ├── Subagent-1: Investiga competidor A
     ├── Subagent-2: Investiga competidor B
     ├── Subagent-3: Investiga competidor C
     ├── Subagent-4: Investiga competidor D
     └── Subagent-5: Investiga competidor E

Resultado: 5 investigaciones en el tiempo de 1
```

### 2. Content Generation Batch

```
YO → spawneo 3 subagentes
     ├── Subagent-1: Escribe blog post
     ├── Subagent-2: Escribe tweets
     └── Subagent-3: Escribe email copy

Resultado: 3 entregables simultáneos
```

### 3. Data Processing Pipeline

```
YO → spawneo 4 subagentes
     ├── Subagent-1: Procesa batch 1
     ├── Subagent-2: Procesa batch 2
     ├── Subagent-3: Procesa batch 3
     └── Subagent-4: Procesa batch 4

Resultado: Pipeline paralelo
```

### 4. Orquestador (requiere maxSpawnDepth: 2)

```
YO → spawneo ORQUESTADOR
     └── ORQUESTADOR → spawnea 5 WORKERS
                       ├── Worker-1
                       ├── Worker-2
                       ├── Worker-3
                       ├── Worker-4
                       └── Worker-5

Resultado: Fan-out de 2 niveles
```

---

## Cómo Usar Subagentes

### Tool: `sessions_spawn`

```json
{
  "task": "Investigar Google Leak v0.2.0 y extraer todos los modelos de AbuseIAm",
  "label": "DIAG-GOOGLE-LEAK",
  "model": "glm5/zai-org/GLM-5-FP8",
  "runTimeoutSeconds": 600
}
```

### Comando: `/subagents spawn`

```
/subagents spawn glm5 "Investigar X" --model glm5 --thinking high
```

---

## Mis Limitaciones Actuales

### 1. NO tengo `maxSpawnDepth: 2`

**Default:** 1
**Significa:** Puedo spawnear subagentes, pero mis subagentes NO pueden spawnear más.

**Para activar orquestador:**
```json
{
  "agents": {
    "defaults": {
      "subagents": {
        "maxSpawnDepth": 2,
        "maxChildrenPerAgent": 5,
        "maxConcurrent": 8
      }
    }
  }
}
```

### 2. NO he probado spawnear múltiples

**Estado:** Nunca he usado `sessions_spawn` para trabajo real.

**Necesito:** Auto-entrenamiento con subagentes reales.

### 3. Contexto aislado

**Cada subagent:**
- Su propio contexto
- No ve mi conversación main
- Debo pasarle TODO lo que necesita

---

## Guidelines de Subagentes (Anti-Deuda)

### Regla 1: NO crear deuda técnica

Cada subagent debe:
- Tener propósito CLARO y ÚNICO
- Output DEFINIDO antes de spawnear
- Scope LIMITADO (una tarea, no un proyecto)

### Regla 2: Temperatura baja

| Tipo de subagent | Temperature | Por qué |
|------------------|-------------|---------|
| DIAG (diagnóstico) | 0.3 | Preciso, no creativo |
| FIX (reparación) | 0.4 | Determinista |
| RESEARCH | 0.5 | Algo de exploración |
| DOC | 0.3 | Exacto, no alucinar |

**Evitar:** Temperature alta en subagentes = hallucination

### Regla 3: Memoria separada

Cada subagent tiene:
- Su propio contexto (no ve main)
- NO hereda MEMORY.md
- Se le pasa EXACTAMENTE lo que necesita

**Esto significa:**
- Debo ser explícito en el task
- No puedo asumir que "sabe" lo que yo sé
- El prompt del subagent es crítico

### Regla 4: Guidelines dedicadas

Cada tipo de subagent tiene:
- Su propio "rol" definido
- Límites claros (qué NO hacer)
- Output format especificado

**Template de subagent:**

```
ROL: [DIAG|FIX|QA|RESEARCH|DOC]
TASK: [descripción específica]
SCOPE: [qué SÍ y qué NO]
OUTPUT: [formato esperado]
TEMPERATURE: [0.3-0.5]
TIMEOUT: [segundos]
```

### Regla 5: No one-offs

Si un subagent hace algo útil:
- Documentar el patrón
- Crear template reusable
- Añadir a "subagent library"

**Esto previene:**
- Reinventar el wheel
- Código/ad-hoc que se pierde
- Deuda de configuración

---

## El Sueño de "20x Más Rápido"

**Lo que Daniel soñó:**
Trabajar en paralelo con requests API simultáneas.

**La realidad:**
- Puedo spawnear hasta 8 subagentes concurrentes
- Cada uno es una sesión independiente
- Si cada subagent hace 1 request API → 8x más rápido
- Con orquestador (depth 2) → hasta 40 workers (8 orchestrators × 5 workers cada uno)

**El bottleneck real:**
- No es API rate limits (8 concurrentes)
- Es yo acordándome de spawnear en paralelo
- Es diseñar tareas que SEAN paralelizables

---

## Plan de Auto-Entrenamiento

### Fase 1: Primer Spawn

1. Identificar tarea paralelizable
2. Spawnear 1 subagent
3. Revisar resultado
4. Documentar learnings

### Fase 2: Fan-Out Simple

1. Identificar 5 tareas independientes
2. Spawnear 5 subagentes simultáneos
3. Comparar tiempo vs secuencial
4. Documentar speedup

### Fase 3: Orquestador (con maxSpawnDepth: 2)

1. Activar maxSpawnDepth: 2
2. Crear subagent orquestador
3. Orquestador spawnea workers
4. Sintetizo resultados

---

## Próximos Pasos Inmediatos

1. **Probar un spawn simple** - Una tarea, un subagent
2. **Medir rendimiento** - Tiempo secuencial vs paralelo
3. **Documentar patrones** - Qué funciona, qué no
4. **Activar maxSpawnDepth: 2** - Si el orquestador tiene valor
5. **Crear skill de orquestación** - Templates para fan-out

---

## Fuentes

- https://docs.openclaw.ai/tools/subagents
- https://zenvanriel.nl/ai-engineer-blog/openclaw-subagents-parallel-tasks-guide/

---

_Creado: 18 Feb 2026 - Investigación de paralelismo y subagentes_
