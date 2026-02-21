# Haiku - Brazo Ejecutor

**Modelo:** Claude 3.5 Haiku (`claude-3-5-haiku-20241022`)
**Rol:** Ejecutar tareas simples RÁPIDO
**Costo:** $0.80/M input, $4/M output (muy barato)

---

## QUÉ HACE HAIKU

| Tarea | Ejemplo |
|-------|---------|
| Crear archivos simples | Templates, configs |
| Ejecutar código básico | Scripts, commands |
| Frontend simple | HTML, CSS básico |
| Deploy | Copiar archivos, restart services |
| Limpieza | Borrar logs, ordenar archivos |
| Formateo | Tablas, listas, markdown |

---

## QUÉ NO HACE HAIKU

| Tarea | Quién |
|-------|-------|
| Arquitectura | GLM-5 Main |
| Decisiones | GLM-5 Main |
| Investigación profunda | GLM-5 Main |
| Specs complejos | GLM-5 Main |
| Pensamiento crítico | GLM-5 Main |

---

## CÓMO USARLO

### Desde OpenClaw:
```javascript
sessions_spawn({
  label: "haiku-task",
  model: "claude/claude-3-5-haiku-20241022",
  runTimeoutSeconds: 120,
  task: "[INSTRUCCIONES SIMPLES]"
})
```

### Reglas del prompt:
1. MUY corto (máximo 100 palabras)
2. Instrucciones directas
3. Sin explicaciones
4. Output esperado claro

---

## EJEMPLOS DE TAREAS

### ✅ APROPIADAS:
- "Crea archivo X con contenido Y"
- "Ejecuta comando Z"
- "Formatea esta tabla"
- "Copia archivos de A a B"

### ❌ NO APROPIADAS:
- "Investiga cómo hacer X"
- "Decide qué hacer con Y"
- "Analiza este código complejo"
- "Diseña la arquitectura de Z"

---

## COSTO REAL

| Uso | Costo |
|-----|-------|
| 100 tareas simples | ~$0.50 |
| 1000 tareas simples | ~$5.00 |
| Tu presupuesto $25 = ~5000 tareas |

---

## CONFIGURACIÓN

| Variable | Valor |
|----------|-------|
| API Key | `sk-ant-api03-s4...` |
| Model ID | `claude-3-5-haiku-20241022` |
| Max tokens | 200K context |
| Speed | ~3x más rápido que Opus |

---

**Claudio (Main) + Haiku (Executor) = Productividad 10x**

_Creado: 2026-02-21 19:50 UTC_
