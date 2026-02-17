ID: RBK-SES-001
Status: active
Tags: #ops #session #locked #gateway
Keys: session, locked, gateway, restart, lock
Owner: main
Last reviewed: 2026-02-17

# rbk-session-locked.md

## Trigger

Error: `session file locked ... .jsonl.lock`

## Preconditions

- Gateway corriendo
- Acceso a consola

## Steps

1. Detener gateway:
   ```bash
   systemctl --user stop openclaw-gateway
   ```

2. Eliminar locks:
   ```bash
   rm /root/.openclaw/agents/main/sessions/*.lock
   ```

3. Reiniciar gateway:
   ```bash
   systemctl --user start openclaw-gateway
   ```

4. Verificar:
   ```bash
   openclaw gateway status
   ```

## Checks (post)

```bash
ls /root/.openclaw/agents/main/sessions/*.lock
# No debe retornar nada
```

## Rollback

Si algo falla, restaurar gateway manualmente:
```bash
systemctl --user start openclaw-gateway
```

## Gotchas

- Asegurarse de que no hay sesiones activas antes de eliminar locks
- Config `session.dmScope: "per-channel-peer"` previene futuros locks
