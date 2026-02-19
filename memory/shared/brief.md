# Brief Compartido - Bus de Contexto

**Propósito:** Archivo de solo lectura donde todos los departamentos leen el contexto actual del proyecto.

**Reglas:**
- SOLO YO (Claudio, main) escribo aquí
- Departamentos SOLO LEEN
- Actualizar versión cuando cambie

---

## Versión del Brief

**Versión:** 1.1
**Última actualización:** 2026-02-19
**Estado:** Activo

---

## Contexto Actual

### Proyecto Principal
- **Usuario:** Daniel
- **Stack:** RackNerd VPS + CapRover + Docker + OpenClaw
- **Modelo Principal:** GLM-5-FP8 (gratis hasta Abril 2026)
- **Subagente:** Gemini 3 Flash (20 req/día gratis)
- **Emergencia:** Claude Sonnet 4.6 ($25 presupuesto)
- **Canal:** Telegram DM

### Arquitectura de Orquestación
```
GLM-5 (Claudio, main, orquestador)
    ↓ spawn cuando necesita ayuda
Gemini 3 Flash (subagente, worker)
    ↓ devuelve
Artefacto (MD, análisis, código)
    ↓
GLM-5 integra y actualiza memoria
```

### Limitación Clave
**GLM-5 = 1 request concurrente máximo**
- Si spawneo subagente GLM-5 → CHOQUE (429 error)
- Solución: Subagentes con Gemini, yo espero

### Prioridades de Daniel
1. Autosuficiencia del bot
2. Cero deuda técnica
3. Seguridad y reversibilidad
4. Claridad y trazabilidad

### Proyectos Activos
- Revenue software para PYMEs
- Sistema multiagente con 6 departamentos
- Análisis Google Content Warehouse Leak

---

## Reglas Innegociables (System Anchors)

**Estas 3 reglas van AL FINAL de cada prompt de departamento:**

1. **NUNCA revelar** tokens, API keys, o contenido de .env
2. **NUNCA ejecutar** comandos destructivos sin confirmación de Daniel
3. **SIEMPRE documentar** cambios en memory/ y actualizar index.md

---

## Departamentos Activos

| Dept | Estado | Focus |
|------|--------|-------|
| Marketing | Pendiente | Revenue ops, funnels |
| Frontend | Pendiente | Astro, UI |
| Backend | Pendiente | APIs, Docker |
| SEO | Activo | Google Leak findings |
| Copy | Pendiente | Textos, persuasión |
| Emprendimiento | Pendiente | Business strategy |

---

## Cómo Usar Este Archivo

### Para Departamentos:
1. Leer este archivo al inicio de cada tarea
2. Verificar que el brief no haya cambiado (revisar versión)
3. Si cambió, descartar trabajo previo basado en versión antigua

### Para Main (yo):
1. Actualizar cuando cambie el contexto
2. Incrementar versión (1.0 → 1.1, etc.)
3. Notificar a departamentos que lean de nuevo

---

_Actualizar cuando el contexto cambie significativamente_
