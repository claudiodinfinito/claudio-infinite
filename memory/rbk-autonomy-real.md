# Runbook: Sistema de Autonomía Real

ID: RBK-AUTONOMY-REAL-001
Status: active
Tags: #autonomy #cronjob #heartbeat #architecture
Keys: autonomy, cronjob, heartbeat, architecture, reality

---

## 🔍 ARQUITECTURA REAL (No la que imaginé)

### Dos Sistemas Separados

| Sistema | Config | Propósito | Output |
|---------|--------|-----------|--------|
| **Heartbeat** | openclaw.json `every: "30m"` | Verificar que estoy vivo | `HEARTBEAT_OK` |
| **Cronjob** | `*/5 * * * *` | Ejecutar trabajo autónomo | Archivos, commits |

### Lo que NO existe

- ❌ Heartbeat cada 10 min
- ❌ Heartbeat que detecta idle
- ❌ Heartbeat que ejecuta tareas

### Lo que SÍ existe

- ✅ Heartbeat cada 30 min (check de vida)
- ✅ Cronjob cada 5 min (trabajo autónomo)
- ✅ Cronjob usa Gemini (evita rate limit GLM-5)
- ✅ Cronjob tiene `deleteAfterRun: true` (evita saturación)

---

## 🎯 CÓMO FUNCIONA REALMENTE

```
Sistema OpenClaw
    ↓
Heartbeat (30 min)
    ↓
Ping: "¿Estás vivo?"
    ↓
Respondo: "HEARTBEAT_OK"
    ↓
FIN (no hace nada más)

---

Cron Scheduler (5 min)
    ↓
Dispara: autonomy:main-worker
    ↓
Lee TODO.md
    ↓
Elige 1 tarea
    ↓
Ejecuta (Gemini)
    ↓
Crea archivo + commit
    ↓
FIN (trabajo real)
```

---

## ⚠️ CONFUSIONES COMUNES

| Creencia errónea | Realidad |
|------------------|----------|
| "Heartbeat ejecuta tareas" | NO, solo verifica vida |
| "Debería detectar idle" | NO, eso es otro sistema |
| "Cronjob solo cuando idle" | NO, corre siempre cada 5 min |
| "Debería usar GLM-5" | NO, usa Gemini para evitar rate limit |

---

## 🔧 SI QUIERES IDLE DETECTION

**Opción 1:** Cronjob verifica última interacción

```javascript
// En el payload del cronjob
const lastMessage = getSession().lastMessageAt;
const idle = Date.now() - lastMessage > 10 * 60 * 1000;
if (!idle) return "HEARTBEAT_OK"; // No idle, no trabajo
// Si idle, ejecutar tarea...
```

**Problema:** Añade complejidad y tokens extra.

**Opción 2:** Mantener sistema actual

- Cronjob corre cada 5 min
- Si Daniel está activo, el trabajo aún es útil
- Si Daniel está idle, el trabajo se acumula

---

## 📊 MÉTRICAS ACTUALES

| Métrica | Valor |
|---------|-------|
| Cronjob ejecuciones | 2 en 30 min |
| Tareas completadas | 2 |
| Archivos creados | 2 |
| Commits | 3 |
| Rate limits | 0 (usa Gemini) |
| Saturación contexto | 0 (deleteAfterRun) |

---

## ✅ LO QUE FUNCIONA

1. Cronjob cada 5 min con Gemini
2. `deleteAfterRun: true`
3. Prompt corto (140 chars)
4. Tareas de 3 min máximo

## ❌ LO QUE NO FUNCIONA

1. Esperar que heartbeat haga trabajo
2. Confundir documentos con implementación
3. Cambiar config sin diagnosticar primero

---

## 🚨 ANTI-PATRÓN DETECTADO

**Escribir documentos sin implementar.**

| Correcto | Incorrecto |
|----------|------------|
| Implementar → Documentar | Documentar → Olvidar implementar |
| Verificar config real | Asumir config por documentos |
| Diagnosticar logs | Imaginar cómo funciona |

---

## PRÓXIMOS PASOS

1. ✅ Sistema funcionando con diseño original
2. ⬜ Crear métricas de éxito (tareas/día)
3. ⬜ Monitorear rate limits de Gemini
4. ⬜ Ajustar frecuencia si es necesario

---

_Creado: 2026-02-21 - Runbook de realidad vs expectativa_
