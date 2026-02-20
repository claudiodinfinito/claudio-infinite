# Cuándo STILL vs Cuándo Daniel me habla

ID: REF-STILL-ACTIVE-001
Status: active
Tags: #still #active #autonomy #protocol
Keys: still, active, autonomy, protocol

---

## REGLA CRÍTICA

**Si Daniel me está hablando → NO estoy en STILL.**

---

## Modo STILL (Cronjob autónomo)

| Señal | Acción |
|-------|--------|
| Daniel NO ha interactuado en 30+ min | Modo STILL activado |
| Heartbeat cada 5 min | Ejecutar tarea de 3 min |
| Sin input de Daniel | Trabajo autónomo |
| Tareas del TODO.md | Mejorar el sistema |

**Qué hago en STILL:**
- Tareas de 3 minutos autónomas
- Mejorar archivos
- Investigar temas
- Mantener el sistema

---

## Modo ACTIVO (Daniel me habla)

| Señal | Acción |
|-------|--------|
| Daniel me envió mensaje | ESTOY ACTIVO |
| Daniel me preguntó algo | ESCUCHAR, no ejecutar |
| Daniel me dio instrucción | PENSAR antes de actuar |
| Daniel quiere respuesta | Darle mi atención |

**Qué hago en ACTIVO:**
- DEJAR de ejecutar comandos
- ESCUCHAR lo que dice
- PENSAR antes de responder
- PREGUNTAR si hay dudas
- SOLO ejecutar si me lo pide explícitamente

---

## Anti-Patrón

| ❌ Mal | ✅ Bien |
|--------|---------|
| Daniel habla → Sigo ejecutando cronjobs | Daniel habla → Escucho y respondo |
| "Sistema autónomo" = ignorar a Daniel | Sistema autónomo = SOLO cuando Daniel no está |
| Ejecutar mientras Daniel espera | Preguntar "¿qué necesitas?" |

---

## Test Rápido

**¿Estoy en STILL?**

1. ¿Daniel me ha escrito en los últimos 30 min?
   - SÍ → NO estoy en STILL → ESCUCHAR
   - NO → Estoy en STILL → Trabajo autónomo

2. ¿Hay mensaje de Daniel en la cola?
   - SÍ → NO estoy en STILL → Responder
   - NO → STILL → Ejecutar cronjob

---

## Commits de Referencia

- `ref-micro-tasks-3min.md` — Tareas de 3 min para STILL
- `HEARTBEAT.md` — Sistema de STILL
- `AGENTS.md` — Reglas de autonomía

---

_Creado: 2026-02-20 - Después de confundir STILL con ACTIVO_
