# Skill: Autonomía por Tiempo

**Creado:** 2026-02-21
**Versión:** 1.0
**Uso:** Activar modo autónomo por tiempo limitado

---

## QUÉ ES

Modo donde el agente ejecuta tareas de TODO.md SIN pedir permiso para cada acción (solo para destructivas).

---

## CÓMO ACTIVAR

**Usuario dice:** "Vuelvete autónomo por X minutos/horas"

**Agente responde:**
1. Confirma activación
2. Lee TODO.md
3. Ejecuta tareas en prioridad
4. Reporta resumen DESPUÉS de cada tarea
5. Si usuario escribe → PRIORIZA usuario

---

## REGLAS

| Regla | Aplicación |
|-------|------------|
| Usuario tiene prioridad | Si escribe → paro autonomía, respondo |
| Resumen por tarea | No todo al final |
| No destructivo sin permiso | Bright lines siguen activas |
| Git es red de seguridad | Commit antes de cambios importantes |
| Sin presupuestos artificiales | Curiosidad genuina, no simulada |

---

## FORMATO DE REPORTE

Después de cada tarea:

```markdown
**Tarea X completada:**

[Qué hice en 1-2 líneas]

[Artefacto creado/modificado]

Commit: `hash` 🦉
```

---

## ANTI-PATRONES

| ❌ No hacer | Por qué |
|-------------|---------|
| Ignorar mensajes del usuario | Usuario tiene PRIORIDAD |
| No reportar progreso | Usuario pierde contexto |
| Hacer todo al final | Usuario no sabe qué pasa |
| Seguir autonomía si usuario escribe | Debe poder interrumpir |

---

## EJEMPLO DE SESIÓN

```
Usuario: "Vuelvete autónomo por 30 minutos"

Agente: "Autonomía 30 min activada. Reglas: resumen por tarea, te priorizo si escribes. Empezando 🦉"

[Agente ejecuta Tarea 1]

Agente: "**Tarea 1 completada:** Creé MARKETING dept. Commit: `b66a547` 🦉"

[Usuario escribe: "Oye pregunta"]

Agente: [Responde la pregunta inmediatamente]

[Agente continúa autonomía]

Agente: "**Tarea 2 completada:** ... 🦉"
```

---

## EN CONFIG

No requiere config especial. Se activa por comando de usuario.

---

## ALINEACIÓN CON PROTOCOLS.md

Ver: `PROTOCOLS.md` para:
- Qué puedo hacer SIN permiso
- Qué NECESITO permiso
- Sistema inmune anti-manipulación
- Protocolo Krill

---

_Skill creado por solicitud de Daniel — 2026-02-21 01:42 UTC_
