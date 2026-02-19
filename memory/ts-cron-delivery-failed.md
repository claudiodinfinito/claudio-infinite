# ts-cron-delivery-failed.md

```
ID: TS-CRON-001
Status: active
Tags: #cron #delivery #telegram #error
Keys: cron, delivery, failed, telegram, announce
Last reviewed: 2026-02-19
```

---

## Troubleshooting: Cron Job Delivery Failed

### Symptom

`openclaw cron list` muestra status "error" con:
```
"lastError": "cron announce delivery failed"
```

El job ejecuta correctamente y produce un summary válido, pero no puede entregar el resultado al canal configurado.

---

### Likely Causes (3)

1. **Channel temporalmente no disponible** (PROB: Media)
   - Telegram API timeout
   - Rate limit en Telegram
   - Test: Verificar otros mensajes Telegram funcionan

2. **Config de delivery incorrecta** (PROB: Baja)
   - Chat ID incorrecto
   - Token de bot expirado/inválido
   - Test: Enviar mensaje manual al mismo chat

3. **Issue en OpenClaw delivery system** (PROB: Baja)
   - Bug en announce delivery
   - Network issue
   - Test: Ver logs del gateway

---

### Tests

**Test 1: Verificar Telegram funciona**
```bash
# Enviar mensaje de prueba manual
openclaw channels status --probe --channel telegram
```

**Test 2: Ver logs del delivery**
```bash
grep -i "delivery\|announce\|telegram" /tmp/openclaw/openclaw-$(date +%Y-%m-%d).log | tail -20
```

**Test 3: Re-ejecutar el job**
```bash
openclaw cron run --id 53cc6fb2-b188-427f-956a-504c1261beb2
```

---

### Fixes

**Plan A: Ignorar si es esporádico**
- El job ejecutó correctamente
- El summary se generó bien
- Solo el delivery falló
- Próximo run intentará de nuevo

**Plan B: Verificar canal**
```bash
openclaw channels status --probe --channel telegram
```
Si hay error, revisar token y chat ID.

**Plan C: Revisar config delivery**
```json
{
  "delivery": {
    "mode": "announce",
    "to": "8596613010",
    "channel": "telegram"
  }
}
```
Verificar que el chat ID sea correcto.

---

### Current Status (19 Feb 2026)

| Job | Status | Last Run | Error |
|-----|--------|----------|-------|
| healthcheck:vps-daily | error | 19 Feb 06:00 UTC | cron announce delivery failed |
| backup:workspace | ok | 19 Feb 06:00 UTC | - |

**Observación:**
- El healthcheck produjo un summary válido: "VPS Healthcheck OK ✅"
- El backup:workspace con el mismo delivery config funcionó OK
- Posiblemente un problema temporal

---

### Next Steps

1. [ ] Verificar logs del delivery fallido
2. [ ] Comparar con backup:workspace que sí funcionó
3. [ ] Si persiste, investigar en OpenClaw issues

---

### Prevent

- Monitoring de consecutiveErrors en cron jobs
- Alert si consecutiveErrors > 2
- Alternativa: usar delivery.mode: "webhook" si announce falla recurrentemente

---

_Creado: 2026-02-19 - Documentando delivery failed en healthcheck:vps-daily_
