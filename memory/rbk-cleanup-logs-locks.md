# RBK-CLEANUP-001 — Limpieza de Logs y Locks

**Propósito:** Mantener el sistema limpio de archivos temporales antiguos.
**Frecuencia:** Semanal (automático) o cuando disco >80%
**Tiempo:** 2 minutos

---

## Comandos de Verificación

```bash
# Logs OpenClaw >30 días
find /tmp/openclaw -name "*.log" -mtime +30 2>/dev/null | wc -l

# Locks huérfanos (>1 día)
find /root/.openclaw -name "*.lock" -mtime +1 2>/dev/null

# Tamaño logs
du -sh /tmp/openclaw 2>/dev/null
```

---

## Comandos de Limpieza

### Logs antiguos (>30 días)
```bash
find /tmp/openclaw -name "*.log" -mtime +30 -delete 2>/dev/null
```

### Locks huérfanos
```bash
find /root/.openclaw -name "*.lock" -mtime +1 -delete 2>/dev/null
```

### Logs Docker antiguos
```bash
docker system prune -f --filter "until=720h"
```

---

## Umbrales de Alerta

| Métrica | OK | Advertencia | Crítico |
|---------|----|-------------|---------|
| Logs >30 días | 0 | 1-10 | >10 |
| Locks huérfanos | 0 | 1-3 | >3 |
| /tmp/openclaw | <50MB | 50-200MB | >200MB |
| Disco usado | <70% | 70-85% | >85% |

---

## Cronjob Semanal

Ya existe en `ref-cronjobs-active.md`:
- Job: `weekly-consolidation`
- Incluye limpieza de logs
- Frecuencia: Domingo 12:00 UTC

---

## Estado Actual (2026-02-21)

| Métrica | Valor | Estado |
|---------|-------|--------|
| Logs >30 días | 0 | ✅ OK |
| Locks huérfanos | 0 | ✅ OK |
| /tmp/openclaw | 19MB | ✅ OK |
| Disco libre | 93GB | ✅ OK |

---

_Creado: 2026-02-21 13:00 UTC — Tarea TODO #12, #13_
