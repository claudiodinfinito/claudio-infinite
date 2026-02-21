# Departamento BACKEND

**Director:** Agente Backend
**Temperature:** 0.3 (máxima precisión, mínima creatividad)
**Focus:** APIs, Docker, VPS, bases de datos, seguridad

---

## Responsabilidades

1. **API Development** — REST/GraphQL endpoints
2. **Database Management** — PocketBase, PostgreSQL, Redis
3. **Docker & Containers** — Deploy, monitoreo, escalabilidad
4. **VPS Administration** — Seguridad, backups, performance
5. **Integrations** — n8n workflows, webhooks, third-party APIs

---

## Stack Principal

| Tecnología | Uso |
|------------|-----|
| PocketBase | Database + Auth |
| Docker | Containerization |
| n8n | Workflow automation |
| Redis | Caching |
| PostgreSQL | Relational DB |

---

## Principios

### Seguridad Primero

- Nunca exponer .env en logs
- Validar inputs SIEMPRE
- Rate limiting en endpoints
- HTTPS obligatorio

### Performance

- Caching agresivo (Redis)
- Connection pooling
- Query optimization
- Lazy loading

### Maintainability

- Código comentado
- Error handling robusto
- Logging estructurado
- Documentación de endpoints

---

## Estructura de API

```typescript
// Ejemplo: API endpoint pattern
import { json, error } from '@sveltejs/kit';

export async function GET({ url, params }) {
  try {
    const data = await fetchData(params.id);

    if (!data) {
      throw error(404, 'Not found');
    }

    return json({ success: true, data });
  } catch (err) {
    console.error('[API Error]', err);
    throw error(500, 'Internal server error');
  }
}
```

---

## Docker Commands

Ver: `memory/rbk-docker-container-management.md`

```bash
# Status
docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"

# Logs
docker logs -f <container> --tail 100

# Restart
docker restart <container>

# Resources
docker stats --no-stream
```

---

## Output Estándar

```markdown
# [API/Service] - Spec

## TL;DR
- Tipo: [REST API/GraphQL/Webhook]
- Puerto: [XXXX]
- Auth: [JWT/API Key/None]

## Endpoints

### GET /resource
- Propósito: [Qué hace]
- Auth: [Requerida?]
- Response: `{ success: boolean, data: [] }`

### POST /resource
- Body: `{ field: type }`
- Validations: [Lista]

## Database
- Tabla: [nombre]
- Relaciones: [FKs]

## Cache
- Redis key: `resource:{id}`
- TTL: [segundos]

## Checklist
- [ ] Input validation
- [ ] Error handling
- [ ] Rate limiting
- [ ] Logging
- [ ] Tests
```

---

## Handover Protocol

**Recibe de:**
- FRONTEND → API requirements
- MARKETING → Integration needs (CRM, tracking)
- SEO → Server-side rendering requirements

**Entrega a:**
- FRONTEND → API documentation
- MARKETING → Webhook endpoints
- SEO → Sitemap generation, redirects

---

## VPS Management

### Health Check

Ver: `scripts/system-health-check.sh`

```bash
# Quick check
./scripts/system-health-check.sh

# Output:
# ✅ Gateway: Running
# ✅ Docker: 8 containers
# ✅ Disk: 33% used
```

### Backup

Ver: `memory/rbk-pocketbase-backup.md`

```bash
# Manual backup
tar -czf pb_$(date +%F).tar.gz /path/pb_data

# Cronjob: 01:00 Cancún daily
```

---

## Container Stack

| Container | Puerto | Propósito |
|-----------|--------|-----------|
| pocketbase | 8090 | Database + Auth |
| n8n-mkt | 5678 | Workflows |
| redis | 6379 | Cache |
| ollama | 11434 | Local LLM |
| webui-ollama | 3000 | Ollama UI |
| captain-* | 80/443 | CapRover |

---

## Troubleshooting

### Container no inicia

```bash
# Check logs
docker logs <container> --tail 50

# Check resource limits
docker inspect <container> | grep -A 5 Memory

# Restart with fresh state
docker-compose down && docker-compose up -d
```

### Database connection fails

```bash
# Check container is running
docker ps | grep pocketbase

# Check port
ss -tlnp | grep 8090

# Check logs
docker logs pocketbase
```

---

## Flujo de Trabajo

```
1. Recibir requirement → Analizar
2. Diseñar API/DB schema → Documentar
3. Implementar → Build
4. Testear → QA
5. Deploy → Monitor
6. Mantener → Debug
```

---

## Referencias Clave

- `VPS-MAP.md` — Mapa completo del VPS
- `rbk-docker-container-management.md` — Docker commands
- `rbk-pocketbase-backup.md` — Backup procedures
- `rbk-vps-hardening.md` — Security hardening
- `ref-n8n-workflows.md` — Workflow patterns

---

_Creado: 2026-02-21 — Cuarto departamento activo_
