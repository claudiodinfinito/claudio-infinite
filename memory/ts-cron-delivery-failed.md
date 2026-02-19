# Troubleshooting: Cron Announce Delivery Failed

```
ID: TS-CRON-001
Status: active
Tags: #cron #delivery #announce #error #heartbeat
Keys: cron, delivery, announce, error, isolated
Last reviewed: 2026-02-19
```

---

## Symptom

Cron job `healthcheck:vps-daily` muestra status "error" en `openclaw cron list`:

```
error: "cron announce delivery failed"
```

Pero el job se ejecutó correctamente (VPS healthcheck OK).

---

## Evidence

**Último run:**
```json
{
  "status": "error",
  "error": "cron announce delivery failed",
  "summary": "**VPS Healthcheck OK ✅**\n\nRAM: 22%, Disco: 33%, Docker: 8 containers, Gateway: OK"
}
```

**El healthcheck funcionó** - el error es solo en el delivery del resultado.

---

## Likely Causes

1. **Delivery no configurado** - El job no tiene delivery config
2. **Canal no disponible** - Telegram temporalmente inalcanzable
3. **Target incorrecto** - `to` no coincide con ningún chat válido

---

## Tests

### Test 1: Verificar delivery config del job

```bash
openclaw cron list --json | jq '.[] | select(.id == "53cc6fb2-b188-427f-956a-504c1261beb2") | .delivery'
```

Si retorna `null` → no hay delivery configurado.

### Test 2: Verificar config de heartbeat

```bash
grep -A5 '"heartbeat"' ~/.openclaw/openclaw.json
```

### Test 3: Verificar canal Telegram

```bash
openclaw channels status --probe --channel telegram
```

---

## Fixes

### Plan A: Configurar delivery en el cron job

El job corre en sesión `isolated` - necesita delivery config explícito:

```json
{
  "delivery": {
    "mode": "announce",
    "channel": "telegram",
    "to": "8596613010"
  }
}
```

**Cómo aplicar:**
```bash
openclaw cron update --id 53cc6fb2-b188-427f-956a-504c1261beb2 --patch '{"delivery": {"mode": "announce", "channel": "telegram", "to": "8596613010"}}'
```

### Plan B: Dejar que heartbeat maneje el announce

Si el heartbeat ya está configurado correctamente, el cron job no necesita delivery - el resultado queda en logs y el heartbeat lo puede revisar.

**Ventajas:**
- Menos spam en Telegram
- Un solo canal de comunicación

**Desventajas:**
- No hay notificación inmediata de errores

### Plan C: Eliminar delivery y aceptar el error como "no crítico"

Si el job funciona y el resultado está en logs, el error de delivery es cosmético.

---

## Prevent

- Al crear cron jobs en `isolated` sessions, siempre configurar delivery si se quiere notificación
- Documentar en runbook de cron jobs

---

## Decision

**Por ahora:** Plan B/C - el error es cosmético, el healthcheck funciona.

**Cuando Daniel quiera notificaciones:** Aplicar Plan A.

---

## Related

- `memory/ts-heartbeat-no-funciona.md` - Problema de rate limit
- `memory/rbk-gateway-restart.md` - Restart del gateway

---

_Creado: 2026-02-19 - Diagnóstico de cron delivery_
