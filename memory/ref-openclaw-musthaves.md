ID: REF-MUST-001
Status: active
Tags: #trainer #must-have #openclaw #config
Keys: must-have, trainer, config, openclaw, fallback, backup
Owner: main
Last reviewed: 2026-02-17

# 7 Must-Haves de OpenClaw (del Trainer)

## #1: Siempre responde (fallback + pruebas)

- Primary + fallback confiable
- `ANTHROPIC_API_KEY` en `~/.openclaw/.env`
- `agents.defaults.model.fallbacks: ["anthropic/..."]`
- **NUNCA** Anthropic en `models.providers`

**Probe rutina:**
```bash
openclaw models status --probe --probe-provider glm5 --json
```

---

## #2: Estado y secretos "service-proof"

- Todo token/API key en `~/.openclaw/.env` (chmod 600)
- systemd/daemons NO heredan shell env
- Si "No API key found" → revisar `.env`

---

## #3: Config minimalista + schema estricto

- Una key vieja tumba todo
- Anti-patterns que ROMPEN:
  - `gateway.auth.rateLimit` (ya no existe)
  - `agents.defaults.model.failover` (ahora es `fallbacks`)
  - Inventar providers built-in en `models.providers`

**Ritual:** editar config → `openclaw doctor` → si falla → `--fix`

---

## #4: Acceso seguro al dashboard

- `gateway.bind: "loopback"` SIEMPRE
- Acceso por SSH tunnel o Tailscale Serve
- Si expones: BasicAuth/Cloudflare Access/VPN
- Token no es suficiente, Internet escanea todo

---

## #5: DM safety + evitar locks

```json5
session: {
  dmScope: "per-channel-peer"
}
```

Sin esto, todas las DMs comparten sesión. Si se bloquea, se cae todo.

---

## #6: Runbook + diario (mejorar con el tiempo)

3 archivos:
- `RUNBOOK.md` = cómo está montado el stack + recovery
- `MEMORY.md` = reglas duraderas
- `memory/YYYY-MM-DD.md` = lo aprendido hoy

**Esto es lo que hacen los outliers: convierten caos en procedimientos.**

---

## #7: Update discipline (cero heroísmo)

**Antes de actualizar:**
```bash
cp ~/.openclaw/openclaw.json ~/.openclaw/openclaw.json.pre-update.$(date +%F)
cp ~/.openclaw/.env ~/.openclaw/.env.pre-update.$(date +%F)
```

**Después:**
```bash
openclaw doctor
openclaw gateway restart
openclaw models status --probe --probe-provider glm5 --json
```

---

## Anti-Hacker Checklist

1. Gateway en loopback, NO expuesto
2. Token de 32 bytes: `openssl rand -hex 32`
3. `.env` con chmod 600
4. Prompt injection defense en AGENTS.md
5. Tooling policy: deny lo que no necesitas
6. Canales: `dmPolicy: pairing`, grupos con `requireMention`
7. Si algo raro: cerrar exposición → rotar tokens → revisar logs

---

_Extraído de TRAINER-FULL.md - 17 Feb 2026_
