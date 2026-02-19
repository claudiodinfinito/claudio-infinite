# Checklist Diario (22:00 UTC)

ID: REF-DAILY-001
Tags: #daily #checklist #routine
Keys: daily, checklist, routine, maintenance
Last reviewed: 2026-02-19

---

## Tareas del Cronjob Diario

| # | Tarea | Comando/Archivo |
|---|-------|-----------------|
| 1 | Actualizar daily log | `memory/YYYY-MM-DD.md` |
| 2 | Revisar TODO.md | `TODO.md` |
| 3 | Verificar uso APIs | `memory/brave-usage.json` |
| 4 | Git commit pendientes | `git status --short` |
| 5 | Health check rápido | Ver umbrales abajo |

---

## Umbrales de Alerta

| Métrica | OK | Warning | Crítico |
|---------|-----|---------|---------|
| Disco | >50GB | 20-50GB | <20GB |
| RAM | >4GB | 2-4GB | <2GB |
| Brave API | <500 | 500-1000 | >1000 |

---

## Formato Daily Log

```markdown
## [HH:MM] UTC - [Título]

- **Acción:** qué se hizo
- **Resultado:** output
- **Commit:** hash

---
```

---

_Creado: 2026-02-19 - Checklist diario 22:00_
