# Emergency Recovery Procedures

**Propósito:** Procedimientos de emergencia para recuperar el sistema.
**Uso:** Cuando algo crítico falla.

---

## 🚨 Gateway Caído

### Diagnóstico

```bash
# Verificar proceso
ps aux | grep openclaw

# Ver logs
tail -100 /tmp/openclaw/openclaw-$(date +%Y-%m-%d).log

# Ver estado systemd
systemctl --user status openclaw-gateway
```

### Recuperación

```bash
# Reiniciar gateway
systemctl --user restart openclaw-gateway

# Si no funciona, kill forzado
pkill -9 -f openclaw
systemctl --user start openclaw-gateway

# Verificar
openclaw gateway status
```

---

## 🚨 Disco Lleno

### Diagnóstico

```bash
# Ver uso
df -h /

# Ver qué ocupa
du -sh /* | sort -hr | head -10
```

### Limpieza Rápida

```bash
# Logs antiguos
find /var/log -name "*.log" -mtime +7 -delete

# Docker
docker system prune -a -f --volumes

# Temporales
rm -rf /tmp/*

# OpenClaw logs antiguos
find /tmp/openclaw -name "*.log" -mtime +7 -delete
```

---

## 🚨 Container Crítico Caído

### PocketBase

```bash
# Ver estado
docker ps -a | grep pocketbase

# Reiniciar
docker restart <container-id>

# Ver logs
docker logs <container-id> --tail 50
```

### n8n

```bash
docker restart n8n-mkt
docker logs n8n-mkt --tail 50
```

### Ollama

```bash
docker restart ollama
docker logs ollama --tail 50
```

---

## 🚨 Sesión Bloqueada

```bash
# Ver locks
ls /tmp/openclaw/*.lock

# Eliminar locks
rm /tmp/openclaw/*.lock

# Reiniciar gateway
systemctl --user restart openclaw-gateway
```

---

## 🚨 Cronjobs Fallando

### Verificar

```bash
openclaw cron list | grep -i error
```

### Fix Rate Limit

```bash
# Cambiar modelo de cronjob a Gemini
# (requiere editar config)
```

---

## 🚨 API Keys Expiradas/Inválidas

### Verificar

```bash
cat /root/.openclaw/.env | grep -i key
```

### Probar

```bash
openclaw models status --probe --probe-provider glm5
```

---

## 🚨 Git Desync

```bash
# Ver estado
git status

# Descartar cambios locales (PELIGROSO)
git reset --hard HEAD

# Recuperar archivo específico
git checkout HEAD -- <file>

# Ver commits perdidos
git reflog
git checkout <commit-hash>
```

---

## 🚨 Memoria Corrupta

```bash
# Verificar archivos
ls -la memory/

# Restaurar desde último commit
git checkout HEAD -- memory/

# Ver cambios recientes
git log --oneline memory/ -10
```

---

## Contactos de Emergencia

| Servicio | Responsable |
|----------|-------------|
| **OpenClaw Gateway** | Daniel |
| **CapRover** | Daniel |
| **VPS** | Daniel |

---

## Checklist de Recuperación

1. [ ] Identificar problema (logs, estado)
2. [ ] Intentar solución documentada
3. [ ] Si falla, documentar error
4. [ ] Escalar a Daniel con contexto

---

_Creado: 2026-02-20 21:11 UTC - Micro-tarea autónoma_
