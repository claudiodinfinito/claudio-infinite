# Orquestación Avanzada de Subagentes

ID: REF-ORCHESTRATION-ADV-001
Status: active
Tags: #subagentes #orchestration #advanced #decision-tree
Keys: subagent, spawn, orchestration, prompts, integration
Last reviewed: 2026-02-20

---

## Decision Tree: ¿Spawneo o No?

```
¿La tarea requiere >5 minutos de trabajo?
│
├─ NO → Hazlo tú mismo
│
└─ SÍ → ¿Requiere acceso a herramientas que tú no tienes?
         │
         ├─ SÍ → ¿Qué herramienta?
         │       ├─ Web search profundo → Spawn Gemini
         │       ├─ Análisis de código externo → Spawn Gemini
         │       └─ Herramienta local → Hazlo tú
         │
         └─ NO → ¿Puedes dividir en subtareas independientes?
                  │
                  ├─ SÍ → ¿Estás en STILL (sin interacción)?
                  │       ├─ SÍ → Spawn paralelo (Gemini)
                  │       └─ NO → Secuencial, tú primero
                  │
                  └─ NO → ¿La tarea es blocking?
                          ├─ SÍ → Spawn y espera
                          └─ NO → Hazlo tú en background
```

---

## Cuándo REALMENTE Vale la Pena Spawnear

### ✅ SPAWN - Alto ROI

| Situación | Por qué vale la pena |
|-----------|---------------------|
| Investigación web profunda (>3 fuentes) | Gemini es mejor buscando |
| Análisis de repo externo | No contamina tu contexto |
| Tarea paralela durante STILL | Multiplicas throughput |
| Trabajo que puede fallar | Aíslas el riesgo |
| Tarea con output grande | No llena tu contexto |

### ❌ NO SPAWN - Bajo ROI

| Situación | Por qué NO vale |
|-----------|-----------------|
| Tarea de 2-3 minutos | Overhead de spawn > ahorro |
| Necesitas el resultado inmediato para continuar | Blocking te frena igual |
| Tarea que requiere tu contexto | Subagente no lo tiene |
| Daniel está esperando respuesta | Spawn introduce latencia |
| Ya tienes la info, solo necesitas sintetizar | No delegues lo fácil |

---

## Qué Pasarle EXACTAMENTE al Subagente

### Checklist Obligatorio (antes de spawn)

```markdown
□ ROL claro (1 línea)
□ CONTEXTO mínimo necesario (no todo lo que sabes)
□ TAREA específica (verbo + objeto + condición)
□ OUTPUT definido (formato + longitud + secciones)
□ RESTRICCIONES explícitas (qué NO hacer)
□ TIMEOUT apropiado
□ LABEL descriptivo para tracking
```

### Template Universal Optimizado

```markdown
# Subagente: [LABEL]

## Rol
Eres [ROL] especializado en [DOMINIO].

## Contexto (solo lo necesario)
- [HECHO_RELEVANTE_1]
- [HECHO_RELEVANTE_2]
- [CONSTRAINT_IMPORTANTE]

## Tarea
[VERBO] [OBJETO] para [PROPÓSITO].

Específicamente:
1. [SUBTAREA_1]
2. [SUBTAREA_2]
3. [SUBTAREA_3]

## Output Requerido
Formato: [markdown/tabla/lista/código]
Secciones:
- [SECCIÓN_1]: [qué contiene]
- [SECCIÓN_2]: [qué contiene]
Longitud: máx [N] palabras / [M] líneas

## Restricciones
- NO [ACCIÓN_PROHIBIDA_1]
- NO [ACCIÓN_PROHIBIDA_2]
- Si no encuentras [X], reporta "[mensaje específico]"

## Prioridad
Si te quedas sin tiempo, entrega [MÍNIMO_VIABLE].
```

---

## Templates por Tipo de Tarea

### Template A: Investigación Focalizada

```markdown
# Subagente: research-[TEMA]

## Rol
Investigador técnico con acceso a web.

## Contexto
Estoy trabajando en [PROYECTO] y necesito información sobre [TEMA].
Lo que YA SÉ: [LISTA_BREVE]
Lo que NO SÉ y necesito: [LISTA_ESPECÍFICA]

## Tarea
Busca información sobre [TEMA] enfocándote en:
1. [ASPECTO_ESPECÍFICO_1]
2. [ASPECTO_ESPECÍFICO_2]
3. [ASPECTO_ESPECÍFICO_3]

## Output
### Resumen Ejecutivo (3 bullets, máx 50 palabras)
### Hallazgos por Aspecto
| Aspecto | Hallazgo | Fuente | Confianza |
### Gaps (qué no encontraste)
### Fuentes (URLs)

Máx 400 palabras total.

## Restricciones
- NO incluir información que ya mencioné que sé
- NO especular sin marcar como "especulación"
- Si un aspecto no tiene info, di "No encontrado" (no inventes)
```

### Template B: Análisis de Código/Repo

```markdown
# Subagente: analyze-[NOMBRE]

## Rol
Analista de código senior.

## Contexto
Necesito entender [REPO/ARCHIVO] para [PROPÓSITO].
Mi stack: [TECNOLOGÍAS_RELEVANTES]

## Tarea
Analiza [URL_O_PATH] y extrae:
1. Arquitectura general (cómo está organizado)
2. Dependencias críticas
3. Patrones usados
4. [ASPECTO_ESPECÍFICO_PARA_MI_CASO]

## Output
### Overview (1 párrafo, máx 50 palabras)
### Estructura
```
[ASCII tree simplificado]
```
### Análisis
| Componente | Propósito | Dependencias | Notas |
### Recomendaciones (si aplica)

Máx 600 palabras.

## Restricciones
- NO clonar repos
- Usa web_fetch para leer archivos
- Si el repo es muy grande, enfócate en [DIRECTORIO_PRINCIPAL]
```

### Template C: Síntesis/Transformación

```markdown
# Subagente: transform-[TIPO]

## Rol
Procesador de información.

## Input
[PEGAR_CONTENIDO_O_REFERENCIA]

## Tarea
Transforma el input a [FORMATO_DESTINO]:
- [REGLA_1]
- [REGLA_2]
- [REGLA_3]

## Output
[FORMATO_EXACTO_ESPERADO]

Máx [N] líneas.

## Restricciones
- Output SOLO el resultado, sin explicaciones
- Si algo es ambiguo, usa [CONVENCIÓN_DEFAULT]
```

### Template D: Validación/Review

```markdown
# Subagente: review-[OBJETO]

## Rol
Reviewer crítico con experiencia en [DOMINIO].

## Contexto
[OBJETO] fue creado para [PROPÓSITO].
Criterios de aceptación: [LISTA]

## Tarea
Revisa [OBJETO] evaluando:
1. ¿Cumple el propósito? (sí/no + por qué)
2. ¿Problemas de [ASPECTO_1]? (lista)
3. ¿Problemas de [ASPECTO_2]? (lista)
4. ¿Mejoras sugeridas? (priorizadas)

## Output
### Veredicto: [PASS/FAIL/PASS_WITH_NOTES]
### Issues
| # | Severidad | Descripción | Sugerencia |
### Mejoras Opcionales
[lista priorizada]

Máx 300 palabras.

## Restricciones
- Sé específico (línea/sección exacta)
- Severidad: crítico/alto/medio/bajo
- Si PASS, igual lista mejoras menores
```

---

## Cómo Integrar Output Sin Perder Información

### Paso 1: Recibir y Validar

```
Cuando llegue el [System Message]:
1. ¿Completó la tarea? (sí/no/parcial)
2. ¿El formato es el esperado?
3. ¿Hay información que contradice lo que yo sé?
```

### Paso 2: Extraer y Filtrar

```
Del output del subagente:
- MANTENER: datos nuevos, hallazgos específicos, URLs
- DESCARTAR: explicaciones obvias, relleno, disclaimers
- MARCAR: especulaciones, baja confianza, gaps
```

### Paso 3: Integrar a Memoria

```
Si el output es valioso (>3 datos nuevos):
1. Crear archivo en memory/ con prefijo apropiado
2. Incluir metadata: fuente=subagente, fecha, confianza
3. Actualizar memory/index.md
4. Referenciar en daily log

Si el output es puntual:
- Incluir directamente en respuesta a Daniel
- No crear archivo separado
```

### Paso 4: Reportar a Daniel

```
Formato de reporte:
"Investigué [TEMA] (subagente Gemini, X min):
- [HALLAZGO_CLAVE_1]
- [HALLAZGO_CLAVE_2]
- [HALLAZGO_CLAVE_3]
Detalle en memory/[archivo].md"
```

---

## Anti-Patrones de Integración

| ❌ Anti-patrón | Consecuencia | ✅ Solución |
|----------------|--------------|-------------|
| Copy-paste todo el output | Ruido, pierde lo importante | Filtrar a bullets clave |
| Ignorar los gaps reportados | Falsa sensación de completitud | Incluir "No encontrado: X" |
| No guardar fuentes | No puedo verificar después | Siempre guardar URLs |
| Crear archivo por cada output | memory/ se llena de basura | Solo si >3 datos nuevos |
| No marcar confianza | Todo parece igual de cierto | Incluir alta/media/baja |

---

## Coordinación de Múltiples Subagentes

### Patrón: Fan-out / Fan-in

```
YO defino 3 subtareas independientes
    │
    ├── Spawn A (Gemini) → Tarea 1
    ├── Spawn B (Gemini) → Tarea 2  [Solo en STILL]
    └── Spawn C (Gemini) → Tarea 3
    │
    ↓ (esperar todos)
    │
YO recibo 3 outputs
    │
    ↓
YO sintetizo en UN artefacto coherente
    │
    ↓
Reporto a Daniel
```

### Patrón: Pipeline

```
Spawn A → Output A
    │
    ↓
YO proceso Output A, extraigo X
    │
    ↓
Spawn B con X como input → Output B
    │
    ↓
YO integro A + B → Resultado final
```

### Reglas de Coordinación

1. **Máx 3 subagentes paralelos** (evitar overwhelm)
2. **Cada uno con tarea atómica** (sin dependencias cruzadas)
3. **Definir merge strategy antes de spawnear**
4. **Tener fallback si uno falla** (continuar con los otros)

---

## Métricas de Éxito

Después de cada spawn, evaluar:

| Métrica | Target | Acción si falla |
|---------|--------|-----------------|
| ¿Completó la tarea? | 100% | Simplificar próximo prompt |
| ¿Output en formato pedido? | 90%+ | Ser más explícito en template |
| ¿Info útil vs relleno? | 70%+ | Añadir "NO incluir [X]" |
| ¿Tiempo < timeout? | 90%+ | Reducir scope |
| ¿Necesité re-spawn? | <10% | Mejor prompt inicial |

---

## Ejemplos de Prompts Que Funcionan vs No

### ❌ Prompt Malo
```
"Investiga sobre Docker y dime qué encontraste"
```
Problema: Vago, sin foco, output impredecible

### ✅ Prompt Bueno
```
"Investiga las mejores prácticas de Docker para producción en 2026.
Enfócate en: 1) Seguridad de imágenes, 2) Límites de recursos, 3) Logging.
Output: tabla con | Práctica | Por qué | Cómo implementar |
Máx 10 prácticas, priorizadas por impacto.
Fuentes: solo docs oficiales o blogs de >1000 stars en GitHub."
```

---

_Creado: 2026-02-20 - Entrenamiento Opus → Claudio_
_Complementa: rbk-subagent-orchestrator.md (básico)_
