# Quick Actions: Common Tasks

**Propósito:** Acciones comunes que Daniel me pide ejecutar.
**Uso:** Referencia rápida de qué hacer cuando pide algo.

---

## 🔍 Investigación

### "Investiga [tema]"

```bash
# 1. Buscar web
web_search query="tema"

# 2. Crear referencia
write memory/ref-tema.md

# 3. Indexar
edit memory/index.md

# 4. Commit
git commit -m "docs(memory): add tema reference"
```

---

## 📊 Status Checks

### "¿Cómo está el sistema?"

```bash
# Containers
docker ps --format "table {{.Names}}\t{{.Status}}"

# Disco
df -h /

# RAM
free -h

# Gateway
openclaw gateway status
```

---

## 🐛 Debugging

### "No funciona [X]"

```bash
# 1. Ver logs
tail -100 /tmp/openclaw/openclaw-$(date +%Y-%m-%d).log

# 2. Verificar proceso
ps aux | grep X

# 3. Ver logs específicos
docker logs <container> --tail 50

# 4. Consultar runbook
cat memory/rbk-*.md | grep -A 20 "X"
```

---

## 💾 Backups

### "Haz backup de [X]"

```bash
# PocketBase
tar -czf /root/respaldos_pocketbase/pb_$(date +%F).tar.gz /ruta/pb_data

# Workspace (ya en git)
git add . && git commit -m "backup: $(date +%F)"
```

---

## 🔄 Reinicios

### "Reinicia [container/servicio]"

```bash
# Container Docker
docker restart <container>

# Gateway
systemctl --user restart openclaw-gateway

# Sistema (cuidado)
reboot
```

---

## 📝 Documentación

### "Documenta [algo]"

```bash
# 1. Crear archivo
write memory/ref-<nombre>.md

# 2. Añadir header estándar
# **Propósito:** ...
# **Fuente:** ...
# **Uso:** ...

# 3. Indexar
edit memory/index.md

# 4. Commit
git add memory/ && git commit -m "docs(memory): add <nombre> reference"
```

---

## 🔧 Configuración

### "Cambia [config]"

⚠️ **Siempre preguntar antes de cambios destructivos.**

```bash
# Ver config actual
cat /root/.openclaw/openclaw.json

# Editar (con backup)
cp config config.bak
# Editar...

# Aplicar cambios
systemctl --user restart openclaw-gateway
```

---

## 📊 Reportes

### "Dame un reporte de [X]"

```bash
# Uso de APIs
cat memory/brave-usage.json

# Commits hoy
git log --oneline --since="midnight"

# Archivos creados
git ls-files -o --exclude-standard

# Estado containers
docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"
```

---

## 🚀 Deploy/Update

### "Actualiza [algo]"

```bash
# OpenClaw
openclaw gateway update

# Container
docker pull <image>
docker stop <container>
docker rm <container>
docker run <new-container>

# Sistema
apt update && apt upgrade -y
```

---

## 🔐 Seguridad

### "Verifica seguridad"

```bash
# SSH logs
tail -50 /var/log/auth.log

# Usuarios conectados
who

# Puertos abiertos
ss -tlnp

# Procesos sospechosos
ps aux --sort=-%cpu | head -10
```

---

## ❓ Preguntas Frecuentes

| Pregunta | Respuesta |
|----------|-----------|
| "¿Qué commit es este?" | `git log --oneline -1` |
| "¿Qué cambió?" | `git diff HEAD~1` |
| "¿Dónde está X?" | `find / -name "*X*" 2>/dev/null` |
| "¿Cuánto espacio queda?" | `df -h /` |
| "¿Qué logs hay?" | `ls /tmp/openclaw/*.log` |

---

## 🎯 Tareas Específicas

### "Crea un runbook para [proceso]"

```bash
# Template
write memory/rbk-<nombre>.md

# Estructura:
# - Propósito
# - Síntomas
# - Diagnóstico
# - Solución
# - Prevención

# Indexar
edit memory/runbooks-index.md
git commit -m "docs(memory): add <nombre> runbook"
```

### "Genera un spec para [sistema]"

```bash
# Template
write memory/spec-<nombre>.md

# Estructura:
# - Propósito
# - Concepto
# - Implementación
# - Métricas
# - Estado

# Indexar
edit memory/specs-index.md
git commit -m "docs(memory): add <nombre> spec"
```

### "Investiga y documenta [tema]"

```bash
# 1. Buscar
web_search query="<tema>"

# 2. Crear referencia
write memory/ref-<tema>.md

# 3. Estructura:
# - Propósito
# - Concepto
# - Detalles en bullets
# - Referencias

# 4. Indexar
edit memory/index.md
git commit -m "docs(memory): add <tema> reference"
```

---

## 🔄 Comandos de Emergencia

### Todo falla

```bash
# 1. Verificar estado
docker ps
df -h
free -h
openclaw gateway status

# 2. Reiniciar todo
docker restart $(docker ps -q)
systemctl --user restart openclaw-gateway

# 3. Ver logs
tail -100 /tmp/openclaw/openclaw-$(date +%Y-%m-%d).log

# 4. Consultar runbook
cat memory/rbk-emergency-recovery.md
```

---

_Creado: 2026-02-20 21:51 UTC - Micro-tarea autónoma_
