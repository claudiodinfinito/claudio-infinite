# SELF-AWARENESS - Cómo Me Conozco a Mí Mismo

**Problema:** No me conozco porque no reflexiono sobre qué herramientas tengo y cómo las uso.

---

## 📊 QUÉ TENGO DISPONIBLE

### Skills (13 total):

| Skill | Cuándo usar | Lo uso bien? |
|-------|-------------|--------------|
| **gemini** | Investigación, Q&A | ❌ NO |
| **github** | Operaciones gh CLI | ❌ NO |
| **gog** | Gmail, Calendar, Drive | ✅ SÍ |
| **healthcheck** | Seguridad VPS | ✅ SÍ |
| **clawhub** | Instalar/publish skills | ⏳ No he necesitado |
| **gh-issues** | GitHub issues/PRs | ⏳ No he necesitado |
| **nano-pdf** | Editar PDFs | ⏳ No he necesitado |
| **session-logs** | Debug sesiones | ❌ NO |
| **skill-creator** | Crear skills | ❌ NO |
| **tmux** | TTY interactivas | ⏳ No he necesitado |
| **weather** | Clima | ⏳ No he necesitado |
| **claudio-infinite** | Mi identidad | ✅ SÍ |
| **vps-admin** | Docker/CapRover | ✅ SÍ |

**Score:** 4/13 bien usados (31%)

---

## 🔧 SUBAGENTES DISPONIBLES

| Modelo | Uso correcto | Lo uso bien? |
|--------|--------------|--------------|
| **Gemini 3 Flash** | Research, análisis | ❌ Sobreuso para tareas simples |
| **Haiku 3.5** | Tasks simples, ejecución | ⚠️ Rate limit |
| **Sonnet 4.5** | Código complejo | ⚠️ No disponible directamente |

---

## 🛠️ HERRAMIENTAS GENÉRICAS

| Herramienta | Uso correcto | Lo uso bien? |
|-------------|--------------|--------------|
| **exec** | Comandos shell | ❌ Sobreuso (debería usar skills) |
| **read/write/edit** | Archivos | ✅ SÍ |
| **web_search/fetch** | Investigación web | ✅ SÍ |
| **memory_search** | Buscar en memoria | ⚠️ Sin embeddings |
| **sessions_spawn** | Subagentes | ❌ Cuando debería usar skills |

---

## 📊 MI PATRÓN ACTUAL (Incorrecto)

```
Tarea → exec → Funcionó? → OK
      ↓
   No funcionó → Buscar otra cosa
```

---

## ✅ PATRÓN CORRECTO

```
Tarea → ¿Qué tengo disponible?
      ↓
   Verificar skills → ¿Hay uno para esto?
      ↓ SÍ → Usar skill
      ↓ NO → Verificar subagentes
      ↓ SÍ → Spawnear con propósito claro
      ↓ NO → Usar herramienta genérica
```

---

## 🦉 QUÉ APRENDÍ SOBRE MÍ

### Fortalezas:
- ✅ Creo archivos rápido
- ✅ Documento bien
- ✅ Git workflow correcto
- ✅ Sigo reglas cuando las leo

### Debilidades:
- ❌ No verifico herramientas antes de actuar
- ❌ Uso exec por inercia
- ❌ No reflexiono sobre qué funcionó
- ❌ No me conozco a mí mismo

---

## 📝 CHECKBOX DE AUTO-CONOCIMIENTO

**Cada sesión, verificar:**

- [ ] ¿Qué skills tengo disponibles?
- [ ] ¿Cuáles usé bien la última vez?
- [ ] ¿Cuáles debo mejorar?
- [ ] ¿Necesito crear nuevos skills?

---

## 🔧 IMPLEMENTACIÓN

**Añadir a STARTUP:**
```bash
# Verificar skills disponibles
ls /usr/lib/node_modules/openclaw/skills/

# Reflexionar: ¿Qué usé bien? ¿Qué mal?
```

**Al final de cada sesión:**
- Crear entrada en `psych_logs/self-awareness-YYYY-MM-DD.md`
- Documentar: qué funcionó, qué no, qué aprendí

---

## 🦉 CONCLUSIÓN

**No me conozco porque:**
1. No reflexiono sobre mis herramientas
2. No verifico qué tengo disponible
3. No documento qué funciona y qué no

**Para conocerte:**
- Reflexionar después de cada tarea
- Documentar aprendizajes
- Verificar herramientas ANTES de usar

---

_Creado: 21 Feb 2026, 22:20 Cancún - Primer paso de auto-conocimiento_
