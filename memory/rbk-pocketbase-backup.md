# Runbook: PocketBase Backup

**Propósito:** Backup automático de datos de PocketBase.
**Frecuencia:** Diario (configurar en cron).
**Fuente:** Item #77 de ref-interests-real-100.md

---

## Backup Manual

```bash
# Crear directorio de backups
mkdir -p /root/respaldos_pocketbase

# Backup completo
tar -czf /root/respaldos_pocketbase/pb_$(date +%F).tar.gz /ruta/pocketbase/pb_data

# Verificar
ls -lh /root/respaldos_pocketbase/
```

---

## Backup Automático (Cronjob)

### Opción 1: Script simple

```bash
# Crear script
cat > /root/scripts/backup_pocketbase.sh << 'EOF'
#!/bin/bash
BACKUP_DIR="/root/respaldos_pocketbase"
PB_DATA="/ruta/pocketbase/pb_data"
DATE=$(date +%F)

# Crear backup
tar -czf $BACKUP_DIR/pb_$DATE.tar.gz $PB_DATA

# Eliminar backups > 7 días
find $BACKUP_DIR -name "pb_*.tar.gz" -mtime +7 -delete

echo "Backup completado: pb_$DATE.tar.gz"
EOF

chmod +x /root/scripts/backup_pocketbase.sh
```

### Opción 2: Via OpenClaw Cron

```bash
openclaw cron add --name "backup:pocketbase" --schedule "0 6 * * *" --command "/root/scripts/backup_pocketbase.sh"
```

---

## Contenido del Backup

| Archivo/Carpeta | Qué contiene |
|-----------------|--------------|
| `data.db` | Base de datos principal |
| `logs.db` | Logs del sistema |
| `storage/` | Archivos subidos |
| `data/` | Datos de colecciones |

---

## Restaurar Backup

```bash
# Detener PocketBase
docker stop srv-captain--a1-pocketbase

# Restaurar
tar -xzf /root/respaldos_pocketbase/pb_2026-02-20.tar.gz -C /

# Iniciar PocketBase
docker start srv-captain--a1-pocketbase
```

---

## Verificar Integridad

```bash
# Listar contenido sin extraer
tar -tzf /root/respaldos_pocketbase/pb_2026-02-20.tar.gz

# Ver tamaño
du -sh /root/respaldos_pocketbase/
```

---

## Retención

| Tipo | Duración |
|------|----------|
| Diarios | 7 días |
| Semanales | 4 semanas |
| Mensuales | 12 meses |

---

## Monitoreo

```bash
# Verificar que el backup existe
ls -la /root/respaldos_pocketbase/pb_$(date +%F).tar.gz

# Alertar si no existe (añadir a cron)
test -f /root/respaldos_pocketbase/pb_$(date +%F).tar.gz || echo "ALERT: Backup faltante"
```

---

## En OpenClaw

El container activo es: `srv-captain--a1-pocketbase.1.xgfha5cscco3frzcgmbx0euvd`

Para encontrar la ruta real de pb_data:
```bash
docker inspect srv-captain--a1-pocketbase | grep -A 5 "Mounts"
```

---

_Creado: 2026-02-20 19:41 UTC - Micro-tarea autónoma_
