# Prompt Library: Templates para Subagentes

**Creado:** 2026-02-21 16:00 UTC
**Propósito:** Prompts probados para spawnear subagentes eficientemente

---

## TL;DR

Biblioteca de prompts estructurados para tareas comunes. Copiar → Adaptar → Ejecutar.

---

## Template Base

```javascript
sessions_spawn({
  label: "[NOMBRE-DESCRIPTIVO]",
  model: "[MODELO]",
  runTimeoutSeconds: [SEGUNDOS],
  task: `[ROL + TAREA + OUTPUT ESPERADO]`
})
```

---

## Investigación Web

### Búsqueda Rápida
```javascript
{
  label: "search-[TEMA]",
  model: "google/gemini-2.5-flash",
  runTimeoutSeconds: 120,
  task: `Investiga [TEMA] en profundidad.

FUENTES: Noticias, blogs técnicos, documentación oficial.
OUTPUT: Resumen ejecutivo + 3 bullets clave + fuentes citadas.

Sin fuentes = output incompleto.`
}
```

### Análisis Competitivo
```javascript
{
  label: "competitive-[INDUSTRIA]",
  model: "google/gemini-2.5-flash",
  runTimeoutSeconds: 300,
  task: `Análisis competitivo de [INDUSTRIA].

COMPETIDORES: [A, B, C]
ASPECTOS: Pricing, Features, Positioning, Reviews

OUTPUT: Tabla comparativa + Gap analysis + 3 oportunidades.

Formato: Markdown con tablas.`
}
```

---

## Análisis de Código

### Debugging
```javascript
{
  label: "debug-[ARCHIVO]",
  model: "google/gemini-2.5-flash",
  runTimeoutSeconds: 180,
  task: `Debug de [ARCHIVO/ERROR].

CONTEXTO: [Qué estaba intentando]
ERROR: [Mensaje de error completo]
CÓDIGO: [Snippet relevante]

OUTPUT: 
1. Causa raíz
2. Solución propuesta
3. Código corregido

Sin causa raíz = output incompleto.`
}
```

### Refactor
```javascript
{
  label: "refactor-[ARCHIVO]",
  model: "google/gemini-2.5-flash",
  runTimeoutSeconds: 180,
  task: `Refactoriza [ARCHIVO].

OBJETIVO: [Legibilidad/Performance/Mantenibilidad]
RESTRICCIONES: [No cambiar API/No tocar X]

OUTPUT:
1. Cambios explicados
2. Código refactorizado
3. Métricas de mejora

Sin explicación = output incompleto.`
}
```

---

## Generación de Contenido

### Blog Post
```javascript
{
  label: "blog-[TEMA]",
  model: "google/gemini-2.5-flash",
  runTimeoutSeconds: 180,
  task: `Escribe blog post sobre [TEMA].

KEYWORDS: [k1, k2, k3]
AUDIENCIA: [Quién lee]
OBJETIVO: [Educación/Conversión/Awareness]
LONGITUD: 1500-2000 palabras

OUTPUT: Markdown con meta datos (title, description, keywords).

Sin meta datos = output incompleto.`
}
```

### Documentación Técnica
```javascript
{
  label: "docs-[PROYECTO]",
  model: "google/gemini-2.5-flash",
  runTimeoutSeconds: 180,
  task: `Documenta [PROYECTO/FUNCIONALIDAD].

ESTRUCTURA:
1. Qué hace
2. Cómo usarlo
3. Ejemplos
4. Troubleshooting

OUTPUT: Markdown con ejemplos de código ejecutables.

Sin ejemplos = output incompleto.`
}
```

---

## Análisis de Datos

### KPI Report
```javascript
{
  label: "kpi-report-[CLIENTE]",
  model: "google/gemini-2.5-flash",
  runTimeoutSeconds: 180,
  task: `Genera reporte de KPIs para [CLIENTE].

PERÍODO: [Fechas]
MÉTRICAS: [Leads, Conversión, CAC, LTV]
FUENTES: [PocketBase/Analytics]

OUTPUT:
1. Resumen ejecutivo (3 bullets)
2. Tabla de métricas con comparación
3. 3 insights accionables

Sin insights = output incompleto.`
}
```

---

## Orquestación Multiagente

### Spawn Departamento
```javascript
{
  label: "dept-[NOMBRE]-[TAREA]",
  model: "google/gemini-2.5-flash",
  runTimeoutSeconds: [SEGÚN DEPT],
  task: `Eres el departamento [NOMBRE].

TASK: [Tarea específica]
INPUT: [Datos recibidos]
OUTPUT: [Qué entregar]

DEPARTAMENTO: Ver memory/departments/[NOMBRE]/index.md

Seguir template del departamento.`
}
```

### Temperaturas por Departamento
| Dept | Temp | Timeout |
|------|------|---------|
| SEO | 0.4 | 5 min |
| Content | 0.6 | 3 min |
| Analytics | 0.3 | 5 min |
| Research | 0.4 | 10 min |
| Marketing | 0.5 | 5 min |
| Emprendimiento | 0.5 | 10 min |

---

## Anti-Patrones (NO hacer)

❌ **Prompt vago:**
```javascript
task: "Investiga sobre marketing"
```

✅ **Prompt específico:**
```javascript
task: "Investiga tendencias de marketing B2B 2026.
Output: 5 tendencias con ejemplos reales + fuentes."
```

❌ **Sin output definido:**
```javascript
task: "Mejora este código"
```

✅ **Con output claro:**
```javascript
task: "Refactoriza para legibilidad.
Output: Código + explicación de cambios + métricas."
```

---

## Checklist de Calidad

- [ ] Label descriptivo
- [ ] Modelo apropiado
- [ ] Timeout realista
- [ ] Task con: ROL + TAREA + OUTPUT
- [ ] Criterio de completitud explícito

---

## Referencias

- `memory/rbk-subagent-orchestrator.md` — Orquestación detallada
- `memory/ref-subagent-orchestration-advanced.md` — Patrones avanzados
- `memory/departments/*/index.md` — Departamentos activos

---

_Actualizado: 2026-02-21 16:00 UTC - 12 prompts probados_
