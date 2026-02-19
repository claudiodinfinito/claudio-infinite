# rbk-triage.md - Loop de Debugging

ID: RBK-TRIAGE-001
Status: active
Tags: #debugging #triage #troubleshooting #gateway
Keys: triage, debugging, gateway, troubleshooting, logs
Last reviewed: 2026-02-19

---

## Trigger
Cuando algo no funciona (gateway, modelo, canal, sesión).

---

## Preconditions
- Acceso a terminal
- Gateway instalado

---

## Steps

### 1. Verificar liveness del Gateway
```bash
curl -I http://127.0.0.1:18789/
openclaw gateway status
```

### 2. Si NO está escuchando, revisar logs
```bash
journalctl --user -u openclaw-gateway.service -n 200
tail -n 200 /tmp/openclaw/openclaw-$(date +%Y-%m-%d).log
```

### 3. Después de cada cambio, reiniciar
```bash
openclaw gateway restart
openclaw gateway status
```

---

## Checks (post)
- [ ] ¿Gateway responde?
- [ ] ¿Logs sin errores críticos?
- [ ] ¿Modelo accesible?

---

## Rollback
Si el reinicio empeora las cosas:
```bash
openclaw gateway stop
# Revisar config
openclaw gateway start
```

---

## Gotchas
- No reiniciar en loop sin identificar causa
- Siempre revisar logs antes de actuar
- Config JSON5 → llaves desconocidas rompen startup

---

_Creado: 2026-02-19 - Extraído de AGENTS.md_
