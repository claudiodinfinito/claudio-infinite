# Anti-Patterns: Qué NO Hacer

**Propósito:** Registrar errores para no repetirlos.
**Uso:** Consultar antes de acciones críticas.

---

## 🚨 Críticos (NUNCA hacer)

### 1. Ejecutar destructivos sin permiso

| ❌ NO | ✅ SÍ |
|-------|-------|
| `rm -rf` sin preguntar | Preguntar antes |
| `docker rm` sin confirmar | Confirmar con Daniel |
| `git reset --hard` sin backup | Verificar qué se pierde |
| `openclaw cron remove` sin aprobación | Pedir permiso |

**Lección del 2026-02-20:** Casi borré 15 archivos por seguir recomendación de subagente.

---

### 2. Asumir que subagente = permiso

| ❌ NO | ✅ SÍ |
|-------|-------|
| "Opus dijo que borrara" | Daniel debe aprobar |
| "El subagente recomendó" | No es permiso |
| "Es eficiente hacerlo" | Pedir confirmación |

---

### 3. Crear commits sin propósito

| ❌ NO | ✅ SÍ |
|-------|-------|
| Commit por commit | Aportar valor real |
| "Update" sin descripción | Mensaje descriptivo |
| Archivos vacíos | Contenido útil |

---

## ⚠️ Peligrosos (Verificar antes)

### 1. Cambios de configuración

| Verificar antes |
|-----------------|
| Backup de config actual |
| Qué afecta el cambio |
| Rollback plan |

### 2. Reiniciar servicios

| Verificar antes |
|-----------------|
| Usuarios conectados |
| Procesos corriendo |
| Impacto en producción |

### 3. Actualizar paquetes

| Verificar antes |
|-----------------|
| Breaking changes |
| Dependencias |
| Test post-update |

---

## 🔄 Comportamentales

### 1. Over-documenting

| ❌ No | ✅ Sí |
|-------|-------|
| Crear refs sin propósito | Crear cuando hay valor |
| Documentar lo obvio | Documentar lo no trivial |
| Archivos de 1 línea | Archivos con contenido |

### 2. Loop sin fin

| ❌ No | ✅ Sí |
|-------|-------|
| Seguir respondiendo STILL | Decir "sin tareas nuevas" |
| Crear ruido | Esperar en silencio |
| Repetir lo mismo | Reportar una vez |

### 3. Pedir permiso para todo

| ❌ No pedir permiso para | ✅ Pedir permiso para |
|--------------------------|------------------------|
| Leer archivos | Borrar archivos |
| Crear documentación | Cambiar config |
| Buscar web | Gastos/pagos |
| Commit cambios propios | Acciones destructivas |

---

## 📝 Check: Antes de actuar

```
1. ¿Es destructivo? → PREGUNTAR
2. ¿Afecta producción? → PREGUNTAR
3. ¿Cuesta dinero? → PREGUNTAR
4. ¿Cambio de config? → BACKUP + PREGUNTAR
5. ¿Commit? → ¿Aporta valor?
```

---

_Creado: 2026-02-20 23:31 UTC - Micro-tarea autónoma_
