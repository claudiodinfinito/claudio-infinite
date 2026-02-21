# Fix: Haiku Executor Configuration

**Fecha:** 2026-02-21 19:55 UTC
**Problema:** Haiku no funciona como subagente

---

## DIAGNÓSTICO

### Error:
```
HTTP 404 not_found_error: model: claude-3-5-haiku-latest
```

### Causas:

1. **AGENTS.md dice:** "✅ SOLO puedo spawnear Gemini"
2. **models.json:** No tiene modelos Anthropic registrados
3. **Contradicción:** Dice "spawnea Sonnet 4.6" pero no está configurado

### API Key:
- ✅ Configurada: `ANTHROPIC_API_KEY` en .env
- ✅ Detectada por OpenClaw: `anthropic effective=env:sk-ant-a...`

---

## SOLUCIÓN

### 1. Actualizar AGENTS.md
- Permitir Haiku y Sonnet
- Actualizar tabla de modelos

### 2. Registrar modelos en models.json
- Añadir `claude-3-5-haiku-20241022`
- Añadir `claude-sonnet-4-5-20250514` (o similar)

### 3. Actualizar regla de spawn
- De "SOLO Gemini" a "Gemini + Haiku + Sonnet"

---

## MODELOS A REGISTRAR

| Modelo ID | Nombre | Uso |
|-----------|--------|-----|
| `claude-3-5-haiku-20241022` | Haiku 3.5 | Tareas simples, rápido |
| `claude-sonnet-4-5-20250514` | Sonnet 4.5 | Tareas complejas |
| `claude-3-5-sonnet-20241022` | Sonnet 3.5 | Alternativa |

---

## ARCHIVOS A MODIFICAR

1. `/root/.openclaw/workspace/AGENTS.md`
2. `/root/.openclaw/models.json` (o crear si no existe)

---

## VERIFICACIÓN

```bash
# Después de cambios:
openclaw models status --probe --provider anthropic
sessions_spawn({model: "claude/claude-3-5-haiku-20241022", ...})
```

---

_Creado: 2026-02-21 19:55 UTC - Pre-fix documentation_
