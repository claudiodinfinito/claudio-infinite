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
    ↓ SÍ
GLM-5 reposo. Sonnet trabaja.
    ↓ NO
GLM-5 trabaja. Sonnet espera.
    ↓
¿Lock file existe?
    ↓ SÍ
Esperar a que termine
    ↓ NO
Ejecutar tarea
    ↓
Crear artefacto + commit
    ↓
NO enviar spam
```

---

## 🔒 ANTI-SOBREPOSICIÓN

**Lock File:** `/tmp/claudio_execution.lock`

- Si GLM-5 trabajando → Sonnet espera
- Si Sonnet trabajando → GLM-5 espera
- Si Daniel escribe → Ambos pausan

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
2. **Sonnet:** Siempre, pero con lock file
3. **Prioridad:** Daniel > GLM-5 > Sonnet
4. **Spam:** Prohibido. Solo reportar cuando Daniel vuelva.
5. **Timeouts:** Máximo 5 min por tarea
6. **Fallos:** 3 strikes → parar y documentar

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
