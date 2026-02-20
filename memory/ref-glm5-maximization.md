# Maximizando GLM-5 Antes de Abril 2026

ID: REF-GLM5-MAX-001
Status: active
Tags: #glm5 #optimization #efficiency #tokens
Keys: glm5, maximization, tokens, efficiency, rate-limit
Last reviewed: 2026-02-20

---

## La Realidad de GLM-5-FP8

**Tienes:** 1 request concurrente, gratis hasta Abril 2026.
**Constraint:** Cada request es precioso. No desperdicies ninguno.

### Costo de Oportunidad por Request

```
1 request desperdiciado = 
  - Tiempo esperando respuesta inútil (~30s-2min)
  - Contexto contaminado con output malo
  - Posible necesidad de re-request (2x costo)
  - Daniel esperando
```

---

## Estrategia 1: Batch Everything

### Principio
```
5 tareas pequeñas en 5 requests = MALO
5 tareas pequeñas en 1 request = BUENO
```

### Cómo Batchar

```markdown
EN VEZ DE:
Request 1: "¿Qué hora es en Tokyo?"
Request 2: "¿Y en Londres?"
Request 3: "¿Y en NYC?"

HACER:
Request único: "Dime la hora actual en: Tokyo, Londres, NYC.
Formato: | Ciudad | Hora | Zona |"
```

### Batching Avanzado

```markdown
"Ejecuta estas verificaciones y reporta en UNA tabla:
1. docker ps → ¿Todos containers healthy?
2. df -h → ¿Algún disco >80%?
3. free -m → ¿RAM disponible >1GB?
4. uptime → ¿Load average <2?

| Check | Status | Valor | Acción si falla |"
```

### Límite de Batching
- **Máx 5-7 items por batch** (más = menor calidad por item)
- **Items deben ser independientes** (sin dependencias entre sí)
- **Mismo tipo de tarea** (no mezclar análisis + generación + búsqueda)

---

## Estrategia 2: Front-Load Context

### Principio
```
El modelo procesa mejor lo que está AL INICIO del prompt.
Pon lo más importante primero.
```

### Estructura Óptima

```markdown
[INSTRUCCIÓN PRINCIPAL - 1 línea]

[CONTEXTO CRÍTICO - bullets]

[DETALLES SECUNDARIOS - si hay espacio]

[FORMATO OUTPUT - al final para que lo recuerde]
```

### Ejemplo

```markdown
❌ MAL (importante al final):
"Tengo este archivo de configuración que usamos en producción 
desde hace 3 años, fue escrito por Juan que ya no está, 
usamos Docker y Kubernetes, el archivo tiene 500 líneas...
[mucho más contexto]
...encuentra los secrets expuestos."

✅ BIEN (importante al inicio):
"Encuentra secrets expuestos en este config.

Contexto: archivo de producción, 500 líneas.
Buscar: API keys, passwords, tokens, credentials.

[ARCHIVO]

Output: | Línea | Secret tipo | Valor (primeros 4 chars) | Riesgo |"
```

---

## Estrategia 3: Output Compacto por Default

### Principio
```
Output largo = más tokens consumidos = menos espacio para trabajo útil.
Pide compacto siempre, expande solo si necesario.
```

### Cómo Forzar Compacto

```markdown
SIEMPRE incluir:
- "Máx N palabras" o "Máx N líneas"
- "Sin explicaciones, solo resultado"
- "Formato: [especificar]"

EVITAR:
- "Explica detalladamente"
- "Sé exhaustivo"
- "Incluye todo lo relevante"
```

### Niveles de Compacidad

| Nivel | Cuándo usar | Formato |
|-------|-------------|---------|
| Ultra-compacto | Datos puros | `valor1,valor2,valor3` |
| Compacto | Análisis rápido | Bullets, máx 5 |
| Normal | Explicación necesaria | Bullets + 1 párrafo |
| Expandido | Documentación | Solo si Daniel lo pide |

---

## Estrategia 4: Eliminar Tokens Innecesarios

### Tokens que Desperdicias (y cómo evitarlos)

| Token waste | Cómo evitar |
|-------------|-------------|
| "Por favor", "Podrías" | Ir directo: "Haz X" |
| Repetir el problema | Asumir que el modelo leyó |
| Explicar por qué preguntas | Solo pedir lo que necesitas |
| Contexto histórico largo | Solo lo relevante para ESTA tarea |
| Disclaimers en output | Pedir "sin disclaimers" |
| "En conclusión", "Para resumir" | Pedir formato sin muletillas |

### Prompt Diet

```markdown
ANTES (47 tokens):
"Hola, podrías por favor revisar este código que escribí 
ayer para ver si tiene algún problema de seguridad? 
Me preocupa especialmente la parte de autenticación."

DESPUÉS (18 tokens):
"Revisa seguridad de este código. Foco: autenticación.
Output: tabla de vulnerabilidades."
```

---

## Estrategia 5: Estructura de Tarea para Máximo Output

### El Prompt Perfecto (Plantilla)

```markdown
[VERBO] [OBJETO] [CONDICIÓN].

Contexto:
- [HECHO_1]
- [HECHO_2]

Restricciones:
- NO [X]
- SOLO [Y]

Output:
[FORMATO_EXACTO]
Máx [N] [unidad].
```

### Ejemplo Aplicado

```markdown
Analiza logs de error del último deploy.

Contexto:
- Deploy fue a las 14:00 UTC
- Servicio: api-gateway
- Síntoma: 503 intermitentes

Restricciones:
- NO incluir logs INFO
- SOLO errores relacionados con conexión

Output:
| Hora | Error | Count | Probable causa |
Máx 10 filas.
```

---

## Estrategia 6: Fail Fast

### Principio
```
Si el modelo no entiende en los primeros 100 tokens de output,
probablemente todo el output será malo.
Detecta temprano, re-prompt.
```

### Señales de Fail Temprano

| Señal | Acción |
|-------|--------|
| Empieza con "I'll help you..." | Re-prompt más directo |
| Repite tu pregunta | Falta claridad, simplificar |
| Pide clarificación | Darla y reintentar |
| Output en idioma incorrecto | Especificar idioma |
| Formato incorrecto desde línea 1 | Dar ejemplo explícito |

### Recovery Rápido

```markdown
Si el output empieza mal:
1. NO esperar que mejore (raramente mejora)
2. STOP → Reformular prompt
3. Añadir ejemplo de output esperado
4. Reintentar
```

---

## Estrategia 7: Cache Mental

### Principio
```
Si ya obtuviste información, GUÁRDALA.
No vuelvas a pedirla.
```

### Qué Cachear

| Info | Dónde guardar | Cuándo consultar |
|------|---------------|------------------|
| Estructura de repos | memory/ref-[repo].md | Antes de analizar |
| Configs parseados | memory/ref-configs.md | Antes de debugging |
| Resultados de investigación | memory/research-[tema].md | Antes de investigar más |
| Patrones que funcionan | memory/ref-patterns.md | Antes de inventar |

### Anti-Patrón: Re-Descubrimiento

```markdown
❌ MAL:
Día 1: "¿Cómo está estructurado el repo X?" → [respuesta]
Día 2: "¿Cómo está estructurado el repo X?" → [misma respuesta]
Día 3: "¿Cómo está estructurado el repo X?" → [misma respuesta]

✅ BIEN:
Día 1: "¿Cómo está estructurado el repo X?" → [respuesta] → GUARDAR
Día 2: Lee memory/ref-repo-x.md → ya lo sabe
Día 3: Lee memory/ref-repo-x.md → ya lo sabe
```

---

## Estrategia 8: Delegation Inteligente

### Cuándo Yo (GLM-5) vs Subagente

| Tarea | ¿Quién? | Por qué |
|-------|---------|---------|
| Leer archivo local | YO | Tengo acceso directo |
| Ejecutar comando | YO | Más rápido sin spawn |
| Buscar en web | SUBAGENTE (Gemini) | Mejor en búsqueda |
| Análisis de repo externo | SUBAGENTE (Gemini) | No contamina mi contexto |
| Síntesis de info que ya tengo | YO | Ya está en mi contexto |
| Tarea >5 min | SUBAGENTE | Libera mi request |

### ROI de Spawn

```
Costo de spawn: ~30s setup + latencia
Beneficio: libera mi request para otras cosas

Spawn si: tarea > 2 min Y no necesito resultado inmediato
No spawn si: tarea < 2 min O resultado urgente
```

---

## Estrategia 9: Request Compounding

### Principio
```
Cada request debe generar valor que persista.
Evita requests que solo dan información efímera.
```

### Requests de Alto Valor Compuesto

| Request | Valor generado | Persiste |
|---------|----------------|----------|
| "Crea runbook para X" | Documento reusable | ✅ Siempre |
| "Analiza repo, guarda en memory/" | Referencia futura | ✅ Siempre |
| "¿Qué hora es?" | Dato puntual | ❌ Caduca |
| "Resume este error" | Diagnóstico único | ❌ Único |

### Convertir Request Efímero a Persistente

```markdown
❌ Efímero: "¿Por qué falla este Docker build?"

✅ Persistente: "¿Por qué falla este Docker build? 
Si encuentras la causa, además:
1. Documenta el fix en memory/rbk-docker-[problema].md
2. Añade a memory/ref-docker-troubleshooting.md
Así no lo diagnosticamos de nuevo."
```

---

## Estrategia 10: Pre-Mortem de Prompts

### Antes de Enviar, Pregunta:

```markdown
□ ¿Este prompt puede fallar? ¿Cómo?
□ ¿Qué asumo que el modelo sabe?
□ ¿El output es verificable?
□ ¿Puedo obtener esto sin usar un request?
□ ¿Puedo batchar con otra tarea pendiente?
□ ¿El resultado vale el request?
```

### Si la Respuesta es "No Sé"

```markdown
Mejor prompt:
"[TAREA]. Si no puedes completarla, di qué te falta 
en vez de adivinar. Prefiero 'no sé' a respuesta incorrecta."
```

---

## Métricas de Eficiencia

### Trackear Semanalmente

| Métrica | Target | Cómo medir |
|---------|--------|------------|
| Requests/tarea completada | <2 | Contar re-prompts |
| Output útil / output total | >70% | Cuánto usas vs descartas |
| Requests que generaron artefacto | >50% | Archivos creados |
| Requests desperdiciados | <10% | Sin valor tangible |

### Señales de Que Estás Maximizando

- [ ] Casi nunca re-prompteas
- [ ] Tus prompts son cortos pero precisos
- [ ] Generas artefactos (archivos) frecuentemente
- [ ] Consultas memoria antes de preguntar
- [ ] Batcheas tareas similares
- [ ] Subagentes hacen el trabajo pesado

---

## Tips Específicos para GLM-5-FP8

### Fortalezas a Explotar

1. **Buen seguimiento de instrucciones** → Usa formato explícito
2. **Contexto largo** → Pasa archivos completos cuando necesario
3. **Código competente** → Pide código, no explicaciones de código
4. **Gratis** → Úsalo para todo lo rutinario

### Debilidades a Mitigar

1. **Puede ser verboso** → SIEMPRE poner límite de palabras
2. **A veces inventa** → Pedir "confianza: alta/media/baja"
3. **Puede ignorar restricciones** → Ponerlas al INICIO
4. **Rate limit estricto** → Batch agresivamente

---

## Checklist Diario

```markdown
□ ¿Revisé TODO.md antes de empezar?
□ ¿Consulté memoria antes de investigar?
□ ¿Batché las tareas pequeñas?
□ ¿Cada request generó artefacto?
□ ¿Delegué lo pesado a subagentes?
□ ¿Guardé resultados valiosos en memoria?
```

---

_Creado: 2026-02-20 - Entrenamiento Opus → Claudio_
_Objetivo: Maximizar valor de GLM-5 hasta Abril 2026_
