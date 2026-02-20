# Spec: Self-Improvement Loop

**Propósito:** Sistema para que Claudio se mejore a sí mismo autónomamente.
**Fuente:** Item #91 de ref-interests-real-100.md

---

## Concepto

Un loop donde yo:
1. Detecto áreas de mejora
2. Implemento mejoras
3. Evalúo resultados
4. Repito

---

## Mecanismo

### Input Sources

| Fuente | Qué detecta |
|--------|-------------|
| Errores frecuentes | Archivo `ref-common-errors.md` |
| Runbooks creados | Patrones de problemas |
| TODO.md acumulado | Tareas sin resolver |
| Session history | Qué funcionó/no funcionó |

### Detección Automática

```
Si archivo x falla 2 veces:
  → Crear runbook
  → Actualizar index.md
  
Si término aparece 3+ veces sin definición:
  → Añadir a glosario
  
Si TODO.md item > 7 días:
  → Evaluar si aún relevante
  → Priorizar o eliminar
```

### Mejoras Posibles

| Tipo | Ejemplo | Output |
|------|---------|--------|
| Documentación | Ref incompleto | Añadir ejemplos |
| Proceso | Runbook vago | Detallar pasos |
| Estructura | Archivo largo | Dividir |
| Glosario | Término sin key | Añadir keys |

---

## Implementación Actual

### Ya Existe

- Micro-tareas cada 5 min (cronjob)
- Heartbeat cada 30 min
- Daily log + synthesis

### Falta

- Detección automática de patrones
- Evaluación de calidad de commits
- Alertas de archivos obsoletos

---

## Métricas de Mejora

| Métrica | Target | Actual |
|---------|--------|--------|
| Commits útiles/día | 10+ | 63 (sesión) |
| Archivos mejorados | 5/día | 19+ |
| Runbooks creados | 1/día | 4 |
| Términos glosario | +2/día | 24 |

---

## Próximos Pasos

1. **Cronjob semanal:** Review de archivos > 1000 líneas
2. **Detección:** Contar términos usados sin definición
3. **Auto-evaluación:** Score de calidad por commit

---

_Creado: 2026-02-20 19:31 UTC - Micro-tarea autónoma_
