# Runbook: Auto-Reparación de Cronjobs

ID: RBK-AUTO-REPAIR-001
Status: active
Tags: #cronjob #debug #auto-repair #context
Keys: cronjob, debug, auto-repair, context, deleteAfterRun
Last reviewed: 2026-02-21

---

## Problema

Cronjobs con `sessionTarget: isolated` acumulan contexto hasta saturar el modelo.

**Síntomas:**
- Error: "Context overflow: prompt too large"
- Error: "The input (XXX tokens) is longer than the model's context length"
- Cronjob reporta success pero no produce output útil

---

## Diagnóstico

### Paso 1: Verificar runs recientes

```bash
openclaw cron runs <job-id>
```

Buscar:
- `status: ok` pero sin output real
- Mensajes de error con "context" o "tokens"

### Paso 2: Verificar tamaño de sesión

```bash
ls -lh /root/.openclaw/agents/main/sessions/*.jsonl
```

Si ves archivos > 100KB, probablemente saturados.

### Paso 3: Verificar si tiene `deleteAfterRun`

```bash
openclaw cron list
```

Buscar el job y verificar si tiene `"deleteAfterRun": true`.

---

## Solución

### Fix Inmediato

1. **Deshabilitar el cronjob:**
   ```bash
   openclaw cron update <job-id> --patch '{"enabled": false}'
   ```

2. **Añadir `deleteAfterRun`:**
   ```bash
   openclaw cron update <job-id> --patch '{"deleteAfterRun": true}'
   ```

3. **Eliminar sesión saturada:**
   ```bash
   rm /root/.openclaw/agents/main/sessions/<session-id>.jsonl
   ```

4. **Rehabilitar:**
   ```bash
   openclaw cron update <job-id> --patch '{"enabled": true}'
   ```

---

## Regla General

**Todo cronjob con `sessionTarget: isolated` DEBE tener `deleteAfterRun: true`.**

### Cómo verificar todos los cronjobs:

```bash
openclaw cron list | grep -A 5 "isolated"
```

### Cómo fixear todos los que no tienen el flag:

Para cada job con `isolated` y sin `deleteAfterRun`:

```bash
openclaw cron update <job-id> --patch '{"deleteAfterRun": true}'
```

---

## Prevención

### Al crear un nuevo cronjob:

```json
{
  "name": "mi-cronjob",
  "sessionTarget": "isolated",
  "deleteAfterRun": true,  // ← SIEMPRE incluir esto
  "payload": { ... }
}
```

### Validación automática:

Añadir a HEARTBEAT.md:

```markdown
## Anti-Patrones (Vigilar):

- [ ] ¿Cronjob isolated sin deleteAfterRun? → AÑADIR FLAG
```

---

## Casos Especiales

### Cronjob que necesita persistencia

Si el cronjob NECESITA mantener contexto entre runs:

1. Usar `sessionTarget: main` (no isolated)
2. O usar un archivo de estado externo:
   ```javascript
   // Leer estado
   const state = read('memory/cronjob-state.json')
   // Actualizar estado
   state.lastRun = new Date()
   write('memory/cronjob-state.json', state)
   ```

### Cronjob que spawnea sub-agentes

El sub-agente también acumula contexto. Ambos necesitan `deleteAfterRun`:

```json
{
  "name": "parent-cronjob",
  "deleteAfterRun": true,
  "payload": {
    "kind": "agentTurn",
    "message": "Spawnea un subagente para..."
  }
}
```

---

## Historial de Incidentes

| Fecha | Job | Causa | Fix |
|-------|-----|-------|-----|
| 2026-02-21 | micro-task-5min | 200k+ tokens acumulados | Añadido `deleteAfterRun` |

---

## Referencias

- `HEARTBEAT.md` - Sistema autónomo
- `memory/ref-cronjobs-active.md` - Lista de cronjobs activos
- OpenClaw docs: https://docs.openclaw.ai/cron

---

_Creado: 2026-02-21 - Lección del incidente de contexto saturado_
