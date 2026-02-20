# Docker Containers Audit - 2026-02-20

ID: REF-DOCKER-001
Status: active
Tags: #docker #audit #vps #containers
Keys: docker, containers, audit, resources

---

## Containers Activos (8)

| Container | Image | Uptime | Mem | CPU | Propósito |
|-----------|-------|--------|-----|-----|-----------|
| **ppc-dashboard** | captain-a1-ppc-dashboard | 12h | 23MB | 0% | Dashboard cliente |
| **pocketbase** | captain-a1-pocketbase | 3d | 86MB | 0% | Base de datos |
| **n8n-mkt** | captain-n8n-mkt-a1 | 6d | 378MB | 0.27% | Automatizaciones |
| **ollama** | captain-a1-ollama | 7d | 29MB | 0% | LLM local |
| **webui-ollama** | captain-a1-webui-ollama | 7d | 537MB | 0.51% | UI para Ollama |
| **certbot** | caprover/certbot | 2w | 29MB | 0% | SSL certs |
| **nginx** | nginx:1.27.2 | 2w | 35MB | 0% | Reverse proxy |
| **captain** | caprover/caprover | 2w | 73MB | 0% | CapRover dashboard |

---

## Recursos Totales

| Métrica | Valor |
|---------|-------|
| **RAM usada por containers** | 1.16GB |
| **RAM disponible** | 5.6GB |
| **Uso** | 15% |
| **CPU** | <1% |

---

## Observaciones

1. **n8n-mkt** consume más RAM (378MB) — normal para n8n
2. **webui-ollama** consume 537MB — UI pesada
3. **Ollama** solo 29MB — no tiene modelo cargado
4. **CapRover** (nginx + captain + certbot) = 137MB total

---

## Recomendaciones

1. **Ollama no tiene modelo cargado** — cargar uno para testing
2. **n8n podría optimizarse** — revisar workflows pesados
3. **Todo saludable** — sin alertas

---

_Audit completado: 2026-02-20 11:15 UTC_
