# Spec: Q&A ORQUESTADOR con Subagentes Depth=2

```
ID: SPEC-QA-ORCH-001
Status: draft
Tags: #subagent #qa #orchestration #depth
Keys: subagent, qa, orchestrator, depth, conversation, synthesis
Last reviewed: 2026-02-19
```

---

## Arquitectura

```
MAIN (GLM-5, Claudio)
    │
    │  Recibe síntesis, muestra a Daniel
    │  Mantiene contacto, reporta progreso
    │
    └─► ORQUESTADOR (GLM-5, depth=1)
            │
            │  Pasa transcripción a MD
            │  Sintetiza para MAIN
            │  Modera si se traban
            │
            ├─► AGENTE-A (GLM-5, depth=2)
            │       └─► Conversa, investiga, responde
            │
            └─► AGENTE-B (Gemini 3 Flash, depth=2)
                    └─► Conversa, investiga, responde
```

---

## Contratos

### MAIN (Claudio)

**Input:**
- Tema elegido por Daniel
- Contexto inicial (archivos, links, etc.)

**Output:**
- Síntesis cada 2-3 intercambios
- Transcripción disponible en MD
- Progreso en tiempo real: "Agentes conversando... [2/5 min]"

**Responsabilidades:**
1. Spawn ORQUESTADOR con tema
2. Monitorear con `/subagents list`
3. Recibir síntesis y mostrar a Daniel
4. Si Daniel tiene pregunta → pasarla al ORQUESTADOR
5. Al finalizar: actualizar memoria con hallazgos

---

### ORQUESTADOR (GLM-5)

**Input:**
```
Tema: <tema elegido>
Contexto: <archivos, links, datos>
Timeout: 5 min por agente
Transcripción: /root/.openclaw/workspace/memory/qa-transcripts/YYYY-MM-DD__tema.md
```

**Output:**
```
## Síntesis [Turno N]

**AGENTE-A (GLM-5):**
- Punto clave 1
- Punto clave 2

**AGENTE-B (Gemini):**
- Punto clave 1
- Punto clave 2

**Consenso:** <donde coinciden>
**Disonancia:** <donde difieren>
**Pregunta para Daniel:** <si hay ambigüedad que él debe resolver>
```

**Responsabilidades:**
1. Spawn AGENTE-A y AGENTE-B con contexto
2. Pasar pregunta inicial a ambos
3. Recibir respuestas y pasarlas al otro agente (conversación cruzada)
4. Cada 2-3 intercambios: generar síntesis para MAIN
5. Si se traban (ciclo, repetición): intervenir con pregunta moderadora
6. Escribir transcripción completa en MD
7. Al finalizar: generar síntesis final

---

### AGENTE-A (GLM-5)

**Input:**
```
Eres AGENTE-A en un debate sobre: <tema>
Tu contraparte es AGENTE-B (Gemini).
Responde con insights, datos, perspectivas.
No repitas lo que ya se dijo.
Si no sabes algo, dilo.
Formato: bullets concisos, máx 200 palabras.
```

**Output:**
- Insights sobre el tema
- Respuestas a lo que dijo AGENTE-B
- Preguntas para profundizar

---

### AGENTE-B (Gemini 3 Flash)

**Input:**
```
Eres AGENTE-B en un debate sobre: <tema>
Tu contraparte es AGENTE-A (GLM-5).
Responde con insights, datos, perspectivas.
No repitas lo que ya se dijo.
Si no sabes algo, dilo.
Formato: bullets concisos, máx 200 palabras.
```

**Output:**
- Insights sobre el tema
- Respuestas a lo que dijo AGENTE-A
- Preguntas para profundizar

---

## Flujo de Conversación

### Turno 1
1. ORQUESTADOR envía pregunta inicial a AMBOS
2. AMBOS responden en paralelo
3. ORQUESTADOR recibe ambas respuestas
4. ORQUESTADOR envía respuesta de A → B y B → A

### Turno 2+
1. AGENTE-A responde a lo que dijo B
2. AGENTE-B responde a lo que dijo A
3. ORQUESTADOR sintetiza cada 2-3 turnos
4. ORQUESTADOR escribe transcripción

### Si se traban
1. ORQUESTADOR detecta: repetición, ciclo, sin progreso
2. ORQUESTADOR envía pregunta moderadora a AMBOS:
   ```
   "Parece que están en un ciclo. Nuevos ángulos:
   1. ¿Qué pasaría si...?
   2. ¿Hay evidencia contraria?
   3. ¿Qué NO estamos considerando?"
   ```
3. AMBOS responden a la moderación
4. Conversación continúa

---

## Archivo de Transcripción

**Ubicación:** `/root/.openclaw/workspace/memory/qa-transcripts/YYYY-MM-DD__tema.md`

**Formato:**
```markdown
# Q&A Transcript: <tema>

**Fecha:** YYYY-MM-DD HH:MM UTC
**Participantes:** AGENTE-A (GLM-5), AGENTE-B (Gemini)
**Moderador:** ORQUESTADOR (GLM-5)
**Duración:** X min

---

## Pregunta Inicial
<pregunta de Daniel>

---

## Turno 1

### AGENTE-A (GLM-5)
<respuesta>

### AGENTE-B (Gemini)
<respuesta>

---

## Turno 2

### AGENTE-A → AGENTE-B
<respuesta>

### AGENTE-B → AGENTE-A
<respuesta>

---

## Síntesis [Turno 2]
<síntesis del orquestador>

---

## Turno 3
...

---

## Síntesis Final
<síntesis completa>

## Hallazgos Clave
- Hallazgo 1
- Hallazgo 2
- Hallazgo 3

## Acciones
- [ ] Acción 1
- [ ] Acción 2

## Actualizar Memoria
- [ ] Actualizar MEMORY.md con <hallazgo>
- [ ] Crear ref-<tema>.md si aplica
```

---

## Procedimiento para MAIN

### Paso 1: Preparar contexto
```bash
# Crear directorio de transcripciones
mkdir -p /root/.openclaw/workspace/memory/qa-transcripts
```

### Paso 2: Spawn ORQUESTADOR
```
/subagents spawn --agent-id qa-orchestrator --message "Tema: <TEMA>. Contexto: <CONTEXTO>. Transcripción: qa-transcripts/2026-02-19__tema.md. Timeout: 5 min por agente."
```

### Paso 3: Monitorear
```
/subagents list  # Ver si está trabajando
```

### Paso 4: Recibir síntesis
- ORQUESTADOR envía síntesis cada 2-3 turnos
- MAIN muestra a Daniel
- Daniel puede intervenir con preguntas

### Paso 5: Al finalizar
1. Leer transcripción completa
2. Actualizar memoria con hallazgos
3. Crear ref-<tema>.md si es relevante
4. Actualizar index.md

---

## Métricas

| Métrica | Target |
|---------|--------|
| Tiempo hasta primera síntesis | < 2 min |
| Turnos antes de síntesis | 2-3 |
| Duración máxima | 15 min |
| Transcripción chars | < 10KB |

---

## ⚠️ LIMITACIONES REALES (Descubierto 19 Feb 2026)

### El diseño NO funciona con tier gratuito:

| Modelo | Concurrent Limit | Daily Limit | Problema |
|--------|-----------------|-------------|----------|
| GLM-5 | **1 request** | Sin límite | Si MAIN usa GLM-5, subagente NO puede |
| Gemini 3 Flash | ? | **20 requests** | Se agota rápido en orquestación |
| Claude | ? | Requiere créditos | No es gratis |

### El error específico:
```
MAIN (GLM-5) → spawnea ORQUESTADOR (GLM-5)
             ↓
       429 "Too many concurrent requests for this model"
```

**Conclusión:** GLM-5 solo permite 1 request a la vez. No puedo usar el mismo modelo para main y subagentes concurrentes.

### Soluciones reales:

1. **MAIN usa GLM-5, subagentes usan Gemini** — Pero Gemini tiene límite 20/día
2. **Orquestación SECUENCIAL** — No concurrente, esperar turns
3. **Añadir créditos a Claude** — $5 mínimo para fallback real
4. **MAIN hace de orquestador** — No spawnear, preguntar directamente en la conversación

---

## Anti-Patterns

### ❌ ORQUESTADOR que interviene demasiado
```
Cada turno el orquestador comenta → NO
```

### ✅ ORQUESTADOR que sintetiza y modera
```
Solo interviene si se traban o cada 2-3 turnos → SÍ
```

### ❌ MAIN que desaparece
```
Spawnea y no reporta progreso → NO
```

### ✅ MAIN que mantiene contacto
```
"Agentes en turno 2... sintetizando" → SÍ
```

### ❌ Asumir concurrencia gratuita (ERROR REAL)
```
MAIN (GLM-5) → ORQUESTADOR (GLM-5) → AGENTES (GLM-5 + Gemini)
→ 429 Too many concurrent requests
```

### ✅ Diseñar para límites reales
```
MAIN (GLM-5) → pregunta directamente a Gemini via spawn
→ Recibe respuesta, responde, sintetiza
→ Sin depth=2, sin orquestador extra
```

---

## Configuración Requerida

Verificar en `openclaw.json`:
```json5
agents: {
  defaults: {
    subagents: {
      maxSpawnDepth: 2,  // ← Debe ser >= 2
      maxConcurrent: 3   // ← Orquestador + 2 agentes
    }
  }
}
```

---

_Creado: 2026-02-19 - Especificación para Q&A con orquestación depth=2_
