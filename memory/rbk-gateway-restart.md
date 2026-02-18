# rbk-gateway-restart.md

```
ID: RBK-GW-001
Status: active
Tags: #ops #gateway #restart #debug
Keys: gateway, restart, systemctl, debug, openclaw
Last reviewed: 2026-02-18
```

---

## Runbook: Reiniciar OpenClaw Gateway

### Trigger

- Gateway no responde (timeout en mensajes)
- `openclaw gateway status` muestra "stopped" o error
- Logs con errores críticos (panic, OOM, crash)
- Después de cambios en config (`/root/.openclaw/openclaw.json`)
- Después de actualizar OpenClaw

---

### Preconditions

1. Tener acceso SSH al VPS (192.227.249.251)
2. Usuario con permisos systemctl --user
3. Conocer la última config válida (backup disponible)

---

### Steps

#### 1. Verificar estado actual

```bash
openclaw gateway status
openclaw status
```

Si muestra "stopped" o error → continuar.

#### 2. Revisar logs recientes

```bash
tail -n 100 /tmp/openclaw/openclaw-$(date +%Y-%m-%d).log
```

Identificar si hay:
- Error de config (JSON inválido)
- Error de modelo (API key, timeout)
- Error de canal (token expirado)
- Panic/crash

#### 3. Reiniciar el servicio

```bash
systemctl --user restart openclaw-gateway
```

#### 4. Verificar que levantó

```bash
systemctl --user status openclaw-gateway
openclaw gateway status
```

Debe mostrar "active (running)" y gateway escuchando en puerto 18789.

#### 5. Validar conectividad

```bash
curl -I http://127.0.0.1:18789/
```

Debe retornar HTTP 200 o similar.

#### 6. Probar modelo

```bash
openclaw models status --probe --probe-provider glm5 --json
```

Debe mostrar `"status": "ok"` para el modelo GLM-5.

---

### Checks (post)

- [ ] `systemctl --user status openclaw-gateway` = active (running)
- [ ] `openclaw gateway status` = listening
- [ ] `curl -I http://127.0.0.1:18789/` = HTTP 200
- [ ] `openclaw models status --probe` = ok
- [ ] Enviar mensaje de prueba por Telegram

---

### Rollback

Si el restart falla y el problema es de config:

1. **Restaurar config anterior:**
   ```bash
   cp /root/.openclaw/openclaw.json.backup /root/.openclaw/openclaw.json
   systemctl --user restart openclaw-gateway
   ```

2. **Si no hay backup, usar config mínima:**
   ```json5
   {
     "agents": {
       "defaults": {
         "model": { "modelId": "glm5/zai-org/GLM-5-FP8" }
       }
     },
     "channels": {
       "telegram": {
         "enabled": true,
         "token": "[ver .env]"
       }
     }
   }
   ```

3. **Verificar logs para identificar el error de config:**
   ```bash
   journalctl --user -u openclaw-gateway -n 50
   ```

---

### Gotchas

- **Config es JSON5:** admite comentarios y trailing commas, pero keys desconocidas causan crash
- **Error "Unrecognized key X":** eliminar la key de config, no ignorar
- **Session locked:** si hay `.jsonl.lock` files, eliminarlos antes de restart
- **Model timeout:** si GLM-5 no responde, puede ser problema de Modal (el proveedor), no de OpenClaw
- **No usar `sudo`:** el servicio corre con `systemctl --user`, no a nivel sistema

---

## Variations

### After config change

1. Validar JSON: `cat /root/.openclaw/openclaw.json | python3 -m json.tool` (falla si inválido)
2. Backup: `cp /root/.openclaw/openclaw.json /root/.openclaw/openclaw.json.backup`
3. Aplicar cambios
4. Restart

### After OpenClaw update

```bash
npm update -g openclaw
systemctl --user restart openclaw-gateway
openclaw doctor
```

### Session locked

```bash
systemctl --user stop openclaw-gateway
find /root/.openclaw -name "*.lock" -delete
systemctl --user start openclaw-gateway
```

---

_Creado: 2026-02-18_
