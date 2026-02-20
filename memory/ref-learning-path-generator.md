# Learning Path Generator Reference

**Propósito:** Generar planes de aprendizaje personalizados para onboarding de clientes.
**Fuente:** Item #98 de ref-interests-real-100.md

---

## Concepto

Crear rutas de aprendizaje personalizadas basadas en:
- Objetivos del cliente
- Nivel actual de conocimiento
- Tiempo disponible
- Recursos disponibles

---

## Estructura de Output

```markdown
## Learning Path: [Tema/Herramienta]

**Cliente:** [Nombre]
**Objetivo:** [Qué quiere lograr]
**Nivel:** [Principiante/Intermedio/Avanzado]
**Duración:** [Semanas]

### Semana 1: Fundamentos
| Día | Tema | Recurso | Tiempo |
|-----|------|---------|--------|
| 1 | Intro a X | Video 10min | 15min |
| 2 | Concepto básico | Doc | 20min |
| 3 | Ejercicio simple | Práctica | 30min |

### Semana 2: Intermedio
...

### Checkpoints
- [ ] Completar módulo 1
- [ ] Ejercicio práctico aprobado
- [ ] Quiz de conceptos

### Proyecto Final
[Descripción del proyecto aplicativo]

### Recursos
- [Link 1]
- [Link 2]
- [Link 3]
```

---

## Prompt Template

```
[LEARNING PATH GENERATOR]

Cliente: [PERFIL]
Objetivo: [OBJETIVO]
Nivel actual: [NIVEL]
Tiempo disponible: [HORAS/SEMANA]
Herramientas/plataformas: [LISTA]

Genera:
1. Ruta de aprendizaje estructurada por semanas
2. Checkpoints de progreso
3. Proyecto final aplicativo
4. Recursos recomendados

Formato: Markdown con tablas y checkboxes.
```

---

## Ejemplo: Cliente RevOps

### Input

```
Cliente: Clínica dental (turismo médico)
Objetivo: Implementar RevOps básico
Nivel: Principiante en automatización
Tiempo: 2 horas/semana
Herramientas: n8n, PocketBase, WhatsApp Business
```

### Output Esperado

```markdown
## Learning Path: RevOps para Clínica Dental

**Duración:** 4 semanas
**Objetivo:** Automatizar lead capture y follow-up

### Semana 1: Fundamentos RevOps
| Día | Tema | Recurso | Tiempo |
|-----|------|---------|--------|
| 1 | ¿Qué es RevOps? | Video 5min | 15min |
| 2 | Funnel básico | Doc | 20min |
| 3 | Mapeo proceso actual | Ejercicio | 45min |

### Semana 2: n8n Basics
...

### Semana 3: PocketBase + n8n
...

### Semana 4: WhatsApp Integration
...

### Proyecto Final
Implementar flujo: Lead → WhatsApp → PocketBase → Follow-up automático
```

---

## Implementación con Subagente

```javascript
sessions_spawn({
  label: "LEARNING-PATH",
  model: "google/gemini-3-flash-preview",
  task: `[LEARNING PATH GENERATOR]

Cliente: ${perfil}
Objetivo: ${objetivo}
Nivel: ${nivel}
Tiempo: ${tiempo}

Genera plan de aprendizaje estructurado.`,
  runTimeoutSeconds: 120
})
```

---

## Aplicaciones para Daniel

| Cliente | Objetivo | Duración |
|---------|----------|----------|
| Clínica dental | RevOps básico | 4 semanas |
| Ecommerce cliente | n8n automation | 2 semanas |
| SaaS onboarding | PocketBase setup | 1 semana |

---

## Valor

| Beneficio | Descripción |
|-----------|-------------|
| **Onboarding rápido** | Clientes productivos antes |
| **Estructura clara** | Sin ambigüedad |
| **Medible** | Checkpoints de progreso |
| **Reutilizable** | Templates por tipo de cliente |

---

## Estado Actual

- **Template:** ✅ Definido
- **Prompt:** ✅ Listo
- **Implementación:** ⏳ Pendiente clientes activos

---

_Creado: 2026-02-20 20:16 UTC - Micro-tarea autónoma_
