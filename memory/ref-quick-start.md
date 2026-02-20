# Quick Start - Operaciones Comunes

ID: REF-QUICKSTART-001
Tags: #quickstart #reference #commands #daily
Keys: quickstart, commands, daily, reference, operations
Last reviewed: 2026-02-20

---

## Diagnóstico Rápido (30 seg)

```bash
# Estado general
openclaw gateway status && docker ps --format "table {{.Names}}\t{{.Status}}" | head -5
```

---

## Referencias por Situación

| Situación | Archivo | Acción |
|-----------|---------|--------|
| Algo falló | `ref-troubleshooting-decision-tree.md` | Ver síntoma → archivo |
| Error conocido | `ref-common-errors.md` | Buscar solución |
| Limpiar sistema | `ref-cleanup-patterns.md` | Ejecutar checklist |
| Ver uso APIs | `ref-api-usage-tracking.md` | Check límites |
| Hacer commit | `ref-commit-conventions.md` | Formato correcto |
| Manejar secrets | `ref-environment-variables.md` | Seguridad |
| Diagnóstico profundo | `ref-quick-diagnostics.md` | 30s/2min/5min |

---

## Comandos Esenciales

### Gateway
```bash
openclaw gateway status          # Estado
systemctl --user restart openclaw-gateway  # Reiniciar
```

### Docker
```bash
docker ps --format "table {{.Names}}\t{{.Status}}"  # Containers
docker logs -f <name>            # Ver logs
docker restart <name>            # Reiniciar
```

### Git
```bash
git status --short               # Estado
git add -A && git commit -m "..."  # Commit
git log --oneline -5             # Últimos commits
```

### Cronjobs
```bash
openclaw cron list               # Listar
openclaw cron run <job-id>       # Ejecutar manual
```

---

## APIs - Límites Rápidos

| API | Límite | Estado OK si |
|-----|--------|--------------|
| GLM-5 | 1 concurrente | <1 activo |
| Gemini | 20/día | <15 usadas |
| Brave | 1,500/mes | <1,200 usadas |

---

## Archivos Críticos

| Archivo | Para qué |
|---------|----------|
| `AGENTS.md` | Reglas de operación |
| `HEARTBEAT.md` | Sistema autonomía |
| `TODO.md` | Tareas pendientes |
| `memory/index.md` | Mapa de memoria |
| `memory/glossary.md` | Términos |

---

## Flujo de Micro-Tarea

```
1. Crear archivo ref-*.md
2. Añadir a memory/index.md
3. Commit con formato:
   feat(memory): add <nombre>

   REF-ID: descripción corta
   - Punto 1
   - Punto 2

   Micro-task HH:MM UTC
```

---

## Checklist de Salud

```bash
# Ejecutar cada 6 horas aprox
df -h / | tail -1        # Disco
free -h | grep Mem       # RAM
docker ps | grep -c Up   # Containers up
openclaw gateway status  # Gateway
```

---

_Creado: 2026-02-20 - Micro-task 02:51 UTC_
