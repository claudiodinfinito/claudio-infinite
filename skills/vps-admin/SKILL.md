---
name: vps-admin
description: Administración del VPS RackNerd con CapRover y Docker. Incluye gestión de contenedores, apps CapRover, monitoreo de recursos, backups, y mantenimiento del servidor. Usar cuando Daniel pida ayuda con Docker, CapRover, SSH, firewall, actualizaciones del VPS, o troubleshooting de apps.
---

# VPS Admin - Administración del Servidor

## Contexto

Este skill es para administrar el VPS RackNerd de Daniel:
- **Hostname**: racknerd-8bf9cb7
- **IP**: 192.227.249.251
- **OS**: Ubuntu 22.04.5 LTS
- **Stack**: CapRover + Docker + OpenClaw

## CapRover

### Apps desplegadas:
- `a1-pocketbase` — Base de datos (puerto 8090)
- `a1-ollama` — LLM local (puerto 11434)
- `a1-webui-ollama` — UI para Ollama (puerto 8080)
- `n8n-mkt-a1` — Automatizaciones (puerto 5678)
- `a1-ppc-dashboard` — Dashboard (puerto 3000)
- `open-claudio-infinito` — OpenClaw en Docker

### Comandos útiles:

```bash
# Ver estado de todos los contenedores
docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"

# Logs de app específica
docker logs -f srv-captain--<app-name>.1.<id>

# Reiniciar app
docker restart srv-captain--<app-name>.1.<id>

# Ver uso de recursos
docker stats --no-stream

# Entrar a contenedor
docker exec -it <container-name> sh
```

## Monitoreo

```bash
# RAM y CPU
free -h && top -bn1 | head -20

# Disco
df -h

# Procesos pesados
ps aux --sort=-%mem | head -10

# Conexiones activas
ss -tunap | head -20
```

## Mantenimiento

```bash
# Actualizaciones de seguridad
apt update && apt list --upgradable

# Limpiar Docker
docker system prune -f

# Limpiar imágenes sin usar
docker image prune -a -f

# Ver volúmenes huérfanos
docker volume ls -qf dangling=true
```

## Backups

### Volúmenes importantes:
- `captain--openclawdata` — Datos de OpenClaw
- `captain--persistent` — Datos persistentes de PocketBase
- `captain--memoria` — Memoria/datos varios

### Backup manual:
```bash
# Backup de volumen
docker run --rm -v <volume-name>:/data -v $(pwd):/backup alpine tar czf /backup/<volume-name>-$(date +%Y%m%d).tar.gz /data
```

## Troubleshooting

### App no responde:
1. `docker logs <container>` — ver errores
2. `docker restart <container>` — reiniciar
3. `docker ps -a` — ver si está corriendo
4. Verificar puertos: `ss -tlnp | grep <puerto>`

### Alto uso de RAM:
1. `docker stats` — ver qué contenedor consume
2. `ps aux --sort=-%mem` — procesos pesados
3. Considerar limitar recursos en CapRover

### Disco lleno:
1. `df -h` — ver uso
2. `docker system df` — uso de Docker
3. `docker system prune -f` — limpiar
4. `journalctl --vacuum-size=100M` — limpiar logs systemd

## Seguridad

Ver skill `healthcheck` para hardening completo.

### Quick fixes:
```bash
# Verificar SSH
grep -E "^(PermitRootLogin|PasswordAuthentication)" /etc/ssh/sshd_config

# Verificar firewall
ufw status

# Ver logs de acceso
last -n 20
```

## Notas

- OpenClaw corre como servicio systemd (principal) Y en Docker (secundario)
- El gateway principal está en 127.0.0.1:18789
- CapRover maneja los dominios y SSL automáticamente
