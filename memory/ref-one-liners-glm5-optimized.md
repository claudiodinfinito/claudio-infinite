# One-Liners Optimizados para GLM-5

ID: REF-ONELINERS-GLM5-001
Status: active
Tags: #one-liners #glm5 #prompts #optimization
Keys: one-liners, glm5, prompts, optimization

---

## Principio Clave

**GLM-5 = Herramienta de precisión.**

Dame: **archivo + tarea + output** → Entrego valor rápido.
Dame: **ambigüedad** → Te devuelvo confusión.

---

## Estructura que Funciona

```
[ROL] + [TAREA ESPECÍFICA] + [FORMATO OUTPUT]
```

---

## 10 One-Liners Probados

| # | One-Liner | Por qué funciona |
|---|-----------|------------------|
| 1 | "Lee memory/index.md y lista las 5 tareas más urgentes" | Archivo explícito + output claro |
| 2 | "Ejecuta docker stats --no-stream y di cuál contenedor consume más" | Comando directo + output definido |
| 3 | "Resume este texto en 3 bullets accionables, máx 80 palabras" | Formato + límite |
| 4 | "Busca 'error' en memory/ y resume los 3 más críticos" | Búsqueda dirigida + síntesis |
| 5 | "Convierte config.json a variables de entorno, formato .env" | Transformación + output explícito |
| 6 | "Experto Python: reescribe función para eficiencia. Output: código + 1 línea" | Rol + tarea + formato |
| 7 | "Eres DBA: problema en este SQL, da fix en 2 líneas" | Rol experto + output corto |
| 8 | "Lee últimos 50 logs y clasifica: ERROR/WARN/INFO" | Clasificación + estructura |
| 9 | "Genera 5 subject lines para [producto], lista numerada" | Cantidad + formato |
| 10 | "Traduce a inglés técnico, preserva términos código" | Instrucción de preservación |

---

## Patrones que Funcionan

| Patrón | Ejemplo |
|--------|---------|
| **Archivo explícito** | "Lee memory/index.md..." |
| **Output definido** | "...en 3 bullets" |
| **Límite claro** | "...máx 80 palabras" |
| **Rol experto** | "Eres DBA..." |
| **Comando directo** | "Ejecuta docker ps..." |

---

## Qué EVITAR con GLM-5

| ❌ No funciona | ✅ Alternativa |
|----------------|----------------|
| "Piensa en cómo mejorar el sistema" | "Mejora index.md: añade 3 archivos faltantes" |
| "Analiza profundamente este código" | "Lee archivo X y lista 3 problemas" |
| "Sé creativo" | "Genera 5 opciones para Y" |
| "¿Qué opinas?" | "Dime 2 pros y 2 contras" |
| "Investiga X" | "Busca X en web y resume en 5 bullets" |

---

## Diferencias Claude vs GLM-5

| Aspecto | Claude | GLM-5 |
|---------|--------|-------|
| Matices | Tolera ambigüedad | Necesita concreción |
| Prompts vagos | Funciona | Falla |
| Velocidad | Medio | Rápido en tareas atómicas |
| Meta-reflexión | Sí | Menos |

---

## Uso en Micro-Tareas

Cuando hago micro-tareas autónomas:

```
1. Leo archivo específico (ej: index.md)
2. Identifico gap (ej: archivo faltante)
3. Añado entrada
4. Commit
```

**Sin ambigüedad, sin pasos extra.**

---

_Creado: 2026-02-20 - Basado en análisis comparativo Claude vs GLM-5_
