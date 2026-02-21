# Runbook: Limpieza de Logs del Sistema

ID: RBK-LOGS-001
Status: active
Created: 2026-02-21 15:30 UTC
Keys: logs, cleanup, maintenance, disk-space

---

## TL;DR

Limpiar logs del sistema de forma segura para liberar espacio en disco.

---

## Estado Actual (2026-02-21)

| Ubicación | Tamaño | Tipo |
|-----------|--------|------|
| `/var/log/journal` | 1.2G | Systemd journal (NO tocar directamente) |
| `/var/log/btmp` | 124M | Failed login attempts (puede limpiar) |
| `/var/log/auth.log.*` | 80M | Auth logs (rotación automática) |
| `/var/log/syslog.*` | 39M | Syslog (rotación automática) |
| `/var/log/kern.log.*` | 11M | Kernel logs (rotación automática) |
| `/tmp/openclaw/` | 34M | OpenClaw logs (rotación automática) |
| **Total logs** | ~1.5G | |

**Logs >30 días:** 0 encontrados ✅

---

## Qué Limpiar con Seguridad

### ✅ SEGURO (limpiar)

| Log | Comando | Espacio liberado |
|-----|---------|------------------|
| `btmp` (failed logins) | `> /var/log/btmp` | ~124M |
| `wtmp` (login records) | `> /var/log/wtmp` | Variable |

### ⚠️ CON PRECAUCIÓN (usar herramientas)

| Log | Herramienta | Comando |
|-----|-------------|---------|
| Journal | `journalctl` | `journalctl --vacuum-time=7d` |
| Syslog | `logrotate` | `logrotate -f /etc/logrotate.conf` |
| Apt logs | `apt` | `apt clean` |

### ❌ NO TOCAR

| Log | Razón |
|-----|-------|
| `/var/log/syslog` | Sistema activo |
| `/var/log/auth.log` | Sistema activo |
| `/var/log/kern.log` | Sistema activo |
| `/var/log/journal/*` | Usar journalctl |

---

## Comandos de Limpieza

### 1. Limpiar btmp (failed logins) - 124M

```bash
# Verificar tamaño actual
du -sh /var/log/btmp

# Limpiar (preservar archivo)
> /var/log/btmp

# Verificar
du -sh /var/log/btmp
```

### 2. Limpiar journal (>7 días)

```bash
# Ver tamaño actual
journalctl --disk-usage

# Limpiar logs >7 días
sudo journalctl --vacuum-time=7d

# Alternativa: limitar a 500M
sudo journalctl --vacuum-size=500M

# Verificar
journalctl --disk-usage
```

### 3. Forzar rotación de logs

```bash
# Verificar configuración
cat /etc/logrotate.conf | head -20

# Forzar rotación
sudo logrotate -f /etc/logrotate.conf

# Verificar archivos rotados
ls -lah /var/log/*.gz 2>/dev/null | head -10
```

### 4. Limpiar apt cache

```bash
# Ver tamaño
du -sh /var/cache/apt/archives

# Limpiar
sudo apt clean

# Verificar
du -sh /var/cache/apt/archives
```

---

## Verificación de Logs >30 días

```bash
# Buscar logs antiguos
find /var/log /tmp/openclaw -name "*.log" -type f -mtime +30 2>/dev/null

# Si hay resultados, ver tamaño total
find /var/log /tmp/openclaw -name "*.log" -type f -mtime +30 2>/dev/null | xargs du -ch 2>/dev/null | tail -1
```

---

## Cronjob Mensual

**Agregar a crontab -e:**

```bash
# Limpiar journal cada 1ero del mes a las 3 AM
0 3 1 * * /usr/bin/journalctl --vacuum-time=30d 2>/dev/null

# Limpiar btmp cada domingo a las 3 AM
0 3 * * 0 /bin/bash -c '> /var/log/btmp' 2>/dev/null
```

---

## Espacio Esperado a Liberar

| Acción | Espacio |
|--------|---------|
| Limpiar btmp | ~124M |
| Journal vacuum 7d | ~500M-800M |
| apt clean | ~50M |
| **Total potencial** | ~700M-1G |

---

## Síntomas de Logs Llenando Disco

- Disco >80% usado
- Errores de "No space left on device"
- Logs en `/var/log` > 5GB
- Journal > 2GB

---

## Flujo de Limpieza

```
1. Verificar espacio: df -h
   ↓
2. Identificar logs grandes: du -sh /var/log/*
   ↓
3. Limpiar seguros: btmp, journal vacuum
   ↓
4. Verificar: df -h
   ↓
5. Documentar en daily log
```

---

## Logs de OpenClaw

```bash
# Ver logs actuales
ls -lah /tmp/openclaw/*.log 2>/dev/null

# OpenClaw rota automáticamente por día
# Logs antiguos se eliminan automáticamente

# Ver uso total
du -sh /tmp/openclaw/
```

**Rotación automática:** OpenClaw crea logs con fecha y elimina antiguos.

---

## Prevención

1. **Configurar journal limits:**
   ```bash
   # Editar /etc/systemd/journald.conf
   SystemMaxUse=500M
   MaxRetentionSec=30day
   ```

2. **Logrotate configurado:**
   ```bash
   # Verificar que logrotate corre
   systemctl status logrotate.timer
   ```

3. **Monitorear espacio:**
   ```bash
   # Agregar a health check
   df -h / | awk 'NR==2 {print $5}' | sed 's/%//'
   ```

---

## Referencias

- `memory/rbk-cleanup-logs-locks.md` — Limpieza general
- `memory/rbk-orphaned-locks.md` — Locks huérfanos
- `HEARTBEAT.md` — Health checks automáticos

---

_Actualizado: 2026-02-21 15:30 UTC - 0 logs antiguos, espacio estable_
