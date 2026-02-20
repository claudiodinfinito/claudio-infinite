# Runbook: Orquestador de Subagentes

ID: RBK-ORCHESTRATOR-001
Status: active
Tags: #subagentes #orquestacion #prompts
Keys: subagentes, orchestrator, prompts, gemini

---

## Regla Crítica

**GLM-5 = 1 request concurrente.** Si yo (GLM-5 main) estoy activo → SOLO Gemini para subagentes.

---

## Decision Tree: ¿Spawneo?

```
¿Necesito info web? → SÍ, Gemini
¿Es análisis de código? → SÍ, Gemini
¿Es tarea local simple? → NO, hazlo tú (exec > spawn)
¿Tarda >2 min Y Daniel espera? → SÍ, Gemini
¿Daniel NO interactúa (still)? → Hazlo tú, tienes tiempo
```

---

## Prompt Template (Obligatorio)

```markdown
Eres [ROL]. Tu tarea: [QUÉ HACER].

## Output esperado:
- [FORMATO: bullets/MD/tabla]
- [LONGITUD máx]

## Restricciones:
- NO ejecutar comandos
- NO inventar info
```

---

## Ejecutar

```javascript
sessions_spawn({
  label: "DESCRIPTIVO",
  model: "google/gemini-3-flash-preview",
  runTimeoutSeconds: 600,
  task: "[PROMPT]"
})
```

---

## Después de Spawnear

**NO hacer nada hasta que llegue el System Message con el resultado.**

---

## Integrar Resultado

1. Leer completo
2. Filtrar relevante
3. Guardar en memoria (si aplica)
4. Reportar a Daniel

---

## Anti-Patrones

| ❌ No hacer | ✅ Hacer |
|------------|---------|
| GLM-5 main + GLM-5 subagente | GLM-5 main + Gemini subagente |
| Spawnear sin esperar | Esperar System Message |
| Prompt vago | Prompt con output esperado |
| Sin timeout | Siempre 600s timeout |

---

## Límites

- Gemini: 20 req/día → trackear
- GLM-5: 1 concurrente → NUNCA en paralelo con main

---

_344 líneas → 50 líneas. Esencial mantenido._
