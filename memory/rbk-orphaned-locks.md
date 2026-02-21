# Runbook: Detectar y Limpiar Locks Huérfanos

ID: RBK-LOCKS-001
Status: active
Created: 2026-02-21 15:20 UTC
Keys: locks, orphaned, cleanup, maintenance

---

## TL;DR

Los archivos `.lock` huérfanos pueden bloquear operaciones. Detectar y eliminar seguros.

---

## Qué son los Locks Huérfanos

Archivos `.lock` que quedan cuando:
- Proceso termina inesperadamente (crash)
- Gateway se reinicia sin cleanup
- Sesión de subagente no termina limpio

---

## Diagnóstico

### 1. Buscar todos los locks

```bash
find /tmp -name "*.lock" -type f 2>/dev/null
```

### 2. Ver detalles de locks encontrados

```bash
find /tmp -name "*.lock" -type f -exec ls -lah {} \; 2>/dev/null
```

### 3. Ver timestamps de modificación

```bash
find /tmp -name "*.lock" -type f -exec stat {} \; 2>/dev/null | grep -E "File:|Modify:"
```

---

## Cómo Determinar si es Huérfano

### Regla: Lock es huérfano si:

1. **Proceso dueño NO existe**
   ```bash
   # Extraer PID del lock
   LOCK_FILE="/tmp/openclaw-0/gateway.XXXXXX.lock"
   PID=$(cat "$LOCK_FILE" 2>/dev/null | grep -o '"pid":[0-9]*' | cut -d: -f2)

   # Verificar si proceso existe
   ps -p "$PID" > /dev/null 2>&1 && echo "Activo" || echo "Huérfano"
   ```

2. **Lock es antiguo (>24 horas)**
   ```bash
   find /tmp -name "*.lock" -mtime +0 -type f 2>/dev/null
   ```

3. **Gateway no está usando ese lock específico**
   ```bash
   # Ver proceso activo
   openclaw gateway status | grep "pid"
   ```

---

## Estado Actual (2026-02-21)

| Lock File | Created | PID | Estado |
|-----------|---------|-----|--------|
| `/tmp/openclaw-0/gateway.050719e6.lock` | 13:06 UTC | 2085373 | ✅ Activo (gateway running) |

**Conclusión:** No hay locks huérfanos en este momento.

---

## Limpieza Segura

### ⚠️ ANTES de eliminar

1. **Verificar que el proceso NO existe:**
   ```bash
   ps -p <PID> 2>/dev/null || echo "Proceso no existe, lock es huérfano"
   ```

2. **Verificar que NO es el gateway actual:**
   ```bash
   openclaw gateway status
   ```

### Comando de limpieza

```bash
# Eliminar lock huérfano específico
rm -f /tmp/openclaw-0/gateway.XXXXXX.lock

# Eliminar todos los locks huérfanos (con verificación)
for lock in /tmp/openclaw*/gateway.*.lock; do
  PID=$(cat "$lock" 2>/dev/null | grep -o '"pid":[0-9]*' | cut -d: -f2)
  if [ -n "$PID" ] && ! ps -p "$PID" > /dev/null 2>&1; then
    echo "Eliminando lock huérfano: $lock (PID $PID no existe)"
    rm -f "$lock"
  fi
done
```

---

## Síntomas de Lock Huérfano

- Gateway no inicia: `Address already in use`
- Sesión bloqueada: `Session locked`
- Cronjob falla: `Cannot acquire lock`
- Error: `EADDRINUSE`

---

## Cronjob Semanal

**Verificación automática cada domingo:**

```bash
# Agregar a crontab -e
0 3 * * 0 find /tmp -name "*.lock" -mtime +7 -type f -delete 2>/dev/null
```

---

## Flujo de Troubleshooting

```
Gateway no inicia
  ↓
Buscar locks: find /tmp -name "*.lock"
  ↓
¿Proceso dueño existe?
  ├── Sí → Lock válido, otro problema
  └── No → Lock huérfano
           ↓
       Eliminar lock
           ↓
       Reiniciar gateway
```

---

## Prevención

1. **Siempre detener gateway limpio:**
   ```bash
   openclaw gateway stop
   ```

2. **No matar proceso con kill -9** (usar stop)

3. **Verificar locks después de crash**

---

## Referencias

- `memory/rbk-session-locked.md` — Sesión bloqueada
- `memory/rbk-triage.md` — Triage general
- `HEARTBEAT.md` — Health checks automáticos

---

_Actualizado: 2026-02-21 15:20 UTC - Sin locks huérfanos detectados_
