# Runbook: Detectar y Eliminar Locks Huérfanos

**Creado:** 2026-02-21 (Autonomía)
**Propósito:** Detectar .lock files sin proceso asociado y eliminarlos de forma segura

---

## Comando Rápido

```bash
# Encontrar todos los locks
find /root/.openclaw -name "*.lock" -type f 2>/dev/null

# Verificar si un lock tiene proceso activo
cat /path/to/file.lock
# Si el PID no existe en ps aux → es huérfano
ps aux | grep <PID>
```

---

## Procedimiento

### 1. Detectar locks
```bash
find /root/.openclaw -name "*.lock" -type f 2>/dev/null
```

### 2. Verificar cada lock
```bash
# Leer el lock
cat /root/.openclaw/agents/main/sessions/<session-id>.jsonl.lock

# Output esperado:
# {
#   "pid": 123456,
#   "createdAt": "2026-02-21T12:35:00.426Z"
# }

# Verificar si el proceso existe
ps aux | grep <PID>
```

### 3. Eliminar si es huérfano
```bash
# Si el PID NO existe → eliminar el lock
rm /path/to/orphan.lock
```

---

## Cuándo es Huérfano

| Condición | Acción |
|-----------|--------|
| PID existe en `ps aux` | NO eliminar, está activo |
| PID no existe | Eliminar lock |
| Lock antiguo (>1 día) y PID no existe | Definitivamente huérfano |

---

## Check Rápido (One-liner)

```bash
for lock in $(find /root/.openclaw -name "*.lock" -type f 2>/dev/null); do
  pid=$(cat "$lock" 2>/dev/null | grep -o '"pid": [0-9]*' | grep -o '[0-9]*')
  if [ -n "$pid" ] && ! ps -p "$pid" > /dev/null 2>&1; then
    echo "HUÉRFANO: $lock (PID $pid no existe)"
  fi
done
```

---

## Historial de Verificaciones

| Fecha | Locks Encontrados | Huérfanos | Acción |
|------|-------------------|-----------|--------|
| 2026-02-21 | 1 | 0 | Ninguno, sistema limpio |

---

## Notas

- **Lock de sesión actual:** Si el lock fue creado hace pocos minutos y el archivo .jsonl se está actualizando, es la sesión activa — NO tocar
- **Locks antiguos:** Si tienen días de antigüedad y el PID no existe, son seguros de eliminar
- **Jamás eliminar sin verificar el PID primero**
