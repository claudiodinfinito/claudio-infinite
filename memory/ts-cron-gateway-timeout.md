# TS: Cron Gateway WebSocket Timeout

ID: TS-CRON-GATEWAY-001
Status: INVESTIGANDO
Date: 2026-02-20 04:10 UTC
Severity: HIGH

---

## Problema

Los cronjobs fallan con timeout al conectar con el Gateway via WebSocket:

```
[tools] cron failed: gateway timeout after 60000ms
Gateway target: ws://127.0.0.1:18789
Source: local loopback
```

## Síntomas

1. `cron list` funciona (lee jobs.json directamente)
2. `cron run` falla con timeout 60s
3. Jobs programados no se ejecutan automáticamente
4. HTTP en puerto 18789 funciona (devuelve UI)
5. WebSocket en puerto 18789 falla

## Diagnóstico Realizado

| Check | Resultado |
|-------|-----------|
| Gateway HTTP | ✅ OK (curl devuelve HTML) |
| Puerto 18789 TCP | ✅ OK (nc conecta) |
| Telegram channel | ✅ OK (running, polling mode) |
| WebSocket connection | ❌ FAIL (timeout 60s) |
| Auth token | ✅ Configurado |

## Causa Probable

El Gateway no está aceptando conexiones WebSocket correctamente. Posibles razones:

1. **WebSocket server no iniciado** - Gateway corre pero sin WS
2. **Auth token mismatch** - Token en .env no coincide
3. **Gateway saturado** - Cola de mensajes bloqueada
4. **Bug en OpenClaw** - Issue conocido

## Soluciones Probadas

| Solución | Resultado |
|----------|-----------|
| `systemctl --user restart openclaw-gateway` | ❌ Mismo error |
| `delivery.bestEffort: true` | N/A (el problema es antes) |
| `delivery.mode: none` | N/A (el problema es ejecutar el job) |

## Workaround Temporal

Ejecutar tareas manualmente sin cron hasta resolver el problema.

## Próximos Pasos

1. Verificar OPENCLAW_GATEWAY_TOKEN en .env
2. Revisar si hay issues conocidos en OpenClaw GitHub
3. Considerar actualizar OpenClaw
4. Abrir issue si no hay solución documentada

---

_Actualizado: 2026-02-20 04:10 UTC_
