# Patrones de Limpieza del Sistema

ID: REF-CLEANUP-001
Tags: #cleanup #maintenance #vps #storage
Keys: cleanup, maintenance, storage, logs, locks
Last reviewed: 2026-02-20

---

## Checks Diarios (automáticos via cron)

| Qué | Comando check | Comando limpiar | Frecuencia |
|-----|---------------|-----------------|------------|
| Locks huérfanos | `find /tmp -name "*.lock" -mtime +1 \| wc -l` | `find /tmp -name "*.lock" -mtime +1 -delete` | Diario |
| Logs >30 días | `find /tmp -name "*.log" -mtime +30 \| wc -l` | `find /tmp -name "*.log" -mtime +30 -delete` | Diario |
| Temp files | `find /tmp -type f -mtime +7 \| wc -l` | `find /tmp -type f -mtime +7 -delete` | Semanal |

---

## Checks Semanales

| Qué | Comando check | Umbral |
|-----|---------------|--------|
| Disco usado | `df -h / \| tail -1 \| awk '{print $5}'` | >70% = investigar |
| Docker unused | `docker system df` | >5GB = prune |
| Backup files | `find /root -name "*.bak" -o -name "*.old"` | Revisar manual |

---

## Docker Cleanup

```bash
# Ver espacio recuperable
docker system df

# Limpiar todo lo no usado (CUIDADO: borra volumes huérfanos)
docker system prune -a --volumes -f

# Solo imágenes dangling
docker image prune -f

# Solo containers parados
docker container prune -f
```

---

## Logs Específicos

| Servicio | Ubicación | Rotación |
|----------|-----------|----------|
| OpenClaw | `/tmp/openclaw/*.log` | Diario automático |
| Docker | `/var/lib/docker/containers/*/` | Configurar max-size |
| Nginx | `/var/log/nginx/` | logrotate |
| System | `/var/log/syslog` | logrotate |

---

## Workspace Cleanup

```bash
# Archivos backup
find /root/.openclaw/workspace -name "*.bak" -o -name "*.old" -o -name "*~"

# Node_modules antiguos
find /root -name "node_modules" -type d -mtime +30

# Git branches merged
git branch --merged main | grep -v main
```

---

## Checklist de Limpieza Mensual

- [ ] Verificar disco libre >50GB
- [ ] Docker system prune si >5GB unused
- [ ] Revisar backups antiguos
- [ ] Limpiar branches git merged
- [ ] Verificar logs no crecen descontrolados

---

## Estado Actual (2026-02-20)

| Métrica | Valor | Estado |
|---------|-------|--------|
| /tmp/openclaw | 19MB | ✅ OK |
| Locks huérfanos | 0 | ✅ OK |
| Logs >30 días | 0 | ✅ OK |
| Backup files | 2 | ✅ Revisar |
| Disco libre | 93GB | ✅ OK |

---

## Notas

- **NO eliminar sin verificar:** Docker volumes, databases, configs
- **SIEMPRE confirmar antes:** `docker system prune -a --volumes`
- **Backup antes de limpiar:** Si es importante, copiar primero

---

_Creado: 2026-02-20 - Micro-tarea 01:55 UTC_
