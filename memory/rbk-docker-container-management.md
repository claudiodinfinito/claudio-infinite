# Runbook: Docker Container Management

**Propósito:** Gestión de containers Docker en el VPS.
**Frecuencia:** Cuando se necesite.

---

## Comandos Esenciales

| Acción | Comando |
|--------|---------|
| Listar activos | `docker ps` |
| Listar todos | `docker ps -a` |
| Iniciar | `docker start <container>` |
| Detener | `docker stop <container>` |
| Reiniciar | `docker restart <container>` |
| Eliminar | `docker rm <container>` |
| Logs | `docker logs -f <container>` |
| Entrar | `docker exec -it <container> sh` |

---

## Containers Actuales

| Container | Puerto | Uptime | Uso |
|-----------|--------|--------|-----|
| ppc-dashboard | — | 7h | Dashboard |
| pocketbase | 8090 | 3d | DB |
| n8n-mkt | 5678 | 6d | Automation |
| ollama | 11434 | 7d | LLM local |
| webui-ollama | — | 7d | Ollama UI |
| srv-captain--* | varios | 2w | CapRover |

---

## Monitoreo

### Recursos

```bash
# Uso de recursos
docker stats --no-stream

# Disco usado
docker system df
```

### Logs

```bash
# Últimas 100 líneas
docker logs <container> --tail 100

# Seguir en tiempo real
docker logs -f <container>
```

---

## Limpieza

### Imágenes no usadas

```bash
# Ver imágenes dangling
docker images -f "dangling=true"

# Eliminar imágenes no usadas
docker image prune -a
```

### Volúmenes huérfanos

```bash
# Ver volúmenes
docker volume ls

# Eliminar volúmenes no usados
docker volume prune
```

### Limpieza completa

```bash
# Sistema completo (cuidado)
docker system prune -a --volumes
```

---

## Backup de Containers

### Exportar container

```bash
docker commit <container> backup/<name>:$(date +%F)
docker save backup/<name>:$(date +%F) > /root/backups/<name>.$(date +%F).tar
```

### Importar container

```bash
docker load < /root/backups/<name>.tar
```

---

## Troubleshooting

### Container no inicia

```bash
# Ver estado
docker inspect <container>

# Ver logs de error
docker logs <container> 2>&1 | grep -i error

# Ver eventos
docker events --filter container=<container>
```

### Container sin red

```bash
# Ver redes
docker network ls

# Inspeccionar red
docker network inspect bridge

# Reconectar
docker network disconnect bridge <container>
docker network connect bridge <container>
```

### Espacio en disco lleno

```bash
# Ver uso
docker system df

# Limpiar
docker system prune -a -f
```

---

## CapRover Containers

⚠️ **NO TOCAR** containers con prefijo `srv-captain--`.

- Administrados desde captain.adwebcrm.com
- Si fallan, reiniciar desde CapRover UI
- No usar docker CLI directo

---

## Compose Files

### Ubicaciones

| Servicio | Compose |
|----------|---------|
| n8n-mkt | /root/docker/n8n/docker-compose.yml |
| ollama | /root/docker/ollama/docker-compose.yml |
| pocketbase | /root/docker/pocketbase/docker-compose.yml |

### Comandos

```bash
# Iniciar servicios
docker-compose up -d

# Detener servicios
docker-compose down

# Reiniciar un servicio
docker-compose restart <service>
```

---

_Creado: 2026-02-20 20:56 UTC - Micro-tarea autónoma_
