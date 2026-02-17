# HEARTBEAT.md - Tareas Periódicas

## Cron Jobs Configurados

| Nombre | Horario (UTC) | Frecuencia | ID |
|--------|---------------|------------|-----|
| healthcheck:vps-daily | 06:00 | Diario | `53cc6fb2...` |
| backup:workspace | 06:00 | Diario | `f73f89dc...` |
| healthcheck:security-weekly | 09:00 Lun | Semanal | `ae1dc9d8...` |

## Heartbeat (cada 30 min)

Checks pasivos — solo respondo si algo necesita atención:

| Check | Cada cuándo | Qué hago |
|-------|-------------|----------|
| Gateway vivo | Cada heartbeat | Verificar que responde |
| Salud VPS | Cada 6 horas | RAM, disco, contenedores |
| Contenedores caídos | Cada 3 horas | `docker ps` |
| Logs de error | Cada 12 horas | Buscar errores recientes |

**Regla:** Si todo OK → `HEARTBEAT_OK`. Solo molesto si falla algo.

## Alertas (solo si falla)

| Alerta | Condición | Acción |
|--------|-----------|--------|
| RAM crítica | >90% uso | Telegram inmediato |
| Disco lleno | >85% uso | Telegram inmediato |
| Gateway caído | No responde | Telegram + intento reinicio |
| Contenedor down | Algo no corre | Telegram con nombre |

## Modelo de Seguridad

```
Identidad → ¿Quién puede hablar?
     ↓
  Scope → ¿Dónde puede actuar?
     ↓
  Modelo → Asumir que puede ser manipulado
```

## Links Importantes

- GLM-5 gratis hasta Abril 2026: https://modal.com/blog/try-glm-5
- ClawHub (skills): https://clawhub.ai/
- Docs OpenClaw: https://docs.openclaw.ai/
- GitHub: https://github.com/openclaw/openclaw
- Discord comunidad: https://discord.com/invite/clawd

### MCP (Model Context Protocol)
- Spec: https://github.com/modelcontextprotocol
- Awesome MCP: https://github.com/punkpeye/awesome-mcp-servers
- Anthropic docs: https://docs.anthropic.com/en/docs/agents-and-tools/mcp

### Agent Tooling
- LangGraph: https://langchain-ai.github.io/langgraph/
- LlamaIndex: https://docs.llamaindex.ai/
- OpenAI Responses API: https://platform.openai.com/docs/api-reference/responses

### Infra / Ops
- Tailscale Serve: https://tailscale.com/kb/1312/serve
- Caddy (HTTPS): https://caddyserver.com/docs/
- Awesome self-hosted: https://github.com/awesome-selfhosted/awesome-selfhosted

### Model Providers
- GLM Z.ai: https://z.ai/
- OpenRouter: https://openrouter.ai/

## Comandos Útiles

```bash
# Ver cron jobs
openclaw cron list

# Ejecutar job manualmente
openclaw cron run <job-id>

# Ver runs de un job
openclaw cron runs <job-id>

# Desactivar job
openclaw cron update <job-id> --enabled false
```
