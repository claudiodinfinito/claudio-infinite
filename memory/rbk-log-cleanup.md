# Runbook: Limpieza de Logs Antiguos

**ID:** RBK-LOG-001
**Frecuencia:** Mensual o cuando disco >80%
**Tiempo:** 5 minutos
**Riesgo:** Bajo (solo lectura de logs antiguos)

---

## Objetivo

Eliminar logs con más de 30 días para liberar espacio en disco.

---

## Pre-requisitos

- [ ] Verificar espacio actual: `df -h`
- [ ] Confirmar que no hay procesos críticos usando esos logs

---

## Paso 1: Identificar logs antiguos

```bash
# Logs del sistema (>30 días)
find /var/log -name "*.log" -mtime +30 -ls

# Logs de usuario (>30 días)
find /root -name "*.log" -mtime +30 -ls

# Logs temporales (>30 días)
find /tmp -name "*.log" -mtime +30 -ls
```

---

## Paso 2: Verificar tamaño total

```bash
# Calcular espacio a liberar
find /var/log -name "*.log" -mtime +30 -exec du -ch {} + | grep total
find /root -name "*.log" -mtime +30 -exec du -ch {} + | grep total
```

---

## Paso 3: Limpiar (con precaución)

### Logs del sistema (requiere permisos)

```bash
# ELIMINAR logs antiguos del sistema (>30 días)
sudo find /var/log -name "*.log" -mtime +30 -delete
```

### Logs de usuario

```bash
# ELIMINAR logs antiguos de usuario (>30 días)
find /root -name "*.log" -mtime +30 -delete
```

### Logs temporales

```bash
# ELIMINAR logs temporales antiguos
find /tmp -name "*.log" -mtime +30 -delete
```

---

## Paso 4: Verificar resultado

```bash
# Confirmar espacio liberado
df -h

# Verificar que no quedaron logs antiguos
find /var/log -name "*.log" -mtime +30 | wc -l
find /root -name "*.log" -mtime +30 | wc -l
```

---

## Logs que NO tocar

| Tipo | Razón |
|------|-------|
| `/var/log/syslog` | Sistema activo |
| `/var/log/auth.log` | Seguridad |
| `/var/log/journal/` | Systemd journals |
| Logs de aplicaciones en Docker | Docker los gestiona |

---

## Alternativa segura: comprimir en lugar de eliminar

```bash
# Comprimir logs antiguos en lugar de eliminar
find /var/log -name "*.log" -mtime +30 -exec gzip {} \;
```

---

## Rollback

Si se eliminó algo importante por error:

```bash
# No hay rollback para rm, pero los logs se regeneran automáticamente
# Verificar que los servicios siguen funcionando:
systemctl status --no-pager
docker ps
```

---

## Registro

Después de ejecutar, anotar en `memory/YYYY-MM-DD.md`:

```
## Log Cleanup
- Fecha: YYYY-MM-DD HH:MM
- Espacio liberado: X MB
- Logs eliminados: N archivos
```

---

_Creado: 2026-02-21 — Micro-tarea autónoma_
