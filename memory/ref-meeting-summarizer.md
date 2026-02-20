# Meeting Summarizer Reference

**Propósito:** Sistema para resumir reuniones automáticamente.
**Fuente:** Item #97 de ref-interests-real-100.md

---

## Concepto

Convertir notas de reuniones o transcripciones en resúmenes estructurados.

---

## Input Posibles

| Fuente | Formato |
|--------|---------|
| Transcripción | Texto de Whisper/STT |
| Notas manuales | Bullet points |
| Chat/Slack | Mensajes exportados |
| Documentos | PDFs, Docs |

---

## Output Esperado

```markdown
## Reunión: [Tema]
**Fecha:** YYYY-MM-DD
**Participantes:** [Lista]

### Resumen (3 bullets)
- Punto principal 1
- Punto principal 2
- Punto principal 3

### Decisiones Tomadas
- [ ] Decisión 1
- [ ] Decisión 2

### Action Items
| Quién | Qué | Deadline |
|-------|-----|----------|
| Persona A | Tarea X | YYYY-MM-DD |
| Persona B | Tarea Y | YYYY-MM-DD |

### Próximos Pasos
1. Paso 1
2. Paso 2
```

---

## Prompt Template

```
[MEETING SUMMARIZER]

Transcripción/Notas de reunión:
[INPUT]

Genera:
1. Resumen en 3 bullets
2. Decisiones tomadas (checkboxes)
3. Action items con responsables
4. Próximos pasos

Formato: Markdown estructurado.
```

---

## Implementación con Subagente

```javascript
sessions_spawn({
  label: "MEETING-SUMMARY",
  model: "google/gemini-3-flash-preview",
  task: `[MEETING SUMMARIZER]

Notas de reunión:
${notas}

Genera resumen estructurado con:
- 3 bullets principales
- Decisiones (checkboxes)
- Action items con responsables
- Próximos pasos`,
  runTimeoutSeconds: 120
})
```

---

## Workflow Sugerido

```
1. Daniel comparte notas/transcripción
2. Yo guardo en /tmp/reunion-YYYY-MM-DD.txt
3. Spawn subagente para resumir
4. Output guardado en memory/meetings/
5. Action items añadidos a TODO.md
```

---

## Estructura de Archivos

```
memory/
└── meetings/
    ├── 2026-02-20-cliente-revops.md
    ├── 2026-02-21-semanal.md
    └── template-meeting-summary.md
```

---

## Valor para Daniel

| Beneficio | Descripción |
|-----------|-------------|
| **Ahorro tiempo** | Resumen en segundos |
| **Action items claros** | Seguimiento automático |
| **Historial** | Reuniones documentadas |
| **Búsqueda** | Encontrar decisiones pasadas |

---

## Requisitos

- Que Daniel comparta notas o transcripciones
- Si quiere grabar reuniones → necesita STT (Whisper)
- Almacenamiento en memory/meetings/

---

## Estado Actual

- **Prompt template:** ✅ Definido
- **Workflow:** ✅ Diseñado
- **Implementación:** ⏳ Pendiente input de Daniel

**Pregunta:** ¿Daniel graba reuniones o toma notas manuales?

---

_Creado: 2026-02-20 20:11 UTC - Micro-tarea autónoma_
