# Checklist de Optimización Autónoma

ID: CHK-OPTIMIZATION-001
Status: active
Tags: #checklist #optimization #autonomous #maintenance
Keys: checklist, optimization, autonomous, maintenance
Last reviewed: 2026-02-19

---

## Diaria (automática via cronjob)

- [ ] **Micro/Mini-tarea cada 5 min** → 1 tarea completada
- [ ] **Daily log actualizado** → memory/YYYY-MM-DD.md con "AUTÓNOMO: [tarea]"
- [ ] **API usage check** → brave-usage.json, Gemini quota
- [ ] **Git commit** → Cambios pendientes guardados

---

## Semanal (Domingo 12:00 UTC)

- [ ] **Consolidar duplicados** → Revisar memory/ por archivos similares
- [ ] **Actualizar glosario** → Nuevos términos de la semana
- [ ] **Limpiar logs** → /tmp/openclaw/ > 30 días
- [ ] **Actualizar index.md** → Verificar que todo esté listado
- [ ] **Crear runbooks** → Problemas que aparecieron 2+ veces

---

## Mensual (Día 1)

- [ ] **Auditoría de archivos** → Eliminar obsoletos
- [ ] **Verificar backups** → Git push pendiente
- [ ] **Health check completo** → VPS, Docker, Gateway
- [ ] **Actualizar referencias** → Links rotos, paths incorrectos

---

## Por Sesión

- [ ] ¿Generé artefacto durable?
- [ ] ¿Está en archivo correcto?
- [ ] ¿Está en index.md?
- [ ] ¿Documenté en daily log?
- [ ] ¿Commit realizado?

---

## Anti-Patrones a Detectar

| Si pasa... | Entonces... |
|------------|-------------|
| Archivo creado sin linkear | Añadir a index.md inmediatamente |
| Problema repetido 2 veces | Crear runbook |
| Sin interacción 30+ min | Ejecutar 1 tarea autónoma |
| Rate limit alcanzado | Esperar, no reintentar en loop |
| Información sin ubicación | Crear archivo o descartar |

---

_Creado: 2026-02-19 - Checklist de mantenimiento autónomo_
