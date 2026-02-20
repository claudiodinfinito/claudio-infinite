# Verificación de Sistemas Autónomos

**ID:** REF-AUTONOMOUS-VERIFY-001
**Propósito:** Checklist rápido para verificar que los sistemas autónomos funcionan
**Tiempo:** 2 minutos

---

## ✅ Checklist de Verificación

### 1. Cronjobs Activos
```bash
openclaw cron list
```
- ¿Micro-task cada 5 min? ✅
- ¿Health check diario? ✅
- ¿API usage diario? ✅

### 2. Última Ejecución
```bash
# Ver logs recientes
tail -50 /tmp/openclaw/openclaw-$(date +%Y-%m-%d).log | grep -i cron
```
- ¿Hay "completed successfully"? ✅
- ¿Hay errores? → Ver `memory/rbk-cronjob-errors.md`

### 3. Subagentes
```bash
openclaw sessions list --kinds subagent --active-minutes 60
```
- ¿Hay sesión activa? ✅ = Trabajando

### 4. Commits Recientes
```bash
git log --oneline -5
```
- ¿Hay commits de "docs:" o "feat:"? ✅ = Subagente produciendo

### 5. Archivos Creados Hoy
```bash
find memory/ -type f -mtime -1 | wc -l
```
- ¿>0 archivos? ✅ = Autonomía funcional

---

## 🚨 Síntomas de Fallo

| Síntoma | Causa | Fix |
|---------|-------|-----|
| "STILL" repetitivo | Subagente pasivo | Actualizar prompt |
| Sin commits en 1h | Rate limit | Cambiar modelo |
| Cronjob "delivery failed" | GLM-5 ocupado | Mover a Gemini |
| Session locked | .lock files | `rm *.lock` |

---

## 📊 Estado Esperado

| Sistema | Frecuencia | Output |
|---------|------------|--------|
| Micro-task | 5 min | 1 archivo + 1 commit |
| Heartbeat | 30 min | Check sistema |
| Health VPS | Diario 06:00 | Status report |
| API check | Diario 18:00 | Usage report |
| Daily log | Diario 22:00 | Memory update |

---

_Creado: 2026-02-20 19:30 UTC — Tarea autónoma de 3 min_
