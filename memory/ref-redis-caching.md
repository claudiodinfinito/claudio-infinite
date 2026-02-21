# Redis Caching Reference

**Propósito:** Redis como capa de caching para mejorar performance.
**Fuente:** Item #5 de `ref-interests-real-100.md`

---

## ¿Qué es Redis?

In-memory data structure store, usado como cache para acelerar aplicaciones.

| Sin Redis | Con Redis |
|-----------|-----------|
| DB queries cada request | Cache en memoria |
| 100-500ms response time | 1-5ms response time |
| DB bajo carga | DB aliviada |

---

## Casos de Uso

| Uso | Beneficio |
|-----|-----------|
| **Session storage** | Sesiones rápidas |
| **API response cache** | Reducir latency |
| **Rate limiting** | Control de tráfico |
| **Leaderboards** | Sorted sets |
| **Pub/Sub** | Mensajería en tiempo real |

---

## Docker Setup

```bash
# Crear container Redis
docker run -d \
  --name redis \
  -p 6379:6379 \
  redis:alpine

# Verificar
docker exec -it redis redis-cli ping
# Output: PONG
```

---

## Comandos Básicos

```bash
# SET
redis-cli SET clave "valor"

# GET
redis-cli GET clave

# SET con expiración (segundos)
redis-cli SETEX session:123 3600 "user_data"

# DEL
redis-cli DEL clave

# Ver todas las claves
redis-cli KEYS *
```

---

## TTL (Time To Live)

| Comando | Descripción |
|---------|-------------|
| `TTL clave` | Segundos restantes |
| `EXPIRE clave 60` | Expira en 60 segundos |
| `PERSIST clave` | Elimina expiración |

---

## En Aplicaciones

### Node.js
```javascript
const redis = require('redis');
const client = redis.createClient({ url: 'redis://localhost:6379' });

await client.connect();

// Cache
await client.set('key', 'value', { EX: 3600 }); // 1 hora

// Get
const value = await client.get('key');
```

### Python
```python
import redis
r = redis.Redis(host='localhost', port=6379)

# Cache
r.set('key', 'value', ex=3600)

# Get
value = r.get('key')
```

---

## Estrategias de Caching

### Cache-Aside
```
1. App busca en Redis
2. Si no está → busca en DB
3. Guarda en Redis
4. Retorna
```

### Write-Through
```
1. App escribe en Redis Y DB
2. Lectura siempre de Redis
```

---

## Monitoreo

```bash
# Info general
redis-cli INFO

# Memoria usada
redis-cli INFO memory

# Estadísticas
redis-cli INFO stats

# Clientes conectados
redis-cli CLIENT LIST
```

---

## En OpenClaw

- No implementado aún
- Potencial: cachear respuestas frecuentes
- Reducir carga en PocketBase

---

_Creado: 2026-02-21 01:11 UTC - Micro-tarea (3 min)_
