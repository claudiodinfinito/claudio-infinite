# One-Liners Óptimos para GLM-5

ID: REF-ONELINERS-001
Status: active
Tags: #prompts #optimization #one-liners #glm5
Keys: one-liners, prompts, glm5, optimization, efficiency
Last reviewed: 2026-02-19

---

## Principio Fundamental

**GLM-5 = Herramienta de precisión.**

| Input | Output |
|-------|--------|
| Específico + Archivo + Formato | Valor rápido |
| Vago + Ambiguo | Confusión |

---

## Estructura Ganadora

```
[ROL] + [TAREA ESPECÍFICA] + [FORMATO OUTPUT]
```

---

## 10 One-Liners Probados

### Tareas Locales (archivo/comando explícito)

```
1. "Lee memory/index.md y lista las 5 tareas más urgentes"

2. "Ejecuta docker stats --no-stream y di cuál contenedor consume más"

3. "Busca 'error' en memory/ y resume los 3 más críticos en bullets"

4. "Lee últimos 50 logs de /tmp/openclaw/ y clasifica: ERROR/WARN/INFO"

5. "Convierte config.json a variables .env, formato KEY=VALUE"
```

### Síntesis y Transformación

```
6. "Resume este texto en 3 bullets accionables, máx 80 palabras"

7. "Extrae todos los IDs de este JSON y lista en formato CSV"

8. "Convierte esta tabla markdown a formato YAML"
```

### Con Rol Experto

```
9. "Eres DBA: problema en este SQL, da fix en 2 líneas máximo"

10. "Experto Python: reescribe función para eficiencia. Output: código + 1 línea explicación"
```

---

## Qué EVITAR

| ❌ Prompt vago | ✅ Alternativa específica |
|----------------|---------------------------|
| "Piensa cómo mejorar" | "Lista 3 mejoras concretas para X" |
| "Analiza esto" | "Identifica 2 problemas y da fixes" |
| "Sé creativo" | "Genera 5 opciones en formato lista" |
| "Explica bien" | "Explica en 3 bullets máx 50 palabras" |

---

## Patrones por Tipo de Tarea

### Lectura/Extracción
```
"Lee [ARCHIVO] y [ACCIÓN] en [FORMATO]"
```

### Ejecución/Análisis
```
"Ejecuta [COMANDO] y [ANÁLISIS] en [FORMATO]"
```

### Síntesis
```
"Resume [CONTEXTO] en [N] bullets, máx [X] palabras"
```

### Transformación
```
"Convierte [INPUT] a [OUTPUT], formato [ESPECÍFICO]"
```

---

## Reglas de Oro

1. **Siempre archivo específico** → No "un archivo", sino "memory/index.md"
2. **Siempre formato definido** → No "explica", sino "3 bullets"
3. **Siempre límite claro** → "máx X palabras/líneas"
4. **Rol cuando aplica** → "Eres [EXPERT]: ..." para tareas técnicas

---

## Uso en Sistema Autónomo

Cuando el cronjob de 5 min dispare una tarea, usar estos one-liners para máxima eficiencia.

**Ejemplo de tarea autónoma:**
```
Cronjob: "Lee memory/index.md y verifica si falta algún archivo"
One-liner aplicado: "Lee memory/index.md, compara con ls memory/*.md, lista faltantes en bullets"
```

---

_Creado: 2026-02-19 - Optimización de prompts para autonomía_
