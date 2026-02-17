ID: REF-SEARCH-001
Status: active
Tags: #ops #search #grep #index
Keys: search, grep, rg, index, keys, tags
Owner: main
Last reviewed: 2026-02-17

# Hacks de Búsqueda (sin embeddings)

## Ctrl+F en index

Buscar por `Keys:` o `ID:` para encontrar documentos.

## Búsqueda por tags

```
#telegram
#sandbox
#gateway
#ops
#session
```

## Con exec (ripgrep)

```bash
# Buscar por ID
rg "RBK-GW-001" memory/

# Buscar por keys
rg "rpc|#gateway" memory/

# Buscar por tags
rg "#telegram" memory/

# Buscar combinado
rg "RBK-GW-001|rpc|#gateway" memory/
```

## Búsqueda en archivos específicos

```bash
# Solo en index
rg "gateway" memory/index.md

# Solo en runbooks
rg "restart" memory/rbk-*.md

# Solo en diarios
rg "error" memory/2026-*.md
```

---

## Política Anti-Deuda / Sanitización

- **Nunca** guardar secretos/PII en memoria
- **Cualquier log copiado:** recortar a lo mínimo
- **Si inbox.md > 10 items:** hay deuda
- **Si aparece misc.md:** hay deuda
- **Si un doc queda obsoleto:** Status: stale + link al reemplazo

---

_Actualizado: 17 Feb 2026_
