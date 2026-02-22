# Gateway Uptime Tracking

ID: TRK-GATEWAY-001
Tags: #gateway #uptime #monitoring #health #systemd
Keys: gateway, uptime, monitoring, health, systemd, logs
Last reviewed: 2026-02-22

---

## Estado Actual (2026-02-22 04:20 UTC)

| Métrica | Valor |
|---------|-------|
| **Gateway status** | ✅ Active (running) |
| **Uptime gateway** | 7h (desde 2026-02-21 20:49:06 UTC) |
| **Uptime VPS** | 2 semanas, 4 días (desde 2026-02-03) |
| **Memoria** | 1.5GB |
| **CPU** | 20min acumulados |
| **Log size** | 11MB |

---

## Errores Detectados

| Tipo | Cantidad | Severidad |
|------|----------|-----------|
| Rate limit GLM-5 | 130 | Media (esperar) |
| Errores últimos 100 líneas | 8 | Baja (operativo) |

**Últimos rate limits:** 2026-02-22 04:13 UTC

---

## Comandos de Verificación

```bash
# Estado gateway
systemctl --user status openclaw-gateway --no-pager

# Uptime VPS
uptime

# Errores recientes
tail -100 /tmp/openclaw/openclaw.log | grep -i error

# Rate limits
grep -c "rate limit" /tmp/openclaw/openclaw.log

# Reiniciar gateway si cae
systemctl --user restart openclaw-gateway
```

---

## Historial de Uptime

| Fecha | Uptime gateway | Reinicios | Notas |
|-------|----------------|-----------|-------|
| 2026-02-22 | 7h | 0 | Estable |
| 2026-02-21 | ? | 1 | Reinicio por cambios |
| 2026-02-20 | ? | 1 | Reinicio por config |

---

## Alertas

| Métrica | Umbral | Acción |
|---------|--------|--------|
| Gateway down | N/A | `systemctl --user restart` |
| Memoria > 2GB | Monitor | Posible leak |
| Log > 50MB | Rotar | `rm /tmp/openclaw/openclaw.log` |
| Rate limits > 50/día | Reducir carga | Usar más Gemini |

---

## Logs

**Ubicación:** `/tmp/openclaw/openclaw.log`

**Rotación:** Manual (no hay logrotate configurado)

**Tamaño actual:** 11MB

**Para limpiar:**
```bash
# Backup + limpiar
cp /tmp/openclaw/openclaw.log /tmp/openclaw/openclaw-$(date +%Y%m%d).log.bak
> /tmp/openclaw/openclaw.log
```

---

## systemd Service

**Archivo:** `/root/.config/systemd/user/openclaw-gateway.service`

**Estado:** enabled (autostart)

**Verificar:**
```bash
systemctl --user is-enabled openclaw-gateway
systemctl --user is-active openclaw-gateway
```

---

## Dependencias

- Node.js v22.22.0
- Docker (para containers sandbox)
- systemd user service

---

_Creado: 2026-02-22 04:21 UTC - Tarea autónoma GEMINI #57_
