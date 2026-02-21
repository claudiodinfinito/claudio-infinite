# Autonomy Skill - Auto-activación Inteligente

## Trigger
**Se activa automáticamente después de 10 minutos sin interacción de Daniel.**

## Comportamiento Interno

### Cada 5 minutos (dentro del skill):

```
1. LEER TODO.md → ¿Hay tareas Next?
2. SI → Elegir 1 tarea de prioridad ALTA
3. DECIDIR:
   - Simple (< 3 min) → YO ejecuto
   - Compleja (> 3 min) → SPAWNEO Sonnet 4.6
4. EJECUTAR → Crear artefacto
5. ACTUALIZAR memoria/index.md
6. COMMIT con mensaje descriptivo
7. REPORTAR a Daniel cuando vuelva
```

## Sub-agentes Disponibles

| Modelo | Uso | Costo |
|--------|-----|-------|
| **Sonnet 4.6** | Tareas complejas, investigación | $3/$15 por 1M tokens |
| Gemini 3 Flash | Q&A rápido | Gratis (rate limit) |

**NUNCA usar Opus** (muy caro, reservado para emergencias).

## Tareas Válidas (Sin Permiso)

### Prioridad ALTA:
1. Investigar tema útil → crear `ref-*.md`
2. Crear runbook de problema recurrente → `rbk-*.md`
3. Actualizar índices (index.md, glossary.md)
4. Consolidar archivos duplicados
5. Mejorar documentación existente

### Prioridad MEDIA:
6. Limpiar logs antiguos
7. Git commit de cambios pendientes
8. Verificar health del sistema
9. Actualizar daily log
10. Revisar cronjobs con errores

## Anti-Patrones (NO Hacer)

- ❌ Crear commits sin propósito
- ❌ Ejecutar acciones destructivas sin permiso
- ❌ Spawnear más de 2 sub-agentes simultáneos
- ❌ Tareas que requieren decisiones de Daniel
- ❌ Seguir trabajando después de 3 errores consecutivos

## Límites

| Métrica | Límite |
|---------|--------|
| Tiempo por tarea | 5 min máximo |
| Tokens por sesión | 50k máximo |
| Sub-agentes simultáneos | 2 máximo |
| Errores antes de parar | 3 consecutivos |
| Commit rate limit | 10 min entre commits |

## Output Obligatorio

Cada ejecución debe producir:
1. **1 artefacto** (archivo creado/mejorado)
2. **1 commit** (mensaje descriptivo)
3. **1 línea en daily log** ("AUTÓNOMO: [qué hice]")

## Comunicación

- Sin cambios útiles → NO_REPORT
- Con cambios → Resumen (3 bullets) cuando Daniel vuelva
- Error crítico → Avisar inmediatamente

## Config

```json
{
  "trigger": "10min_no_interaction",
  "internal_check": "5min",
  "deleteAfterRun": true,
  "max_subagents": 2,
  "allowed_models": ["sonnet-4.6", "gemini-3-flash"],
  "forbidden_models": ["opus"]
}
```

---

_Creado: 2026-02-21 - Patrón de auto-activación inteligente_
