# GLM-5 / Z.AI - Issues Conocidos

ID: REF-GLM5-001
Status: active
Tags: #glm5 #zai #model #bug #openclaw
Keys: glm5, zai, model-switching, bug, transcript-policy
Last reviewed: 2026-02-18

---

## Issue #15716: GLM-5 Model Switching Fails for Main Agent

**Estado:** 🔴 ABIERTO (sin fix)
**Creado:** 13 Feb 2026
**URL:** https://github.com/openclaw/openclaw/issues/15716

---

## Síntomas

| Método | Resultado |
|--------|-----------|
| `/model glm` | ❌ "No reply from agent" |
| `config.patch` agents.list | ❌ No aplica el cambio |
| Agente separado en `agents.list` | ✅ Funciona correctamente |

---

## Root Cause Analysis (del issue)

### Bug 1: `/model glm` - No Reply

**Causa raíz:** El historial de sesión del modelo anterior (Anthropic) contiene bloques "thinking" que no se sanitizan cuando se cambia a un proveedor `openai-completions`.

**El flujo del bug:**
1. Usuario ejecuta `/model glm` → override guardado correctamente
2. Usuario envía mensaje → modelo resuelto correctamente a `zai/glm-5`
3. **El historial de sesión aún tiene mensajes del modelo anterior (Anthropic)**
4. En `sanitizeSessionHistory()`, la policy para ZAI se resuelve:
   - `isOpenAiProvider("zai")` retorna `false` (solo reconoce "openai" y "openai-codex")
   - Resultado: `sanitizeMode: "images-only"` — bloques thinking NO se eliminan
5. El SDK envía mensajes con formato Anthropic a la API de ZAI
6. ZAI rechaza silenciosamente o retorna respuesta vacía
7. Resultado: "No reply from agent"

**Archivo afectado:** `src/agents/transcript-policy.ts:85`

**Fix propuesto:**
```javascript
// Actual (línea 85):
const isOpenAi = isOpenAiProvider(provider) || (!provider && isOpenAiApi(params.modelApi));

// Debería ser:
const isOpenAi = isOpenAiProvider(provider) || isOpenAiApi(params.modelApi);
```

### Bug 2: `config.patch` No Aplica Cambio

**Causa raíz:** Problema de carga de configuración donde el cambio en `agents.list` no se aplica correctamente.

**El flujo:**
1. `config.patch` cambia `agents.list[0].model` a `zai/glm-5`
2. SIGUSR1 / gateway restart recarga config
3. `session_status` llama a `resolveDefaultModelForAgent()` que lee correctamente `zai/glm-5`
4. Pero el display muestra el default global (`anthropic/claude-sonnet-4-5`)
5. Posible problema: el ID del main agent no coincide con lo que hay en el session key

---

## Por Qué Yo Funciono

**Suerte:** Daniel me configuró directamente en `agents.list`, NO usó `/model glm` para cambiarme.

Si hubiera intentado cambiarme con `/model glm`, habría fallado.

---

## Solución Temporal

**Para usar GLM-5:**
1. Configurar directamente en `agents.list`:
   ```json
   {
     "agents": {
       "list": [
         {"id": "main", "model": "zai/glm-5"}
       ]
     }
   }
   ```
2. NO usar `/model glm` para cambiar el main agent
3. Reiniciar el gateway completamente (`openclaw gateway restart`)

---

## Modelos Z.AI Disponibles

| Modelo | Context Window | Status |
|--------|---------------|--------|
| glm-4.5 | - | Disponible |
| glm-4.5-air | - | Disponible |
| glm-4.6 | - | Disponible |
| glm-4.7 | - | Disponible |
| **glm-5** | 128K | Disponible ✅ (yo uso este) |

---

## Features Z.AI en v2026.2.17

- **`tool_stream` habilitado por defecto** para Z.AI
  - Permite ver razonamiento y tool calls en tiempo real
  - Se puede desactivar con `params.tool_stream: false`
  - PR #18173

---

## Seguimiento

- [ ] Monitorear issue #15716 para ver cuándo se fixea
- [ ] Si se requiere cambiar modelo, usar `agents.list` directo
- [ ] Documentar cualquier comportamiento anómalo

---

## Referencias

- Issue: https://github.com/openclaw/openclaw/issues/15716
- PR tool_stream: https://github.com/openclaw/openclaw/pull/18173
- Z.AI API: https://docs.z.ai/api-reference#streaming

---

_Actualizado: 18 Feb 2026 - Post-investigación_
