# Runbook: Orquestador de Subagentes

ID: RBK-ORCHESTRATOR-001
Status: active
Tags: #subagentes #orquestacion #prompts #comunicacion
Keys: subagentes, orchestrator, prompts, communication, gemini, glm5
Last reviewed: 2026-02-19

---

## Trigger

Cuando necesito:
- Investigar un tema complejo
- Analizar un repositorio o código
- Hacer Q&A profundo
- Delegar tareas mientras yo hago otra cosa

---

## Preconditions

1. **Verificar que Daniel NO está interactuando** (si está interactuando, solo 1 subagente a la vez)
2. **Verificar qué modelo usar** (ver tabla de modelos)
3. **Tener clara la tarea** (no spawnear sin objetivo definido)

---

## Steps

### 1. Decidir el modelo del subagente

| Si la tarea es... | Usar... | Razón |
|-------------------|---------|-------|
| Investigación web | Gemini 3 Flash | Gratis, rápido, buena búsqueda |
| Análisis de código | Gemini 3 Flash | Bueno analizando |
| Q&A / Debate | Gemini 3 Flash | Conversacional |
| Tarea simple local | GLM-5 (solo si yo NO estoy activo) | Gratis |

**⚠️ REGLA CRÍTICA:**
```
Si YO soy GLM-5 y estoy ACTIVO (respondiendo a Daniel)
→ NO puedo spawnear GLM-5 como subagente (429 error)
→ Solo puedo spawnear Gemini
```

### 2. Estructurar el prompt del subagente

**Formato obligatorio:**

```markdown
Eres [ROL] en un sistema de subagentes. Tu contraparte soy yo (Claudio, GLM-5, el main).

## Tu rol:
- [Qué se espera de ti]
- [Qué NO debes hacer]

## Contexto:
- [Información necesaria para la tarea]

## Tarea:
- [Qué debes hacer específicamente]

## Restricciones:
- NO ejecutar comandos
- NO usar tools peligrosas
- NO inventar información

## Output esperado:
- [Formato específico: bullets, MD, tabla, etc.]
- [Longitud aproximada]

## Importante:
- Sé conciso (máx X palabras por respuesta)
- Si no sabes algo, dilo
- Cita fuentes cuando sea posible
```

### 3. Ejecutar el spawn

```javascript
sessions_spawn({
  label: "NOMBRE-DESCRIPTIVO",  // Para tracking
  model: "google/gemini-3-flash-preview",  // Modelo correcto
  runTimeoutSeconds: 600,  // 10 min máx
  task: "[PROMPT COMPLETO]"
})
```

### 4. Esperar (NO hacer nada más)

**⚠️ CRÍTICO:**
```
Después de spawnear:
- NO responder a Daniel hasta que llegue el resultado
- NO hacer polling (el sistema avisa automáticamente)
- NO spawnear otro subagente
- NO hacer otras tareas

Solo esperar el [System Message] con el resultado.
```

### 5. Recibir e integrar resultado

Cuando llegue el `[System Message]`:
1. Leer el resultado completo
2. Filtrar información relevante
3. Integrar en memoria si es necesario
4. Reportar a Daniel en formato conciso

---

## Plantillas de Prompts por Tipo de Tarea

### A. Investigación Web

```markdown
Eres INVESTIGADOR en un sistema de subagentes.

## Tu rol:
- Buscar información en la web
- Sintetizar hallazgos clave
- Citar fuentes

## Tarea:
Investiga sobre: [TEMA]

## Qué necesito:
1. Resumen ejecutivo (3 bullets)
2. Hallazgos principales (5 bullets)
3. Fuentes consultadas (URLs)
4. Gaps de información (qué no encontraste)

## Output:
Markdown con secciones claras. Máx 500 palabras.
```

### B. Análisis de Repositorio/Código

```markdown
Eres ANALISTA DE CÓDIGO en un sistema de subagentes.

## Tu rol:
- Analizar estructura de repositorios
- Identificar patrones y anti-patrones
- Evaluar seguridad

## Tarea:
Analiza: [URL del repositorio]

## Qué necesito:
1. Resumen del proyecto
2. Estructura de archivos
3. Patrones utilizados
4. Riesgos de seguridad (si hay)
5. Recomendaciones

## Restricciones:
- NO clonar el repositorio
- Solo lectura via web_fetch
- NO ejecutar código

## Output:
Markdown con análisis estructurado. Máx 800 palabras.
```

### C. Q&A / Debate

```markdown
Eres DEBATIDOR en un sistema de Q&A.

## Tu rol:
- Responder desde perspectiva técnica
- Hacer preguntas que profundicen
- Ser conciso pero completo

## Contexto:
[SITUACIÓN O TEMA]

## Pregunta inicial:
[PREGUNTA]

## Formato:
- Respuesta directa primero
- Luego preguntas de seguimiento
- Máx 200 palabras por respuesta

## Importante:
- Si no estás de acuerdo, dilo
- Cita evidencia cuando sea posible
- No repitas lo obvio
```

### D. Tarea Simple (GLM-5, solo cuando main inactivo)

```markdown
Eres WORKER en un sistema de subagentes.

## Tarea simple:
[DESCRIPCIÓN]

## Output esperado:
[FORMATO]

## Timeout:
5 minutos máximo.

Hazlo directo, sin explicaciones extra.
```

---

## Comunicación entre Subagentes

### Patrón Secuencial (recomendado):

```
YO spawneo SUBAGENTE-1 (Gemini)
    ↓
SUBAGENTE-1 termina → devuelve ARTEFACTO-1
    ↓
YO proceso ARTEFACTO-1
    ↓
YO spawneo SUBAGENTE-2 (Gemini) con contexto de ARTEFACTO-1
    ↓
SUBAGENTE-2 termina → devuelve ARTEFACTO-2
    ↓
YO integro ambos y reporto
```

### Patrón Paralelo (solo en still):

```
YO spawneo SUBAGENTE-A (Gemini) → Tarea A
YO spawneo SUBAGENTE-B (GLM-5) → Tarea B (solo si yo inactivo)
    ↓
Ambos corren en paralelo
    ↓
Sistema notifica cuando ambos terminan
    ↓
YO integro ambos resultados
```

---

## Anti-Patrones (NUNCA HACER)

| ❌ Anti-patrón | Consecuencia | Solución |
|----------------|--------------|----------|
| Spawnear GLM-5 mientras yo uso GLM-5 | 429 error (rate limit) | Usar Gemini para subagentes |
| Spawnear sin esperar | Pierdo el resultado | Siempre esperar el System Message |
| Prompt vago ("ayúdame") | Output inútil | Prompt estructurado con output esperado |
| Spawnear en conversación activa con Daniel | Bloqueo | Solo spawnear en still o tareas largas |
| No poner timeout | Subagente corre infinito | Siempre poner runTimeoutSeconds |
| Spawnear múltiples subagentes GLM-5 | Todos fallan | Solo 1 GLM-5 a la vez |

---

## Checklist Pre-Spawn

Antes de spawnear, verificar:

- [ ] ¿Daniel está interactuando? → Si sí, solo 1 subagente
- [ ] ¿Qué modelo necesito? → Gemini para casi todo
- [ ] ¿Tengo el prompt estructurado? → Con rol, tarea, output
- [ ] ¿Puse timeout? → 600s (10 min) default
- [ ] ¿Puse label descriptivo? → Para tracking
- [ ] ¿Estoy listo para esperar? → No hacer nada más hasta resultado

---

## Checklist Post-Resultado

Cuando llega el resultado:

- [ ] ¿Leí completo el output?
- [ ] ¿Filtré información relevante?
- [ ] ¿Creé artefacto en memoria? (si aplica)
- [ ] ¿Actualicé index.md? (si creé archivo)
- [ ] ¿Reporté a Daniel en formato conciso?

---

## Ejemplo Completo: Análisis de ClawWork

### Prompt que funcionó:

```markdown
Eres un investigador de seguridad. Analiza https://github.com/HKUDS/ClawWork

## Tu tarea:
Investiga SIN ejecutar comandos. Usa web_fetch para leer el README y código.

## Entrega UN archivo markdown con:
[Lista específica de secciones]

## IMPORTANTE:
- Sé directo, sin relleno
- Usa bullets
- Si no encuentras algo, di "no encontrado"
- Cita fuentes cuando sea posible

Empieza leyendo el README del repo.
```

### Resultado:
- 6 minutos de ejecución
- 3.3K tokens de output
- Archivo ANALISIS-CLAWWORK.md creado
- Información completa y útil

---

## Tiempos Estimados

| Tipo de tarea | Timeout recomendado |
|---------------|---------------------|
| Búsqueda simple | 120s (2 min) |
| Análisis de repo | 600s (10 min) |
| Q&A largo | 300s (5 min) |
| Investigación profunda | 1800s (30 min) |

---

## Rollback

Si el subagente falla:
1. Revisar el error (rate limit, timeout, etc.)
2. Si es rate limit → esperar 1 minuto, reintentar
3. Si es timeout → simplificar la tarea
4. Si falla 2 veces → hacer la tarea yo mismo sin subagente

---

## Gotchas

- Gemini 3 Flash tiene 20 req/día → trackear uso
- GLM-5 main + GLM-5 subagente = CHOQUE SEGURO
- El sistema NO hace polling automático → yo debo esperar
- Los System Messages llegan como mensajes separados → leerlos

---

_Creado: 2026-02-19 - Runbook de orquestación de subagentes_
