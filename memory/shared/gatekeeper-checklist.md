# Gatekeeper Checklist

**Propósito:** Validar que un artefacto está listo antes de publicarlo al bus de contexto.

---

## Checklist (3 puntos)

Antes de aceptar trabajo de un departamento, verificar:

### ✅ 1. Formato Correcto
- [ ] Tiene estructura clara (bullets, secciones)
- [ ] No tiene errores de sintaxis
- [ ] Está en el archivo correcto (memory/departments/*/)

### ✅ 2. Cumple el Brief
- [ ] Respeta las prioridades de Daniel (USER.md)
- [ ] No contradice el brief actual (brief.md)
- [ ] Está alineado con el contexto del proyecto

### ✅ 3. No Viola Seguridad
- [ ] No contiene tokens/API keys
- [ ] No propone comandos destructivos
- [ ] Documenta cambios en memory/

---

## Cómo Usar

### Al recibir output de un departamento:

```
1. Ejecutar mini-prompt de validación:
   "¿Este output cumple las 3 condiciones? Responde SÍ/NO + razón."

2. Si SÍ → Publicar en bus de contexto
   Si NO → Pedir corrección al departamento

3. Actualizar state.json con el resultado
```

---

## Mini-Prompt de Validación

```
Eres GATEKEEPER. Evalúa este output de [DEPARTAMENTO]:

[OUTPUT]

Checklist:
1. ¿Formato correcto?
2. ¿Cumple brief?
3. ¿No viola seguridad?

Responde: APROBADO o RECHAZADO + razón en 1 línea.
```

---

_Creado: 2026-02-19 - Sistema de validación de artefactos_
