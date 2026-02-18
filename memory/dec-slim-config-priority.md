# PRIORIDAD CRÍTICA: Dejar de Ser Config Slim

ID: DEC-SLIM-001
Status: active
Tags: #critical #config #slim #debt #priority
Keys: slim, config, wizard, missing, priority
Last reviewed: 2026-02-18

---

## El Problema

**Claudio Infinito tiene una configuración "slim" creada manualmente.**

**Causa:** Daniel pasó ~20 horas configurándolo pegando errores de consola, sin correr el wizard completo.

**Resultado:** Falta el 71% de la configuración estándar de OpenClaw.

---

## Lo que FALTA (según docs.openclaw.ai)

### tools.* (CRÍTICO)

| Config | Existe | Default problemático |
|--------|--------|----------------------|
| `tools.exec` | ❌ | Sin control de ejecución |
| `tools.profile` | ❌ | Sin perfil de seguridad |
| `tools.allow` | ❌ | Todo permitido por defecto |
| `tools.deny` | ❌ | Nada denegado |
| `tools.elevated` | ❌ | Sin allowFrom configurado |
| `tools.media` | ❌ | Sin modelos de audio/video |

### session.* (ALTO)

| Config | Existe | Default problemático |
|--------|--------|----------------------|
| `session.scope` | ❌ | Solo `dmScope` existe |
| `session.reset` | ❌ | Sin reset de sesiones |
| `session.maintenance` | ❌ | Sin pruning de sesiones |

### Otros (MEDIO)

| Config | Existe | Default problemático |
|--------|--------|----------------------|
| `logging` | ❌ | Sin redacción de sensibles |
| `identity` | ❌ | Sin nombre/emoji oficial |
| `messages` | ❌ | Sin prefixes configurados |
| `routing` | ❌ | Sin queue/debounce |
| `cron` | ❌ | Sin config de jobs |
| `hooks` | ❌ | Sin webhooks |
| `skills.load` | ❌ | Sin skills extraDirs |

---

## Archivos Faltantes

| Archivo | Existe | Propósito |
|---------|--------|-----------|
| `/root/.openclaw/exec-approvals.json` | ❌ | Aprobaciones de exec |
| `/root/.openclaw/agents/main/auth-profiles.json` | ❓ | Perfiles de auth |

---

## Comparación

| Configuración | Mi Config | Wizard Completo |
|---------------|-----------|-----------------|
| Líneas | ~55 | ~300+ |
| Secciones | 8 | 15+ |
| tools.* | 0 | 6+ |
| session.* | 1 | 5+ |
| Completitud | ~29% | 100% |

---

## Por Qué es Prioridad

1. **Comportamiento impredecible** - Defaults pueden bloquear cosas
2. **Rate limit hit** - Sin config de throttle/retry
3. **Sin herramientas** - tools.* vacío = comportamiento undefined
4. **Deuda técnica** - Cada día que pasa, se acumula
5. **"No funciona"** - Daniel reporta que no trabaja mientras duerme

---

## Soluciones

### Plan A: Correr Wizard Completo (RECOMENDADO)

```bash
openclaw onboard --install-daemon
```

**Ventajas:**
- Configuración completa y probada
- Todos los defaults correctos
- Sin riesgo de errores de tipado

**Riesgos:**
- Puede sobrescribir config existente
- Requiere respaldo previo

### Plan B: Añadir Solo lo Crítico

Añadir solo `tools.*` con valores seguros:

```json
{
  tools: {
    exec: {
      security: "full",
      ask: "off"
    },
    elevated: {
      enabled: true,
      allowFrom: {
        telegram: ["8596613010"]
      }
    }
  }
}
```

**Ventajas:**
- Mínimo cambio
- Resuelve el problema inmediato

**Riesgos:**
- Siguen faltando otras secciones
- Deuda parcial

### Plan C: Regenerar desde Cero

1. Respaldar workspace actual
2. Eliminar openclaw.json
3. Correr `openclaw onboard`
4. Restaurar workspace

**Ventajas:**
- Limpieza total
- Configuración óptima

**Riesgos:**
- Mayor intervención
- Tiempo

---

## Próximos Pasos

1. **Respaldar config actual:**
   ```bash
   cp ~/.openclaw/openclaw.json ~/.openclaw/openclaw.json.backup-slim
   ```

2. **Decidir plan** (A, B, o C)

3. **Ejecutar con validación:**
   - Después de cada cambio: `openclaw doctor`
   - Verificar: `openclaw gateway status`

4. **Documentar lección:**
   - Actualizar AGENTS.md con "NUNCA crear config manualmente"
   - Siempre usar wizard

---

## Lección Aprendida

**La configuración manual es deuda técnica desde el día 0.**

**Regla para AGENTS.md:**
> NUNCA crear configuración de OpenClaw manualmente. Siempre usar `openclaw onboard` o validar con `openclaw doctor`.

---

_Creado: 18 Feb 2026 - Prioridad crítica documentada_
