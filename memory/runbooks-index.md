# Runbooks Index

**Propósito:** Índice rápido de todos los runbooks disponibles.
**Uso:** Consultar cuando hay un problema específico.

---

## Por Categoría

### 🔧 Sistema

| Runbook | Problema | Archivo |
|---------|----------|---------|
| Session locked | Sesión bloqueada | `rbk-session-locked.md` |
| Gateway restart | Gateway no responde | `rbk-gateway-restart.md` |
| Cronjob errors | Cronjobs fallando | `rbk-cronjob-errors.md` |
| Emergency recovery | Emergencias críticas | `rbk-emergency-recovery.md` |

### 🐳 Docker

| Runbook | Problema | Archivo |
|---------|----------|---------|
| Container management | Gestión containers | `rbk-docker-container-management.md` |

### 💾 Backup

| Runbook | Problema | Archivo |
|---------|----------|---------|
| PocketBase backup | Backup base de datos | `rbk-pocketbase-backup.md` |
| Git remote setup | Configurar repositorio | `rbk-git-remote-setup.md` |

### 🔍 Debugging

| Runbook | Problema | Archivo |
|---------|----------|---------|
| Triage | Loop de debugging | `rbk-triage.md` |

---

## Flujo de Diagnóstico

```
Problema
    ↓
¿Qué tipo es?
├── Sistema → rbk-emergency-recovery.md
├── Docker → rbk-docker-container-management.md
├── Gateway → rbk-gateway-restart.md
├── Cronjob → rbk-cronjob-errors.md
├── Backup → rbk-pocketbase-backup.md
└── Debug → rbk-triage.md
```

---

## Acceso Rápido

### Gateway caído
```bash
systemctl --user restart openclaw-gateway
# Ver: rbk-gateway-restart.md
```

### Container caído
```bash
docker restart <container>
# Ver: rbk-docker-container-management.md
```

### Sesión bloqueada
```bash
rm /tmp/openclaw/*.lock
# Ver: rbk-session-locked.md
```

### Cronjob falla
```bash
openclaw cron list | grep error
# Ver: rbk-cronjob-errors.md
```

### Disco lleno
```bash
docker system prune -a -f
# Ver: rbk-emergency-recovery.md
```

---

## Runbooks Totales: 7

| Categoría | Cantidad |
|-----------|----------|
| Sistema | 4 |
| Docker | 1 |
| Backup | 2 |
| Debugging | 1 |

---

_Creado: 2026-02-20 21:16 UTC - Micro-tarea autónoma_
