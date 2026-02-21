# Runbook: VPS Hardening (UFW & SSH)

**Propósito:** Mejorar la seguridad del VPS configurando el firewall y endureciendo SSH.
**Fuente:** Item #3 de `ref-interests-real-100.md`.
**Estado:** ⚠️ DOCUMENTACIÓN SOLAMENTE (No ejecutar sin permiso de Daniel).

---

## 🛡️ Firewall (UFW)

El firewall actual está desactivado. Pasos para activarlo con seguridad:

```bash
# 1. Instalar (si no está)
apt update && apt install ufw -y

# 2. Configurar políticas por defecto (denegar todo el tráfico entrante)
ufw default deny incoming
ufw default allow outgoing

# 3. PERMITIR SSH PRIMERO (Crucial para no perder acceso)
# Si usas un puerto custom (ej: 2222), cámbialo aquí.
ufw allow 22/tcp

# 4. Permitir puertos críticos de OpenClaw y apps
ufw allow 80/tcp     # HTTP
ufw allow 443/tcp    # HTTPS
ufw allow 18789/tcp  # OpenClaw Gateway (si se accede desde fuera)
ufw allow 8090/tcp   # PocketBase

# 5. Activar firewall
ufw enable

# 6. Verificar estado
ufw status numbered
```

---

## 🔑 SSH Hardening

Configuración para `/etc/ssh/sshd_config`:

| Parámetro | Valor | Por qué |
|-----------|-------|---------|
| `PermitRootLogin` | `prohibit-password` | Solo permite root via SSH key |
| `PasswordAuthentication` | `no` | Fuerza el uso de SSH keys |
| `PubkeyAuthentication` | `yes` | Habilita SSH keys |
| `Port` | `22` | Cambiar a puerto custom (ej: 2222) reduce ataques de bots |

### Pasos para aplicar:

1. **Testear login con llave:** Asegúrate de que puedes entrar con tu llave antes de apagar passwords.
2. **Editar config:** `nano /etc/ssh/sshd_config`
3. **Validar config:** `sshd -t`
4. **Reiniciar servicio:** `systemctl restart ssh`

---

## 🚨 Fail2Ban

Protección contra ataques de fuerza bruta.

```bash
# Instalar
apt install fail2ban -y

# Configurar copia local
cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local

# Iniciar y habilitar
systemctl start fail2ban
systemctl enable fail2ban
```

---

## 📝 Checklist de Seguridad

- [ ] UFW Activo y reglas verificadas.
- [ ] SSH Password Authentication: OFF.
- [ ] SSH Root Login: Keys only.
- [ ] Fail2Ban corriendo.
- [ ] Actualizaciones automáticas de seguridad (`unattended-upgrades`).

---

_Creado: 2026-02-21 00:55 UTC - Micro-tarea autónoma (3 min)_
