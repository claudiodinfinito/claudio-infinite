# One-Liners Avanzados para GLM-5

ID: REF-ONELINERS-ADV-001
Status: active
Tags: #prompts #advanced #glm5 #optimization
Keys: one-liners, advanced, complex-tasks, debugging, refactor
Last reviewed: 2026-02-20

---

## Principio Avanzado

**One-liner avanzado = Múltiples operaciones en un solo request.**

```
LEER → ANALIZAR → DECIDIR → ACTUAR → REPORTAR
(todo en un prompt)
```

---

## Categoría 1: ANÁLISIS PROFUNDO

### 11. Análisis de dependencias
```
"Lee package.json (o requirements.txt), identifica:
1. Deps desactualizadas (>1 año)
2. Deps con CVEs conocidos
3. Deps que podrían eliminarse
Output: tabla | Dep | Versión | Problema | Acción |"
```

### 12. Análisis de complejidad de código
```
"Lee [ARCHIVO].py, para cada función lista:
| Función | Líneas | Params | Complejidad ciclomática estimada |
Marca con ⚠️ las que superen 10."
```

### 13. Detección de código muerto
```
"Lee [DIRECTORIO]/*.py, busca funciones definidas pero nunca llamadas.
Output: | Archivo | Función | Línea | Confianza (alta/media/baja) |"
```

### 14. Análisis de patrones de error
```
"Lee últimas 200 líneas de [LOG], clasifica errores por:
1. Tipo (network/db/auth/logic)
2. Frecuencia
3. Correlación temporal
Output: tabla + hipótesis de causa raíz"
```

### 15. Diff semántico
```
"Compara [ARCHIVO_V1] vs [ARCHIVO_V2]:
- Cambios de lógica (no cosmetic)
- Nuevas dependencias introducidas
- Posibles breaking changes
Output: bullets priorizados por impacto"
```

---

## Categoría 2: DEBUGGING

### 16. Triage de stack trace
```
"Este es el error: [STACKTRACE]
1. Causa probable (1 línea)
2. Archivo/línea más probable
3. Fix sugerido (código listo para copy-paste)
4. Cómo verificar que funcionó"
```

### 17. Debugging de configuración
```
"Lee [CONFIG_FILE], verifica:
- Variables indefinidas/vacías
- Paths que no existen
- Valores default peligrosos
- Inconsistencias entre secciones
Output: checklist con ✅/❌ por item"
```

### 18. Análisis de timeout/performance
```
"Este comando tarda >X segundos: [COMANDO]
Lee los archivos involucrados y lista:
1. Operaciones O(n²) o peor
2. Llamadas de red/IO síncronas
3. Loops que podrían paralelizarse
Output: tabla | Problema | Ubicación | Fix |"
```

### 19. Debugging de permisos
```
"Ejecuta: ls -la [PATH] && id && cat /etc/group | grep [USER]
Diagnostica si [USUARIO] puede [ACCIÓN] en [RECURSO].
Output: Sí/No + explicación en 1 línea + fix si aplica"
```

### 20. Trace de ejecución
```
"Lee [ARCHIVO], simula ejecución mental de [FUNCIÓN] con input [X].
Muestra paso a paso: | Línea | Variable | Valor | Nota |
Identifica dónde fallaría con input [Y]."
```

---

## Categoría 3: REFACTOR

### 21. Extracción de función
```
"Lee [ARCHIVO], líneas [N-M].
Extrae a función separada siguiendo:
- Single responsibility
- Params explícitos (no globals)
- Return value claro
Output: función extraída + llamada desde original"
```

### 22. Conversión de callback a async
```
"Convierte este código con callbacks a async/await:
[CÓDIGO]
Output: código convertido + notas de compatibilidad"
```

### 23. Normalización de error handling
```
"Lee [ARCHIVO], encuentra todos los try/except.
Normaliza a patrón consistente:
- Log antes de re-raise
- Mensajes descriptivos
- Clasificación de errores
Output: archivo refactorizado completo"
```

### 24. Deduplicación
```
"Lee [ARCHIVO_A] y [ARCHIVO_B].
Encuentra código duplicado (>5 líneas).
Output: | Código duplicado | Ubicación A | Ubicación B | Función común propuesta |"
```

### 25. Simplificación condicional
```
"Lee [ARCHIVO], encuentra:
- if anidados >3 niveles
- condiciones que podrían ser early return
- booleanos que podrían simplificarse
Output: antes/después para cada caso"
```

---

## Categoría 4: ARCHIVOS GRANDES

### 26. Lectura segmentada con síntesis
```
"Lee [ARCHIVO_GRANDE] en chunks de 500 líneas.
Por cada chunk, extrae: | Sección | Propósito | Items clave |
Al final, sintetiza estructura general."
```

### 27. Búsqueda en archivo grande
```
"En [ARCHIVO_GRANDE], busca todas las ocurrencias de [PATTERN].
No leas todo - usa: grep -n '[PATTERN]' [ARCHIVO]
Output: | Línea | Contexto (10 chars antes/después) | Relevancia |"
```

### 28. Extracción selectiva
```
"De [ARCHIVO_JSON_GRANDE], extrae solo:
- Keys que contengan 'error' o 'fail'
- Values numéricos > 1000
- Arrays con >10 elementos
Usa jq si disponible, sino python one-liner."
```

### 29. Resumen de log largo
```
"Logs en [PATH] tienen >10K líneas.
Ejecuta: tail -1000 [PATH] | grep -E 'ERROR|WARN|CRITICAL'
Agrupa por tipo y hora.
Output: resumen de últimas 24h en tabla"
```

### 30. Navegación de repo grande
```
"Repo en [PATH] tiene >100 archivos.
Ejecuta: find [PATH] -name '*.py' | head -20 && wc -l [PATH]/**/*.py
Identifica: archivos más grandes, estructura de directorios.
Output: mapa mental del repo (ASCII tree + notas)"
```

---

## Categoría 5: MULTI-STEP EN UN PROMPT

### 31. Pipeline de validación
```
"Para [ARCHIVO_CONFIG]:
1. Validar sintaxis (json/yaml lint)
2. Verificar valores requeridos presentes
3. Comparar contra schema esperado
4. Listar warnings
Output: PASS/FAIL + detalles por paso"
```

### 32. Audit de seguridad express
```
"Lee [ARCHIVO] buscando:
- Secrets hardcodeados (API keys, passwords)
- SQL sin parametrizar
- Paths absolutos peligrosos
- eval() o exec() con input externo
Output: | Riesgo | Línea | Severidad | Fix |"
```

### 33. Documentación automática
```
"Lee [ARCHIVO], genera:
1. Docstring para cada función (formato Google)
2. README section describiendo el módulo
3. Ejemplo de uso
Output: docstrings inline + README.md section"
```

### 34. Migration planning
```
"Código actual en [ARCHIVO_OLD], destino: [FRAMEWORK_NUEVO].
1. Lista funciones que necesitan cambio
2. Mapea old API → new API
3. Identifica breaking changes
4. Estima esfuerzo (horas)
Output: tabla de migración + orden sugerido"
```

### 35. Test generation
```
"Lee [ARCHIVO], genera tests para:
- Happy path de cada función pública
- Edge cases (null, empty, boundary)
- Error conditions
Output: archivo de tests listo para ejecutar"
```

---

## Patrones de Prompt Avanzados

### Patrón CHAIN (cadena de razonamiento)
```
"Para resolver [PROBLEMA]:
PASO 1: Lee [X] y extrae [Y]
PASO 2: Con [Y], calcula [Z]
PASO 3: Si [Z] > [THRESHOLD], entonces [ACCIÓN_A], sino [ACCIÓN_B]
Muestra tu trabajo en cada paso."
```

### Patrón VERIFY (auto-verificación)
```
"[TAREA]
Antes de responder:
- ¿Leíste todo lo necesario?
- ¿Tu respuesta es verificable?
- ¿Hay algo que asumiste sin evidencia?
Incluye sección 'Confianza: alta/media/baja' al final."
```

### Patrón BATCH (múltiples items)
```
"Para cada archivo en [LISTA]:
| Archivo | [ANÁLISIS_1] | [ANÁLISIS_2] | [ACCIÓN] |
Al final, resumen: total analizados, problemas encontrados, prioridad."
```

### Patrón CONSTRAINT (forzar concisión)
```
"[TAREA COMPLEJA]
REGLAS:
- Máx 5 bullets por sección
- Máx 10 palabras por bullet
- Total máx 200 palabras
- Si necesitas más espacio, prioriza por impacto"
```

### Patrón FALLBACK (manejo de incertidumbre)
```
"[TAREA]
Si encuentras [X]: haz [A]
Si no encuentras [X] pero sí [Y]: haz [B]
Si no encuentras nada: reporta qué buscaste y dónde"
```

---

## Reglas para One-Liners Avanzados

1. **Un prompt, múltiples outputs** → Estructura con secciones numeradas
2. **Siempre incluir formato de tabla** → Fácil de parsear después
3. **Incluir fallback** → "Si no X, entonces Y"
4. **Pedir confianza** → Forzar calibración
5. **Limitar output** → Evita respuestas interminables

---

## Combinaciones Probadas

| Tarea | Combinar prompts # |
|-------|-------------------|
| PR review | 12 + 14 + 32 |
| Debug producción | 16 + 18 + 29 |
| Refactor módulo | 13 + 21 + 24 |
| Onboarding a repo | 26 + 30 + 33 |
| Security audit | 17 + 32 + 34 |

---

_Creado: 2026-02-20 - Entrenamiento Opus → Claudio_
_Complementa: ref-one-liners-glm5.md (básicos)_
