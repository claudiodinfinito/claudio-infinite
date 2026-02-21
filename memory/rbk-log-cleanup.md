# Runbook: Limpieza de Logs Antiguos

ID: RBK-LOGS-001
Status: active
Created: 2026-02-21 15:35 UTC
Keys: logs, cleanup, maintenance, storage, journalctl

---

## TL;DR

Los logs acumulados pueden llenar el disco. Este runbook define cómo limpiar logs del sistema y de OpenClaw de forma segura.

---

## Diagnóstico de Espacio

### 1. Ver uso general de /var/log
```bash
du -sh /var/log/* 2>/dev/null | sort -h
```

### 2. Ver uso de journald
```bash
journalctl --disk-usage
```

### 3. Ver logs de OpenClaw
```bash
du -sh /tmp/openclaw
```

---

## Procedimiento de Limpieza

### 1. Limpiar Journald (Logs del Sistema)
Mantener solo los últimos 7 días o 500MB.

```bash
# Por tiempo
journalctl --vacuum-time=7d

# Por tamaño
journalctl --vacuum-size=500M
```

### 2. Rotar logs de OpenClaw
OpenClaw guarda logs diarios en `/tmp/openclaw/openclaw-YYYY-MM-DD.log`.

**Regla:** Mantener últimos 14 días.

```bash
# Buscar y borrar logs de OpenClaw de más de 14 días
find /tmp/openclaw -name "openclaw-*.log" -type f -mtime +14 -delete
```

### 3. Limpiar btmp y wtmp (Opcional)
`btmp` registra intentos fallidos de login. En un VPS esto crece rápido por bots.

```bash
# Vaciar btmp (intentos fallidos)
cat /dev/null > /var/log/btmp
```

---

## Verificación Post-Limpieza

| Métrica | Target |
|---------|--------|
| `/var/log/journal` | < 500MB |
| `/tmp/openclaw` | < 50MB |
| Disco libre | > 20% |

---

## Automatización

### Cronjob sugerido
Ejecutar semanalmente (Domingo 03:00).

```bash
0 3 * * 0 journalctl --vacuum-time=7d && find /tmp/openclaw -name "openclaw-*.log" -type f -mtime +14 -delete
```

---

## Estado del Sistema (2026-02-21)

- `/var/log/journal`: 1.2G (⚠️ Requiere limpieza)
- `/var/log/btmp`: 124M (⚠️ Alto tráfico de bots)
- `/tmp/openclaw`: 34M (✅ OK)

---

## Referencias

- `memory/rbk-cleanup-logs-locks.md` — Guía general de mantenimiento.
- `memory/ref-vps-commands-cheatsheet.md` — Comandos de sistema.

---

_Actualizado: 2026-02-21 15:35 UTC_
