# MCP (Model Context Protocol) Reference

**Propósito:** Documentar MCP para conectar Claude con fuentes de datos externas.
**Beneficio:** Claude puede acceder a PocketBase, APIs, bases de datos en tiempo real.

---

## ¿Qué es MCP?

Protocolo abierto de Anthropic para conectar LLMs con fuentes de datos externas sin código custom.

| Sin MCP | Con MCP |
|---------|---------|
| Claude no ve tus datos | Claude accede a PocketBase, APIs, DBs |
| Pegar contexto manual | Conexión automática |
| Contexto limitado | Datos en tiempo real |

---

## Arquitectura

```
Claude Desktop/Client
        ↓
    MCP Client
        ↓
    MCP Server (connector)
        ↓
    Data Source (PocketBase, DB, API)
```

---

## Tipos de Recursos MCP

| Tipo | Ejemplo |
|------|---------|
| Resources | Archivos, registros DB |
| Prompts | Templates predefinidos |
| Tools | Funciones ejecutables |

---

## MCP Servers Disponibles

| Servidor | Conecta con |
|----------|-------------|
| `@modelcontextprotocol/server-filesystem` | Archivos locales |
| `@modelcontextprotocol/server-postgres` | PostgreSQL |
| `@modelcontextprotocol/server-sqlite` | SQLite |
| `@modelcontextprotocol/server-github` | GitHub API |
| `@modelcontextprotocol/server-brave-search` | Brave Search |

---

## Instalación

```bash
# Claude Desktop config
~/Library/Application Support/Claude/claude_desktop_config.json
```

```json
{
  "mcpServers": {
    "pocketbase": {
      "command": "node",
      "args": ["/path/to/mcp-pocketbase-server/build/index.js"],
      "env": {
        "POCKETBASE_URL": "http://localhost:8090"
      }
    }
  }
}
```

---

## Caso de Uso: PocketBase

**Objetivo:** Claude puede consultar PocketBase directamente.

**Pasos:**
1. Crear MCP server custom para PocketBase
2. Configurar en claude_desktop_config.json
3. Claude puede: listar records, crear, actualizar, eliminar

**Beneficio:** Sin código intermedio, Claude habla directo a la DB.

---

## En OpenClaw

- No implementado aún
- Potencial: conectar PocketBase de proyectos Daniel
- Requiere: MCP server custom para PocketBase

---

## Limitaciones

- Requiere Claude Desktop (no funciona en API directa aún)
- MCP server debe correr localmente
- Seguridad: expone datos, cuidado con permisos

---

## Referencias

- [MCP Official Docs](https://modelcontextprotocol.io/)
- [MCP GitHub](https://github.com/modelcontextprotocol)
- TODO.md item #19

---

_Creado: 2026-02-20 04:22 UTC - Micro-tarea autónoma_
