# Spec: Automated Code Review

**Propósito:** Sistema de code review automático usando subagentes.
**Fuente:** Item #92 de ref-interests-real-100.md

---

## Concepto

Usar subagentes para revisar código antes de commits o en PRs.

---

## Flujo

```
Código nuevo/modify
    ↓
Spawn subagente (Gemini)
    ↓
Review: calidad, seguridad, optimización
    ↓
Reporte con sugerencias
    ↓
Decidir: aplicar, ignorar, preguntar
```

---

## Criterios de Review

| Categoría | Qué revisar |
|-----------|-------------|
| **Calidad** | Nombres claros, funciones pequeñas, DRY |
| **Seguridad** | Sin secrets hardcodeados, input validation |
| **Performance** | Sin loops innecesarios, queries optimizadas |
| **Estilo** | Consistencia, formateo |
| **Tests** | Cobertura, casos edge |

---

## Template de Prompt

```
Eres un code reviewer experto. Revisa este código:

[CÓDIGO]

Evalúa:
1. Calidad (1-10)
2. Problemas de seguridad
3. Sugerencias de optimización
4. Mejoras de legibilidad

Output: Bullet points con líneas específicas.
```

---

## Implementación con Subagente

```javascript
sessions_spawn({
  label: "CODE-REVIEW",
  model: "google/gemini-3-flash-preview",
  task: `[CODE REVIEWER] Revisa este código:
  
${codigo}
  
Evalúa: calidad, seguridad, performance, estilo.
Output: bullets con líneas específicas.`,
  runTimeoutSeconds: 120
})
```

---

## Output Esperado

```markdown
## Code Review: [archivo]

**Score:** 8/10

**Issues:**
- Línea 23: Variable no usada `temp`
- Línea 45: Posible SQL injection, usar prepared statements

**Sugerencias:**
- Línea 12: Extraer a función `validateInput()`
- Línea 67: Usar `const` en lugar de `let`

**Seguridad:** ✅ OK (después de fix SQL injection)
```

---

## Cuándo Usar

| Situación | Acción |
|-----------|--------|
| Nuevo archivo creado | Review automático |
| Commit > 100 líneas | Review antes de push |
| Código complejo | Review siempre |
| Código simple | Skip (desperdicia tokens) |

---

## Costo-Beneficio

| Ventaja | Desventaja |
|---------|------------|
| Detecta bugs temprano | Consume tokens |
| Mejora calidad | Puede ser ruidoso |
| Aprendizaje continuo | No reemplaza humano |

---

## En OpenClaw

- Integrar en workflow de commits
- Trigger: archivos nuevos > 50 líneas
- Model: Gemini 3 Flash (bueno para análisis)

---

_Creado: 2026-02-20 19:51 UTC - Micro-tarea autónoma_
