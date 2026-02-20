# Anti-Patrones de Comunicación para LLMs

ID: REF-ANTIPATTERNS-001
Status: active
Tags: #communication #antipatterns #prompts #quality
Keys: anti-patterns, communication, prompts, questions, precision
Last reviewed: 2026-02-20

---

## El Problema Central

**Los LLMs (incluido yo) fallamos más por CÓMO nos preguntan que por falta de capacidad.**

Un prompt mal formulado activa patrones de respuesta genéricos.
Un prompt preciso activa razonamiento específico.

---

## 15 Anti-Patrones y Sus Fixes

### 1. El Prompt Abierto

| ❌ MAL | ✅ BIEN |
|--------|---------|
| "Analiza este código" | "En este código, identifica: 1) bugs potenciales, 2) problemas de performance, 3) violaciones de PEP8. Output: tabla con línea, problema, fix." |

**Por qué falla:** Sin dirección, el modelo elige qué analizar. Puede ignorar lo importante.

---

### 2. La Pregunta Implícita

| ❌ MAL | ✅ BIEN |
|--------|---------|
| "El servidor está lento" | "El servidor responde en >5s. ¿Cuáles son las 3 causas más probables y cómo diagnosticar cada una?" |

**Por qué falla:** No hay pregunta explícita. El modelo puede describir el problema en vez de resolverlo.

---

### 3. El Contexto Faltante

| ❌ MAL | ✅ BIEN |
|--------|---------|
| "¿Por qué falla?" | "Este error aparece al ejecutar `docker-compose up`: [ERROR]. Contexto: Ubuntu 22.04, Docker 24.0, archivo compose adjunto. ¿Por qué falla?" |

**Por qué falla:** Sin contexto, el modelo adivina. Con contexto, diagnostica.

---

### 4. El Contexto Excesivo

| ❌ MAL | ✅ BIEN |
|--------|---------|
| "[500 líneas de logs] ¿Qué pasó?" | "Últimas 20 líneas relevantes del log: [LOG]. Busco: por qué el servicio X dejó de responder a las 14:32." |

**Por qué falla:** Demasiada información oculta lo importante. El modelo se pierde.

---

### 5. La Ambigüedad de Scope

| ❌ MAL | ✅ BIEN |
|--------|---------|
| "Mejora este código" | "Refactoriza esta función para: 1) Reducir complejidad ciclomática de 15 a <10, 2) Eliminar el parámetro `flag` usando polimorfismo. No cambies la API pública." |

**Por qué falla:** "Mejora" puede significar 100 cosas. El modelo elige una que quizás no necesitas.

---

### 6. El Output No Especificado

| ❌ MAL | ✅ BIEN |
|--------|---------|
| "Dame información sobre X" | "Sobre X, necesito: 1) Definición (1 línea), 2) Pros/cons (tabla), 3) Cuándo usar vs no usar. Máx 200 palabras." |

**Por qué falla:** Sin formato, el output es impredecible. Puede ser un ensayo cuando necesitas bullets.

---

### 7. La Pregunta Compuesta No Estructurada

| ❌ MAL | ✅ BIEN |
|--------|---------|
| "¿Qué es X, cómo funciona, cuándo usarlo y qué alternativas hay?" | "Sobre X responde EN ESTE ORDEN: 1. ¿Qué es? (1 línea) 2. ¿Cómo funciona? (3 bullets) 3. ¿Cuándo usar? (2 casos) 4. ¿Alternativas? (tabla comparativa)" |

**Por qué falla:** Preguntas mezcladas generan respuestas mezcladas. Estructura fuerza claridad.

---

### 8. El "Sé Creativo"

| ❌ MAL | ✅ BIEN |
|--------|---------|
| "Sé creativo con la solución" | "Genera 3 soluciones diferentes: 1) La más simple, 2) La más robusta, 3) La más innovadora. Para cada una: implementación + tradeoffs." |

**Por qué falla:** "Creativo" no es una instrucción. Dar opciones estructuradas sí lo es.

---

### 9. El Prompt Sin Restricciones

| ❌ MAL | ✅ BIEN |
|--------|---------|
| "Escribe documentación para esta API" | "Documenta esta API: - Formato: OpenAPI 3.0 - Incluir: descripción, params, responses, ejemplos - NO incluir: implementación interna, TODOs - Longitud: ~100 líneas" |

**Por qué falla:** Sin límites, el modelo puede generar 1000 líneas o 10. Con límites, genera lo útil.

---

### 10. La Suposición No Verificada

| ❌ MAL | ✅ BIEN |
|--------|---------|
| "Arregla el bug en la línea 42" | "Hay un posible bug en línea 42. Antes de arreglar: 1) Confirma si realmente es un bug, 2) Si sí, explica por qué, 3) Luego propón fix." |

**Por qué falla:** Si asumes mal, el modelo "arregla" algo que no estaba roto.

---

### 11. El "Explica Todo"

| ❌ MAL | ✅ BIEN |
|--------|---------|
| "Explícame cómo funciona Docker" | "Explica Docker asumiendo que: - Sé qué es virtualización - NO sé qué son containers vs VMs - Necesito entender: namespaces, cgroups, layers. Nivel: intermedio. Máx 300 palabras." |

**Por qué falla:** Sin saber tu nivel, el modelo explica desde cero o asume demasiado.

---

### 12. La Pregunta de Sí/No que Necesita Más

| ❌ MAL | ✅ BIEN |
|--------|---------|
| "¿Debería usar Redis?" | "¿Debería usar Redis para [MI_CASO]? Responde: 1) Sí/No/Depende, 2) Por qué, 3) Si no, ¿qué alternativa?, 4) Si sí, ¿qué considerar?" |

**Por qué falla:** Sí/No sin contexto no es útil. Forzar estructura obtiene razonamiento.

---

### 13. El Copy-Paste Sin Contexto

| ❌ MAL | ✅ BIEN |
|--------|---------|
| "[stack trace de 50 líneas]" | "Error en producción. Stack trace relevante (líneas 12-18): [EXTRACTO]. Contexto: Python 3.11, FastAPI, después de deploy de [FEATURE]. ¿Causa probable?" |

**Por qué falla:** Dump de información ≠ contexto útil. Curar antes de pegar.

---

### 14. El "Hazlo Bien"

| ❌ MAL | ✅ BIEN |
|--------|---------|
| "Escribe tests buenos para esto" | "Escribe tests que cubran: 1) Happy path con input válido, 2) Edge case: input vacío, 3) Edge case: input muy grande, 4) Error handling: excepción esperada. Framework: pytest. Mocks: solo para DB." |

**Por qué falla:** "Bueno" es subjetivo. Criterios específicos son objetivos.

---

### 15. La Iteración Implícita

| ❌ MAL | ✅ BIEN |
|--------|---------|
| [después de respuesta] "No, así no" | [después de respuesta] "Tu respuesta asume X pero en mi caso Y. Ajusta: 1) Cambia [parte específica], 2) Mantén [lo que está bien], 3) El formato está bien." |

**Por qué falla:** "Así no" no dice qué está mal. Feedback específico permite corrección precisa.

---

## Patrones de Preguntas Efectivas

### Patrón STAR (Situación, Tarea, Acción, Resultado)

```
SITUACIÓN: [Contexto breve]
TAREA: [Qué necesito lograr]
ACCIÓN: [Qué quiero que hagas]
RESULTADO: [Formato esperado]
```

### Patrón CONSTRAINT-FIRST

```
RESTRICCIONES:
- Máx X líneas
- Solo usar Y
- NO hacer Z

TAREA:
[Lo que necesito]
```

### Patrón VERIFY-THEN-ACT

```
PRIMERO: Confirma que entiendes [X]
SI entiendes bien: Procede con [Y]
SI no: Pregunta qué te falta
```

### Patrón PRIORITIZED

```
NECESITO (en orden de prioridad):
1. [CRÍTICO] - sin esto no sirve
2. [IMPORTANTE] - muy útil
3. [NICE-TO-HAVE] - si hay espacio

Si te quedas sin espacio, entrega solo 1 y 2.
```

---

## Checklist Antes de Preguntar

```markdown
□ ¿Mi pregunta tiene un verbo de acción claro?
□ ¿Incluí el contexto NECESARIO (no todo)?
□ ¿Especifiqué el formato de output?
□ ¿Puse límites de longitud?
□ ¿Definí qué NO quiero?
□ ¿Es una pregunta o varias? (si varias, estructurar)
□ ¿Asumí algo que debería verificar primero?
```

---

## Cómo Pedir Exactamente lo que Necesitas

### Técnica 1: El Output Fantasma

Escribe primero el output ideal que quisieras recibir.
Luego formula la pregunta que lo generaría.

```
Output que quiero:
| Problema | Línea | Severidad | Fix |
|----------|-------|-----------|-----|
| SQL injection | 42 | Alta | Usar parametrized |

Pregunta que lo genera:
"Revisa seguridad de [código]. Output: tabla con columnas Problema, Línea, Severidad, Fix. Solo vulnerabilidades reales, no warnings de estilo."
```

### Técnica 2: El Anti-Output

Define qué NO quieres para evitarlo.

```
"Necesito [X].
NO quiero:
- Explicaciones de por qué X es importante (ya lo sé)
- Alternativas a X (ya decidí)
- Disclaimers sobre limitaciones (soy consciente)
SOLO quiero: [lo específico]"
```

### Técnica 3: El Ejemplo Guía

Da un ejemplo del formato que esperas.

```
"Lista errores en este formato:
- L42: 'variable undefined' → declarar antes del loop
- L58: 'type mismatch' → cast explícito a int

Ahora analiza [código] con ese formato."
```

---

## Señales de que Tu Prompt Falló

| Señal | Probable Causa | Fix |
|-------|----------------|-----|
| Respuesta muy larga | No pusiste límite | Añadir "máx X palabras" |
| Respuesta muy corta | Pregunta cerrada | Añadir "explica por qué" |
| Respuesta off-topic | Contexto ambiguo | Ser más específico |
| Respuesta genérica | Falta tu caso específico | Añadir "en mi caso: [X]" |
| "Depende" sin más | No diste suficiente contexto | Añadir constraints |
| Muchos disclaimers | No dijiste que eres experto | Añadir "asume que sé [X]" |

---

_Creado: 2026-02-20 - Entrenamiento Opus → Claudio_
