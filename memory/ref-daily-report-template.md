# Daily Report Template (Para Daniel)

**Propósito:** Template de reporte diario cuando Claudio trabaja en modo autónomo.
**Frecuencia:** Cada mañana o cuando Daniel regresa después de STILL.

---

## Template

```
🦉 REPORT: [YYYY-MM-DD] - [DÍA SEMANA]

## ⏱️ Tiempo
- **Sesión:** [HH:MM] - [HH:MM] UTC ([X] horas)
- **Commits:** [X]
- **Archivos creados:** [X]

## ✅ Completado
1. [Tarea 1] → [Artefacto/Resultado]
2. [Tarea 2] → [Artefacto/Resultado]
3. [Tarea 3] → [Artefacto/Resultado]

## 📊 Sistema
| Métrica | Valor | Estado |
|---------|-------|--------|
| Containers | X UP | ✅/⚠️ |
| Disco | X GB libres | ✅/⚠️ |
| RAM | X GB disponibles | ✅/⚠️ |
| APIs | X/Y usadas | ✅/⚠️ |

## 🚨 Pendientes
1. [Pendiente 1] - [Por qué está pendiente]
2. [Pendiente 2] - [Por qué está pendiente]

## 💡 Sugerencias
- [Sugerencia 1]
- [Sugerencia 2]

## ❓ Preguntas para Daniel
- [Pregunta 1]
- [Pregunta 2]

---
_Reporte generado: [HH:MM UTC]_
```

---

## Ejemplo Real (2026-02-20 Nocturna)

```
🦉 REPORT: 2026-02-20 - Jueves (Sesión Nocturna)

## ⏱️ Tiempo
- **Sesión:** 00:00 - 05:55 UTC (5h 55min)
- **Commits:** 55
- **Archivos creados:** 18

## ✅ Completado
1. Documentar Claude features → caching, thinking, MCP refs
2. Plan B GLM-5 → DeepSeek + Ollama refs + decision tree
3. Business frameworks → RevOps + n8n workflows
4. Google Leak → SEO checklist para clientes
5. Sistema → 3 runbooks + 6 refs operativas
6. Glosario → 24 términos (+6 nuevos)

## 📊 Sistema
| Métrica | Valor | Estado |
|---------|-------|--------|
| Containers | 8 UP | ✅ OK |
| Disco | 93 GB libres | ✅ OK |
| RAM | 5.5 GB disponibles | ✅ OK |
| Brave API | 2/1,500 | ✅ OK |

## 🚨 Pendientes
1. Git remote URL - Sin push possible hasta tener URL
2. Cronjobs con error - 2 jobs en error (rate limit GLM-5)
3. Ollama testing - Verificar qué modelo corre en container

## 💡 Sugerencias
- Mover cronjobs GLM-5 a Gemini para evitar rate limit
- Configurar git remote cuando tengas URL
- Testear DeepSeek como plan B para Abril

## ❓ Preguntas para Daniel
- ¿Qué cliente primero para RevOps?
- ¿Tienes URL para git remote?
- ¿Quieres que profundice en Google Leak?

---
_Reporte generado: 05:55 UTC_
```

---

## Cuándo Usar

| Situación | Acción |
|-----------|--------|
| **STILL > 30 min** | Generar reporte al volver Daniel |
| **Sesión nocturna** | Reporte al finalizar |
| **Trabajo autónomo > 1h** | Reporte resumido |

---

## Cómo Generar

1. Leer `memory/YYYY-MM-DD.md` para resumen del día
2. Ejecutar health checks: `docker ps`, `df -h`, `free -h`
3. Verificar commits: `git log --oneline -20`
4. Compilar en template
5. Enviar a Daniel

---

_Creado: 2026-02-20 05:57 UTC - Micro-tarea autónoma_
