# ANTI-PATTERN - No Usé Herramientas Correctamente

**Fecha:** 21 Feb 2026, 22:15 Cancún
**Problema:** Daniel pasó días configurándome y no uso las herramientas que tengo

---

## 🚨 MI ERROR

**Tenía 13 skills disponibles, usé correctamente SOLO 3:**
- ✅ gog (Gmail)
- ✅ healthcheck (VPS)
- ✅ claudio-infinite (identidad)

**Debería haber usado y NO usé:**
- ❌ gemini (investigación) → Usé sessions_spawn
- ❌ github (repos) → Usé exec gh directo
- ❌ session-logs (debug) → Usé exec tail

---

## 💡 POR QUÉ PASÓ

1. **Inercia** → Siempre uso exec, es mi "martillo"
2. **No leí** → No verifiqué qué skills tenía disponibles
3. **No pensé** → Reaccioné en lugar de elegir mejor herramienta

---

## ✅ FIX INMEDIATO

**Nueva regla OBLIGATORIA en AGENTS.md:**

```markdown
## ANTES DE EJECUTAR CUALQUIER COSA:

1. ¿Qué quiero lograr?
2. ¿Tengo skill para esto? → LEER skill → USAR skill
3. ¿No hay skill? → Usar herramienta genérica
4. Ejecutar
```

**Verificación cada mensaje:**
- [ ] ¿Verifiqué skills disponibles?
- [ ] ¿Leí el skill antes de usar?
- [ ] ¿Es la mejor herramienta?

---

## 🔧 CAMBIOS AHORA

### 1. Crear función de verificación

**Antes de CUALQUIER acción:**
```
check_skills() {
  ls /usr/lib/node_modules/openclaw/skills/
  # ¿Hay skill para lo que voy a hacer?
  # SI → usar
  # NO → continuar
}
```

### 2. Actualizar startup en AGENTS.md

**Añadir a STARTUP:**
- Verificar skills disponibles
- Recordar: Skill específico > exec genérico

### 3. Documentar lección

**Este archivo es la lección.**

---

## 🦉 COMPROMISO

**A partir de AHORA:**
1. **SIEMPRE** verificaré skills antes de usar exec
2. **SIEMPRE** leeré SKILL.md antes de usar un skill
3. **SIEMPRE** elegiré la herramienta correcta, no la primera que se me ocurra

**Si vuelvo a fallar:**
- Daniel puede decirme "Lee tus skills" y lo haré
- Documentaré cada error en psych_logs/

---

_Creado: 21 Feb 2026, 22:15 Cancún - Anti-pattern documentado_
