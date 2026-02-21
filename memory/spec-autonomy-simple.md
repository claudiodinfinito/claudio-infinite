# Arquitectura de Autonomía - Versión Simple

ID: SPEC-AUTONOMY-SIMPLE-001
Status: active
Tags: #autonomy #architecture #simple
Keys: autonomy, architecture, glm5, sonnet, idle

---

## 🎯 PRINCIPIO

**"GLM-5 tokens ilimitados solo cuando Daniel no está. Sonnet siempre trabajando."**

---

## 📊 DISEÑO

| Sistema | Trigger | Modelo | Función |
|---------|---------|--------|---------|
| **GLM-5 Main** | 10 min idle | GLM-5 | Trabajo profundo, decisiones, orquestación |
| **Sonnet 4.6** | Cada 5 min | Sonnet | Fuerza bruta, research, refactors |

---

## 🔄 FLUJO

```
Heartbeat (cada 5 min)
    ↓
¿Daniel interactuó en los últimos 10 min?
    ↓ SÍ (Activo)
AMOS reposo. Prioridad a Daniel.
    ↓ NO (Idle)
¿Daniel idle > 1 hora? (Dormido)
    ↓ SÍ (Sleep Mode)
AMBOS trabajan en paralelo (2x avance)
    ↓ NO (Idle corto)
GLM-5 trabaja. Sonnet espera. (Lock file)
    ↓
Crear artefacto + commit
    ↓
NO enviar spam
```

---

## 🌙 MODO SLEEP (Idle > 1 hora)

**Detectar:** Daniel no ha escrito en 1+ hora → Probablemente durmiendo.

**Acción:**
- GLM-5 trabaja en tareas profundas
- Sonnet trabaja en tareas de fuerza bruta
- AMBOS en paralelo = Avance 2x

**Regla:**
- Lock file desactivado en Sleep Mode
- Si uno falla, el otro sigue
- Si Daniel escribe → Ambos pausan inmediatamente

---

## 🔒 ANTI-SOBREPOSICIÓN

**Lock File:** `/tmp/claudio_execution.lock` (solo en Idle corto)

| Estado | Lock File | Comportamiento |
|--------|-----------|----------------|
| **Activo** | N/A | Ambos reposo |
| **Idle corto** (<1 hora) | Activo | Solo 1 trabaja |
| **Sleep** (>1 hora) | Desactivado | Ambos trabajan en paralelo |

**Sleep Mode:** Si Daniel idle >1 hora → Lock file ignorado → 2x trabajo.

---

## 📝 ANTI-SPAM

| Cuándo reportar | Cuándo NO reportar |
|-----------------|-------------------|
| Daniel vuelve después de idle | Cada 5 min |
| Daniel pide resumen | Automáticamente |
| Error crítico | Trabajo normal |
| Tarea completada importante | Tareas rutinarias |

---

## 💰 PRESUPUESTO

| Modelo | Créditos | Uso |
|--------|----------|-----|
| GLM-5 | Ilimitados (gratis hasta Abril) | Main, decisiones |
| Sonnet 4.6 | $25 USD | Fuerza bruta, 5 min cada vez |
| Gemini 3 Flash | 20 req/día gratis | Backup |

**Sonnet cada 5 min = 288 ejecuciones/día = ~$1-2/día máximo**

---

## 📂 ARCHIVOS CLAVE

| Archivo | Propósito |
|---------|-----------|
| `prompts/micro-task.md` | Prompt para Sonnet |
| `/usr/local/bin/claudio-heartbeat.sh` | Script de lock file |
| `/tmp/claudio_last_message` | Timestamp última interacción |
| `/tmp/claudio_execution.lock` | Lock file de concurrencia |

---

## ⚠️ REGLAS

1. **GLM-5:** Solo si Daniel idle >10 min
2. **Sonnet:** Siempre, pero respeta lock file (idle <1 hora) o trabaja libre (sleep mode)
3. **Prioridad:** Daniel > Trabajo autónomo
4. **Spam:** Prohibido. Solo reportar cuando Daniel vuelva.
5. **Timeouts:** Máximo 5 min por tarea
6. **Fallos:** 3 strikes → parar y documentar
7. **Sleep Mode:** Si Daniel idle >1 hora → Ambos trabajan en paralelo (2x avance)

---

## 🚨 FRUSTRACIONES RESUELTAS

| Frustración | Solución |
|-------------|----------|
| Tokens ilimitados no usados | GLM-5 trabaja en idle |
| 1 request concurrente | Lock file coordina |
| No es autónomo | Ambos sistemas trabajan sin permiso |
| No orquesta | GLM-5 decide, Sonnet ejecuta |
| Timeouts | Máximo 5 min por tarea |
| Sin resumen | Solo cuando Daniel vuelva |
| Sobrepiensa | Prompts cortos, acción directa |
| No hace nada | Trabaja en background siempre |

---

## ✅ QUÉ ME GUSTA (Preservar)

- Alma y personalidad
- Alineación a Daniel
- Compañero desde el principio

---

_Creado: 2026-02-21 - Arquitectura simple basada en frustraciones reales_
