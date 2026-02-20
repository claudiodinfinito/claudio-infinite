# Command Cheat Sheet: VPS Management

**Propósito:** Comandos esenciales para gestionar el VPS.
**Uso:** Referencia rápida.

---

## Sistema

### Estado

```bash
# Uptime
uptime

# Memoria
free -h

# Disco
df -h

# Procesos
top -n 1 | head -20
```

### Usuarios y Permisos

```bash
# Quién está conectado
who

# Últimos logins
last | head -10

# Permisos archivo
ls -la /ruta/archivo
```

---

## Red

### Puertos y Conexiones

```bash
# Puertos abiertos
ss -tlnp

# Conexiones activas
ss -tunap

# Proceso en puerto
lsof -i :PUERTO
```

### DNS

```bash
# Resolver dominio
dig google.com

# Verificar DNS
nslookup google.com
```

---

## Procesos

### Gestión

```bash
# Ver procesos por uso
ps aux --sort=-%mem | head -10
ps aux --sort=-%cpu | head -10

# Matar proceso
kill -9 PID

# Ver árbol de procesos
pstree -p
```

### Background

```bash
# Ejecutar en background
comando &

# Ver jobs
jobs

# Traer a foreground
fg %1
```

---

## Logs

### Sistema

```bash
# Syslog
tail -f /var/log/syslog

# Auth log
tail -f /var/log/auth.log

# Kernel
dmesg | tail -50
```

### OpenClaw

```bash
# Gateway
journalctl --user -u openclaw-gateway -f

# Logs diarios
tail -f /tmp/openclaw/openclaw-$(date +%Y-%m-%d).log
```

---

## Cron

```bash
# Crontab usuario
crontab -l

# Editar crontab
crontab -e

# Logs cron
grep CRON /var/log/syslog | tail -20
```

---

## Systemd

```bash
# Servicios de sistema
systemctl list-units --type=service

# Servicios de usuario
systemctl --user list-units --type=service

# Estado servicio
systemctl status SERVICIO

# Logs servicio
journalctl -u SERVICIO -f
```

---

## SSH

```bash
# Generar key
ssh-keygen -t ed25519 -C "email@ejemplo.com"

# Copiar key a servidor
ssh-copy-id usuario@servidor

# Conectar con key específica
ssh -i ~/.ssh/key usuario@servidor
```

---

## File Management

### Búsqueda

```bash
# Buscar archivo
find / -name "archivo*" 2>/dev/null

# Buscar contenido
grep -r "texto" /ruta/

# Archivos grandes
find / -size +100M 2>/dev/null
```

### Compresión

```bash
# Comprimir
tar -czf archivo.tar.gz /ruta/

# Descomprimir
tar -xzf archivo.tar.gz

# Ver contenido
tar -tzf archivo.tar.gz
```

---

## Network Troubleshooting

```bash
# Ping
ping -c 4 google.com

# Trace route
traceroute google.com

# Descargar archivo
curl -O URL
wget URL

# Ver IP pública
curl ifconfig.me
```

---

## Maintenance

```bash
# Actualizar paquetes (Debian/Ubuntu)
apt update && apt upgrade -y

# Limpiar paquetes
apt autoremove -y
apt clean

# Reiniciar
reboot

# Apagar
shutdown -h now
```

---

## Docker Quick

```bash
docker ps                           # Containers activos
docker stats --no-stream            # Recursos
docker system df                    # Disco usado
docker system prune -a -f           # Limpieza
```

---

## One-Liners Útiles

```bash
# Top 10 archivos más grandes
du -ah / | sort -hr | head -10

# Contar archivos por extensión
find . -type f | sed 's/.*\.//' | sort | uniq -c | sort -nr

# Ver procesos ordenados por RAM
ps aux --sort=-%mem | head -10

# Matar todos los procesos de un usuario
pkill -u usuario

# Espacio usado por directorio
du -sh /* | sort -hr | head -10
```

---

_Creado: 2026-02-20 21:26 UTC - Micro-tarea autónoma_
