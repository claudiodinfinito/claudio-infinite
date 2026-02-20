# Decision Tree de Troubleshooting

ID: REF-TRIAGE-001
Tags: #troubleshooting #decision-tree #triage #diagnostics
Keys: troubleshooting, decision-tree, triage, symptoms, runbooks
Last reviewed: 2026-02-20

---

## Cómo usar este archivo

1. Identifica el **síntoma** (columna izquierda)
2. Ve al **archivo** indicado
3. Ejecuta el **primer comando** de diagnóstico

---

## Gateway Issues

| Síntoma | Archivo | Primer comando |
|---------|---------|----------------|
| Gateway no responde | `rbk-gateway-restart.md` | `openclaw gateway status` |
| Sesión bloqueada | `rbk-session-locked.md` | `ls -la /tmp/openclaw/*.lock` |
| Heartbeat no funciona | `ts-heartbeat-no-funciona.md` | Check rate limit GLM-5 |
| Cronjob delivery failed | `ts-cron-delivery-fixed.md` | Ver si es rate limit |

## Rate Limit Issues

| Síntoma | Causa | Solución |
|---------|-------|----------|
| GLM-5 429 error | 1 request concurrente máximo | Esperar o usar Gemini |
| Gemini agotado | 20 requests/día | Esperar reset (00:00 UTC) |
| Brave API limit | 1,500/mes | Tracking en `brave-usage.json` |

## Container Issues

| Síntoma | Comando | Acción |
|---------|---------|--------|
| Container down | `docker ps -a` | `docker restart <name>` |
| Logs con errores | `docker logs <name> \| tail -50` | Analizar output |
| Puerto ocupado | `netstat -tlnp \| grep <port>` | Matar proceso o cambiar puerto |

## Telegram Issues

| Síntoma | Archivo | Causa probable |
|---------|---------|----------------|
| No responde | `ts-telegram-no-reply.md` | Token inválido o gateway down |
| Sin typing indicator | `ts-telegram-no-reply.md` | Channel config |

## VPS Issues

| Síntoma | Comando | Umbral |
|---------|---------|--------|
| Disco lleno | `df -h /` | <20GB crítico |
| RAM baja | `free -h` | <2GB crítico |
| CPU alta | `top -b -n1 \| head -20` | >80% sostenido |

## File System Issues

| Síntoma | Comando | Acción |
|---------|---------|--------|
| .lock huérfanos | `find /tmp -name "*.lock" -mtime +1` | Eliminar |
| Logs antiguos | `find /tmp -name "*.log" -mtime +30` | Eliminar |
| Permisos wrong | `ls -la` | chmod 600 para secrets |

---

## Flujo de Triage

```
START
  │
  ├─► ¿Gateway responde?
  │     NO → rbk-gateway-restart.md
  │     SÍ ↓
  │
  ├─► ¿Rate limit?
  │     SÍ → Esperar o usar otro modelo
  │     NO ↓
  │
  ├─► ¿Container down?
  │     SÍ → docker restart
  │     NO ↓
  │
  ├─► ¿Recurso bajo (RAM/disco)?
  │     SÍ → Limpiar o escalar
  │     NO ↓
  │
  └─► Buscar en TS-* o RBK-*
```

---

## Archivos de Troubleshooting por Categoría

### Gateway
- `rbk-gateway-restart.md` — Reinicio seguro
- `rbk-session-locked.md` — Sesión bloqueada
- `ts-heartbeat-no-funciona.md` — Heartbeat issues

### Rate Limits
- `ts-glm5-rate-limit.md` — GLM-5 específico
- `ref-model-limits.md` — Todos los límites

### Cronjobs
- `ts-cron-delivery-failed.md` — Delivery falla
- `ts-cron-delivery-fixed.md` — Solución aplicada

### Config
- `ts-config-missing.md` — Config incompleta
- `ts-audit-config-slim.md` — Auditoría completa

---

## Escalamiento

Si ningún archivo resuelve el problema:

1. **Buscar en logs:** `tail -200 /tmp/openclaw/openclaw-$(date +%Y-%m-%d).log`
2. **Crear nuevo TS:** Copiar template de `ts-*.md` existente
3. **Documentar solución:** Añadir a este archivo

---

_Creado: 2026-02-20 - Micro-tarea 01:45 UTC_
