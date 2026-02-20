# Template: Daily Synthesis

**Propósito:** Template para generar síntesis diaria automática.
**Frecuencia:** Diaria 22:00 UTC (cronjob).

---

## Template

```markdown
# Síntesis: [YYYY-MM-DD] - [DÍA SEMANA]

## 📊 Métricas

| Métrica | Valor |
|---------|-------|
| **Commits** | [N] |
| **Archivos creados** | [N] |
| **Archivos modificados** | [N] |
| **Duración activa** | [X]h |

## ✅ Completado

### Documentación

- [Archivo 1] — [descripción breve]
- [Archivo 2] — [descripción breve]

### Sistema

- [Tarea 1]
- [Tarea 2]

### Investigación

- [Tema 1] → [resultado]

## 📝 Lecciones

1. [Lección aprendida 1]
2. [Lección aprendida 2]

## 🔄 Cambios de Comportamiento

- [Cambio 1]

## 📈 Progreso TODO

- Items cubiertos: [N]
- Items pendientes: [N]

## 🔮 Mañana

1. [Prioridad 1]
2. [Prioridad 2]

---

_Generado: [HH:MM UTC]_
```

---

## Prompt para Subagente

```
[DAILY SYNTHESIS GENERATOR]

Fecha: [FECHA]
Commits hoy: git log --oneline --since="midnight"
Archivos creados: git ls-files --others --exclude-standard

Genera síntesis con:
1. Métricas (commits, archivos, duración)
2. Completado (docs, sistema, investigación)
3. Lecciones aprendidas
4. Cambios de comportamiento
5. Progreso TODO
6. Prioridades mañana

Formato: Markdown con el template.
```

---

## Implementación

### Cronjob actual (22:00 UTC)

```bash
openclaw cron list | grep daily-log
```

### Mejora propuesta

```javascript
sessions_spawn({
  label: "DAILY-SYNTHESIS",
  model: "google/gemini-3-flash-preview",
  task: `[DAILY SYNTHESIS GENERATOR]

Genera síntesis para [FECHA] con:
- Commits: $(git log --oneline --since="midnight" | wc -l)
- Archivos: $(git ls-files -m | wc -l)

Output: markdown con template.`,
  runTimeoutSeconds: 120
})
```

---

## Campos Calculados

| Campo | Comando |
|-------|---------|
| Commits | `git log --oneline --since="midnight" \| wc -l` |
| Archivos creados | `git ls-files -o --exclude-standard \| wc -l` |
| Archivos modificados | `git diff --name-only HEAD@{midnight} \| wc -l` |
| Líneas añadidas | `git diff --shortstat HEAD@{midnight}` |

---

## Checklist de Contenido

- [ ] Métricas precisas
- [ ] Completado con archivos específicos
- [ ] Lecciones提炼adas
- [ ] Cambios de comportamiento identificados
- [ ] Prioridades claras para mañana

---

_Creado: 2026-02-20 21:01 UTC - Micro-tarea autónoma_
