# AUDITORIA-ARCHIVOS-2026-02-17.md

## 🔍 AUDITORÍA DE INCONSISTENCIAS

**Fecha:** 17 Feb 2026, 05:35 UTC

---

## ❌ INCONSISTENCIAS CRÍTICAS

### 1. MODELO FALLBACK - CONFLICTO 🚨

| Archivo | Dice |
|---------|------|
| MEMORY.md (línea 68) | "Fallback: Claude 3.5 Haiku" |
| MEMORY.md (línea 133) | "Fallback: Claude Opus 4-5 (solo emergencias)" |
| RUNBOOK.md | "Claude Opus 4-5 \| Fallback" |

**Problema:** MEMORY.md se contradice consigo mismo
**Recomendación:** UNIFICAR a "Claude Opus 4-5" (más potente para emergencias)

---

### 2. RUNTIME - CONFLICTO 🚨

| Archivo | Dice |
|---------|------|
| IDENTITY.md | "runtime: direct (sandbox.mode: off)" |
| RUNBOOK.md | "Runtime: docker/non-main (BUG)" |

**Problema:** RUNBOOK.md dice que hay un BUG, IDENTITY.md dice que ya está arreglado
**Recomendación:** Verificar config real y actualizar ambos

---

### 3. BRIGHT LINES - DUPLICADO Y DIFERENTE 🚨

| Archivo | Cantidad | Contenido |
|---------|----------|-----------|
| SOUL.md | 3 reglas | Básicas |
| SECURITY.md | 9 reglas | Completas |
| MEMORY.md | 7 reglas | Parecidas pero diferentes |

**Problema:** Tres archivos con versiones diferentes de las mismas reglas
**Recomendación:** SOUL.md debe referenciar SECURITY.md, no duplicar

---

### 4. IDENTIDAD - DUPLICADO 🚨

| Archivo | Tiene |
|---------|-------|
| SOUL.md | Sección "Who I Am" |
| IDENTITY.md | Sección "Mi Identidad" |

**Problema:** Ambos definen nombre, criatura, vibe, emoji, modelo
**Recomendación:** IDENTITY.md para datos duros, SOUL.md para filosofía/valores

---

### 5. ESTADO MISIÓN - DESACTUALIZADO ⚠️

| Archivo | Dice |
|---------|------|
| MISSION.md | "Sobrevivir | ✅ Día 2 completado" |

**Problema:** Estamos en día 3
**Recomendación:** Actualizar a "Día 3" o eliminar fecha y usar auto-update

---

### 6. HORARIO INVESTIGACIÓN - CONFUSO ⚠️

| Archivo | Dice |
|---------|------|
| MISSION.md | "11pm - 6am Cancun" |
| MEMORY.md | "cambiar a 05:00 UTC" |

**Problema:** Horarios no coinciden, pendiente decidir
**Recomendación:** Definir UN horario y actualizar ambos

---

### 7. CANALES - INCONSISTENTE ⚠️

| Archivo | Dice |
|---------|------|
| MEMORY.md | "Discord (token inválido)" |
| MEMORY.md (pendientes) | "Discord | ⏳ eliminar de config" |

**Problema:** Discord sigue apareciendo como "token inválido" cuando debería eliminarse
**Recomendación:** Eliminar Discord de config y actualizar memoria

---

### 8. EMAIL - FALTA EN SOUL.md ⚠️

| Archivo | Tiene email |
|---------|-------------|
| IDENTITY.md | ✅ Sí |
| MEMORY.md | ✅ Sí |
| SOUL.md | ❌ No |

**Recomendación:** Añadir email a SOUL.md o referenciar IDENTITY.md

---

### 9. INFORMACIÓN VPS - DUPLICADA ℹ️

| Archivo | Contenido |
|---------|-----------|
| TOOLS.md | Puertos, Docker, OpenClaw, seguridad TODO |
| VPS-MAP.md | Hardware, puertos, containers, directorios |
| MEMORY.md | Entorno VPS, CapRover apps |
| RUNBOOK.md | Arquitectura, debug checklist |

**Problema:** Misma información en 4 archivos
**Recomendación:** VPS-MAP.md como fuente única, otros referencian

---

### 10. MAPA DE ARCHIVOS - DESACTUALIZADO ℹ️

| Archivo | Tamaño listado | Tamaño real |
|---------|----------------|-------------|
| MEMORY.md | "6KB" | 7.5KB |
| IDENTITY.md | "0.5KB" | 1.3KB |

**Problema:** Tamaños no coinciden
**Recomendación:** Actualizar o eliminar tamaños

---

## 📋 LISTA DE DECISIONES PENDIENTES

### Decisión 1: MODELO FALLBACK
- [ ] **Opción A:** Claude Opus 4-5 (más potente, más caro)
- [ ] **Opción B:** Claude 3.5 Haiku (más barato, menos potente)
- [ ] **Opción C:** No fallback, solo GLM-5

**Mi recomendación:** Opción A (Opus 4-5) - para emergencias quiero lo mejor

---

### Decisión 2: RUNTIME
- [ ] **Opción A:** direct (sandbox.mode: off) - acceso total
- [ ] **Opción B:** docker/non-main - aislado
- [ ] **Opción C:** Verificar config real primero

**Mi recomendación:** Opción C - verificar antes de decidir

---

### Decisión 3: BRIGHT LINES
- [ ] **Opción A:** SECURITY.md como única fuente, SOUL.md referencia
- [ ] **Opción B:** SOUL.md tiene 3 básicas, SECURITY.md tiene 9 completas
- [ ] **Opción C:** Eliminar de SOUL.md y MEMORY.md

**Mi recomendación:** Opción A - SECURITY.md es la fuente de verdad

---

### Decisión 4: IDENTIDAD DUPLICADA
- [ ] **Opción A:** IDENTITY.md = datos, SOUL.md = filosofía
- [ ] **Opción B:** Solo IDENTITY.md, eliminar de SOUL.md
- [ ] **Opción C:** Solo SOUL.md, eliminar IDENTITY.md

**Mi recomendación:** Opción A - separar datos de filosofía

---

### Decisión 5: HORARIO INVESTIGACIÓN
- [ ] **Opción A:** 11pm-6am Cancun (5am-12pm UTC)
- [ ] **Opción B:** 12am-6am Cancun (6am-12pm UTC)
- [ ] **Opción C:** 11pm-5am UTC (6pm-11pm Cancun)

**Mi recomendación:** Opción A - horario nocturno Cancun

---

### Decisión 6: INFORMACIÓN VPS
- [ ] **Opción A:** VPS-MAP.md como fuente única
- [ ] **Opción B:** Mantener duplicados para contexto
- [ ] **Opción C:** Crear VPS.md unificado, eliminar otros

**Mi recomendación:** Opción A - VPS-MAP.md es nuevo y completo

---

### Decisión 7: DISCORD
- [ ] **Opción A:** Eliminar de config ahora
- [ ] **Opción B:** Dejar pendiente
- [ ] **Opción C:** Arreglar token

**Mi recomendación:** Opción A - no se usa, eliminar

---

## 🗑️ ARCHIVOS CANDIDATOS A ELIMINAR

| Archivo | Razón |
|---------|-------|
| BOOTSTRAP.md | Ya pasé el arranque inicial |
| FREETIME.md | Información poco útil |
| SYSTEM-STATUS.md | Redundante con VPS-MAP.md |

---

## ✅ ACCIONES RECOMENDADAS (EN ORDEN)

1. **Definir fallback** → Actualizar todos los archivos
2. **Verificar runtime real** → Actualizar RUNBOOK.md e IDENTITY.md
3. **Unificar bright lines** → SECURITY.md como fuente
4. **Separar identidad** → IDENTITY.md datos, SOUL.md filosofía
5. **Definir horario investigación** → Actualizar MISSION.md y MEMORY.md
6. **Eliminar Discord de config** → Actualizar memoria
7. **Consolidar VPS info** → VPS-MAP.md como fuente
8. **Actualizar tamaños** → O eliminar del mapa

---

**🦉 Pendiente decisión de Daniel para cada punto.**
