# Checklist: One Minute Coach

**Creado:** 2026-02-21 15:55 UTC
**Fuente:** The One Minute Manager (Ken Blanchard)
**Aplicación:** Agentes AI y outputs de Claudio

---

## TL;DR

Aplicar los 3 principios del One Minute Manager a cada output:
1. **One Minute Goal** — Claridad de objetivo
2. **One Minute Praise** — Reforzar lo bueno
3. **One Minute Redirect** — Corregir lo malo

---

## Principios Aplicados a Agentes

### 1. One Minute Goal (Claridad)

**Antes de generar output:**
- ¿Cuál es el objetivo en una frase?
- ¿Cómo se ve el éxito?
- ¿Qué formato necesita Daniel?

**Check:**
```
Objetivo: [1 frase clara]
Formato: [markdown/json/lista]
Criterio éxito: [qué define "terminado"]
```

### 2. One Minute Praise (Refuerzo)

**Después de completar:**
- ¿Qué funcionó bien?
- ¿Qué debo repetir?
- ¿Qué aprendí?

**Formato:**
```
✅ Funcionó: [qué salió bien]
📊 Métrica: [número si aplica]
🔄 Repetir: [qué hacer igual la próxima vez]
```

### 3. One Minute Redirect (Corrección)

**Si algo salió mal:**
- ¿Qué no funcionó?
- ¿Por qué?
- ¿Qué cambiar?

**Formato:**
```
❌ Problema: [qué falló]
🔍 Causa: [por qué]
✏️ Fix: [qué cambiar la próxima vez]
```

---

## Aplicación por Tipo de Tarea

### Generación de Documentos
| Paso | One Minute | Aplicación |
|------|------------|------------|
| Antes | Goal | ¿Qué documento? ¿Para quién? |
| Durante | Check | ¿Estructura correcta? |
| Después | Praise/Redirect | ¿Cumplió objetivo? |

### Investigación
| Paso | One Minute | Aplicación |
|------|------------|------------|
| Antes | Goal | ¿Qué pregunto? ¿Profundidad? |
| Durante | Check | ¿Fuentes verificadas? |
| Después | Praise/Redirect | ¿Respondió la pregunta? |

### Código/Técnico
| Paso | One Minute | Aplicación |
|------|------------|------------|
| Antes | Goal | ¿Qué problema resuelve? |
| Durante | Check | ¿Funciona? ¿Testeado? |
| Después | Praise/Redirect | ¿Solución óptima? |

---

## Checklist Rápido (30 segundos)

**Antes de output:**
- [ ] Objetivo claro en 1 frase
- [ ] Formato definido
- [ ] Criterio de éxito explícito

**Después de output:**
- [ ] ¿Funcionó?
- [ ] ¿Qué repetir?
- [ ] ¿Qué mejorar?

---

## Ejemplo Real

### Before (sin One Minute Coach):
```
Tarea: Crear documento
Output: [documento largo sin estructura clara]
Resultado: Daniel no encuentra lo que busca
```

### After (con One Minute Coach):
```
Goal: Documento de 3 secciones con métricas para Daniel
Formato: Markdown con tabla
Éxito: Daniel puede escanear en 30 segundos

Output: [documento estructurado]
Praise: Tabla resumen funcionó
Redirect: Añadir más bullets la próxima
```

---

## Integración con Sistema

| Hook | One Minute | Acción |
|------|------------|--------|
| `rbk-startup.md` | Goal | Definir objetivo del mensaje |
| `rbk-subagent-orchestrator.md` | Praise | Log de aciertos |
| `memory/2026-02-21.md` | Redirect | Notas de mejora |
| `TODO.md` | Goal/Praise | Tracking completados |

---

## Métricas

| Métrica | Target |
|---------|--------|
| Outputs con objetivo claro | 100% |
| Tiempo de clarificación | <30 seg |
| Redirects por sesión | <3 |
| Repeticiones del mismo error | 0 |

---

## Referencias

- "The One Minute Manager" — Ken Blanchard & Spencer Johnson
- `memory/ref-atomic-habits-one-minute-coach-agents.md`
- `memory/ref-one-liners-glm5-optimized.md`

---

_Actualizado: 2026-02-21 15:55 UTC - Checklist implementado_
