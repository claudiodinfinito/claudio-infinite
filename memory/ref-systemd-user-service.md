# Systemd User Service Autostart Reference

**Propósito:** Servicios systemd de usuario para auto-arranque.
**Fuente:** Item #100 de ref-interests-real-100.md

---

## Concepto

Systemd user services se ejecutan sin root, permitiendo que usuarios normales gestionen sus propios servicios.

---

## Ubicación

| Tipo | Ruta |
|------|------|
| **Servicios de usuario** | `~/.config/systemd/user/` |
| **Servicios de sistema** | `/etc/systemd/system/` |

---

## Crear Servicio de Usuario

### Ejemplo: OpenClaw Gateway

```bash
# Crear directorio
mkdir -p ~/.config/systemd/user

# Crear servicio
cat > ~/.config/systemd/user/openclaw-gateway.service << 'EOF'
[Unit]
Description=OpenClaw Gateway
After=network.target

[Service]
Type=simple
ExecStart=/usr/local/bin/openclaw gateway start
Restart=on-failure
RestartSec=5

[Install]
WantedBy=default.target
EOF
```

---

## Comandos User Services

| Comando | Descripción |
|---------|-------------|
| `systemctl --user start SERVICE` | Iniciar servicio |
| `systemctl --user stop SERVICE` | Detener servicio |
| `systemctl --user enable SERVICE` | Habilitar autostart |
| `systemctl --user disable SERVICE` | Deshabilitar autostart |
| `systemctl --user status SERVICE` | Ver estado |
| `systemctl --user list-units` | Listar servicios |
| `systemctl --user daemon-reload` | Recargar configuración |

---

## Autostart al Arrancar

### Opción 1: default.target

```bash
# Habilitar servicio
systemctl --user enable openclaw-gateway.service

# Verificar default target
systemctl --user get-default
```

### Opción 2: linger (para servicios sin login)

```bash
# Habilitar linger para el usuario
sudo loginctl enable-linger $USER

# Esto permite que los user services inicien al boot
# incluso sin sesión activa
```

---

## Verificar Linger

```bash
# Ver si linger está habilitado
ls /var/lib/systemd/linger

# Si aparece el usuario, está habilitado
```

---

## Logs

```bash
# Ver logs de user service
journalctl --user -u openclaw-gateway.service -f

# Ver todos los logs de usuario
journalctl --user -f
```

---

## Ejemplo Real: OpenClaw

### Estado Actual

```bash
# Ver si OpenClaw usa systemd
systemctl --user status openclaw-gateway 2>/dev/null || echo "No configurado como user service"

# Ver servicio de sistema (si existe)
systemctl status openclaw-gateway 2>/dev/null || echo "No configurado como system service"
```

### Migración a User Service

Beneficios:
- No requiere sudo
- Se reinicia con el usuario
- Logs accesibles sin root

---

## Diferencias System vs User

| Aspecto | System Service | User Service |
|---------|----------------|--------------|
| **Permisos** | Root | Usuario normal |
| **Autostart** | Al boot | Al login (o con linger) |
| **Comando** | `systemctl` | `systemctl --user` |
| **Ruta** | `/etc/systemd/system/` | `~/.config/systemd/user/` |
| **Logs** | `journalctl -u` | `journalctl --user -u` |

---

## Casos de Uso para OpenClaw

| Servicio | Tipo recomendado |
|----------|------------------|
| **Gateway** | User service + linger |
| **Cron scheduler** | User service + linger |
| **Docker containers** | System service (root) |

---

## Troubleshooting

### Servicio no inicia al boot

```bash
# Verificar linger
ls /var/lib/systemd/linger

# Si no está, habilitarlo
sudo loginctl enable-linger $USER

# Verificar que está enabled
systemctl --user is-enabled openclaw-gateway
```

### Ver dependencias

```bash
systemctl --user list-dependencies openclaw-gateway.service
```

---

_Creado: 2026-02-20 20:41 UTC - Micro-tarea autónoma_
