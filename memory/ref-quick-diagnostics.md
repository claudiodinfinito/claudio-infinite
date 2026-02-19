# Diagnósticos Rápidos del Sistema

ID: REF-DIAG-001
Tags: #diagnostics #health #vps #troubleshooting
Keys: diagnostics, health, vps, troubleshooting, quick
Last reviewed: 2026-02-19

---

## Check Rápido (30 seg)

```bash
# Gateway vivo?
openclaw gateway status

# Disco OK? (ver > 20GB libre)
df -h / | tail -1 | awk '{print $4}'

# RAM OK? (ver > 2GB libre)
free -h | grep Mem | awk '{print $7}'

# Docker containers up?
docker ps --format "table {{.Names}}\t{{.Status}}" | grep -c "Up"
```

---

## Check Medio (2 min)

```bash
# Logs recientes con errores
tail -50 /tmp/openclaw/openclaw-$(date +%Y-%m-%d).log | grep -i error

# Uso de APIs
cat memory/brave-usage.json 2>/dev/null || echo "No tracking"

# Cronjobs status
openclaw cron list 2>/dev/null | head -5

# Git sync status
git status --short
```

---

## Check Profundo (5 min)

```bash
# Todos los containers
docker ps -a --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"

# Recursos docker
docker stats --no-stream

# Logs gateway últimos 200
tail -200 /tmp/openclaw/openclaw-$(date +%Y-%m-%d).log

# Modelos disponibles
openclaw models status --probe --json 2>/dev/null | head -20
```

---

## One-Liners de Diagnóstico

| Problema | Comando |
|----------|---------|
| Gateway no responde | `systemctl --user restart openclaw-gateway` |
| Sesión bloqueada | Ver `rbk-session-locked.md` |
| Container down | `docker restart <container>` |
| Disco lleno | `du -sh /* \| sort -rh \| head -10` |
| RAM baja | `ps aux --sort=-%mem \| head -10` |

---

## Umbrales de Alerta

| Métrica | OK | Warning | Crítico |
|---------|-----|---------|---------|
| Disco libre | >50GB | 20-50GB | <20GB |
| RAM libre | >4GB | 2-4GB | <2GB |
| Containers up | 7 | 5-6 | <5 |
| Brave API | <500 | 500-1000 | >1000 |

---

_Creado: 2026-02-19 - Chequeos rápidos del sistema_
