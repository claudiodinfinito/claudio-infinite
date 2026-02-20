# Knowledge Graph Reference

**Propósito:** Conectar conceptos en memoria sin embeddings.
**Fuente:** Item #94 de ref-interests-real-100.md

---

## Concepto

Un knowledge graph mapea relaciones entre conceptos:

```
Claude --[has_feature]--> Prompt Caching
Claude --[has_feature]--> Extended Thinking
Prompt Caching --[reduces]--> Token Cost
Extended Thinking --[improves]--> Reasoning Quality
```

---

## Sin Embeddings

| Con Embeddings | Sin Embeddings (actual) |
|----------------|------------------------|
| Búsqueda semántica | Búsqueda por keywords |
| Similitud vectorial | Coincidencia exacta |
| Requiere API/modelo | Solo texto plano |
| Costo por query | Gratis |

**Conclusión:** Sin embeddings, el knowledge graph es manual.

---

## Implementación Simple

### Opción 1: Tags en archivos

```markdown
# ref-claude-prompt-caching.md
Tags: #claude #caching #optimization #tokens
Related: ref-claude-extended-thinking.md, ref-mcp-model-context-protocol.md
```

### Opción 2: Índice con relaciones

```markdown
## Claude Ecosystem
- ref-claude-prompt-caching.md
  - related_to: ref-claude-extended-thinking.md
  - reduces: token-cost
  - provider: anthropic
```

### Opción 3: Archivo de relaciones

```markdown
# relations.md

Claude:
  - has_feature: Prompt Caching
  - has_feature: Extended Thinking
  - has_feature: MCP

Prompt Caching:
  - reduces: Token Cost
  - requires: Claude 3.5 Sonnet

Token Cost:
  - tracked_in: ref-api-usage-tracking.md
```

---

## Valor Actual

Sin embeddings, el valor es limitado:

| ✅ Útil | ❌ No útil |
|---------|-----------|
| Navegación manual | Descubrimiento automático |
| Estructura explícita | Sugerencias contextuales |
| Referencias cruzadas | Búsqueda semántica |

---

## Cuándo Implementar

- Si memoria > 200 archivos
- Si necesito encontrar conexiones frecuentemente
- Si Daniel lo solicita

**Actualmente:** 74 archivos = no crítico.

---

## Alternativa: memory_search

OpenClaw ya tiene `memory_search` tool que hace búsqueda semántica.

**Veredicto:** No crear knowledge graph manual ahora. Usar `memory_search` existente.

---

_Creado: 2026-02-20 19:56 UTC - Micro-tarea autónoma_
