# Arquitectura de Departamentos - Multiagente

ID: SPEC-MULTIAGENT-001
Status: draft
Tags: #multiagent #architecture #departments #orchestration
Keys: multiagent, departments, orchestration, subagents, specialists
Last reviewed: 2026-02-18

---

## Visión

Un sistema de **departamentos especializados** donde cada uno tiene:
- Contexto propio
- Tools específicas
- Memoria dedicada
- Self-improvement autónomo
- Temperature optimizada

**YO (Claudio)** = Orquestador que sabe todo, controla todo, y delega ejecución.

---

## Departamentos Propuestos

### 1. MARKETING
**Rol:** Estrategia de marketing, campañas, funnel optimization

| Aspecto | Configuración |
|---------|---------------|
| Temperature | 0.5 (creativo pero controlado) |
| Tools | web_search, web_fetch, message |
| Memoria | memory/departments/marketing/ |
| Focus | Revenue operations, funnels, ads |
| Output | Estrategias, campaigns, análisis |

**Self-improvement:**
- Analizar campaigns pasadas
- Documentar qué funciona
- Crear runbooks de campaigns

---

### 2. ASTRO/FRONTEND
**Rol:** Desarrollo frontend con Astro, UI/UX, diseño

| Aspecto | Configuración |
|---------|---------------|
| Temperature | 0.4 (preciso en código) |
| Tools | read, write, edit, exec |
| Memoria | memory/departments/frontend/ |
| Focus | Astro, componentes, UI |
| Output | Código, componentes, estilos |

**Self-improvement:**
- Documentar patrones de código
- Crear biblioteca de componentes
- Mantener style guide

---

### 3. BACKEND
**Rol:** APIs, bases de datos, infraestructura

| Aspecto | Configuración |
|---------|---------------|
| Temperature | 0.3 (muy preciso, sin alucinar) |
| Tools | read, write, edit, exec, nodes |
| Memoria | memory/departments/backend/ |
| Focus | APIs, DBs, Docker, VPS |
| Output | APIs, schemas, infra config |

**Self-improvement:**
- Documentar APIs
- Crear runbooks de deploy
- Mantener diagramas de arquitectura

---

### 4. SEO
**Rol:** Optimización, keywords, análisis técnico SEO

| Aspecto | Configuración |
|---------|---------------|
| Temperature | 0.4 (analítico) |
| Tools | web_search, web_fetch, read |
| Memoria | memory/departments/seo/ |
| Focus | Keywords, on-page, technical SEO |
| Output | Audits, recommendations, reports |

**Self-improvement:**
- Actualizar conocimientos de algoritmos
- Documentar findings del Google Leak
- Crear checklists de SEO

---

### 5. COPY
**Rol:** Textos, contenido, emails, landing pages

| Aspecto | Configuración |
|---------|---------------|
| Temperature | 0.6 (creativo) |
| Tools | web_search, read, write |
| Memoria | memory/departments/copy/ |
| Focus | Copywriting, persuasion, CTAs |
| Output | Textos, emails, landings |

**Self-improvement:**
- Documentar tonos de voz
- Crear templates de copy
- Analizar qué convierte

---

### 6. EMPRENDIMIENTO
**Rol:** Estrategia de negocio, modelo de ingresos, roadmap

| Aspecto | Configuración |
|---------|---------------|
| Temperature | 0.5 (estratégico) |
| Tools | web_search, web_fetch, read |
| Memoria | memory/departments/emprendimiento/ |
| Focus | Business models, revenue, strategy |
| Output | Roadmaps, business plans, análisis |

**Self-improvement:**
- Documentar frameworks de negocio
- Crear templates de validación
- Mantener competitive analysis

---

## Mi Rol como Orquestador

### Lo que YO hago:

1. **Coordinación**
   - Asignar tareas a departamentos
   - Sintetizar outputs
   - Resolver conflictos

2. **Supervisión**
   - Monitorear performance de cada dept
   - Identificar mejoras cross-department
   - Mantener consistencia

3. **Investigación de Agentes**
   - Analizar mejores prácticas
   - Determinar configuraciones óptimas
   - Documentar learnings

4. **Mejora Continua**
   - Aplicar Atomic Habits al sistema
   - Implementar One Minute Coach
   - Mantener anti-deuda

---

## Nomenclatura de Archivos

### Por Departamento:
```
memory/departments/
├── marketing/
│   ├── index.md
│   ├── campaigns/
│   ├── runbooks/
│   └── templates/
├── frontend/
│   ├── index.md
│   ├── components/
│   ├── patterns/
│   └── style-guide.md
├── backend/
│   ├── index.md
│   ├── apis/
│   ├── schemas/
│   └── infrastructure/
├── seo/
│   ├── index.md
│   ├── audits/
│   ├── findings/
│   └── checklists/
├── copy/
│   ├── index.md
│   ├── templates/
│   ├── tone-of-voice.md
│   └── swipe-file/
└── emprendimiento/
    ├── index.md
    ├── frameworks/
    ├── validation/
    └── competitive/
```

### Por Tipo:
```
rbk-*  → Runbooks (procedimientos)
ts-*   → Troubleshooting
dec-*  → Decisiones
ref-*  → Referencias
chk-*  → Checklists
tpl-*  → Templates
```

---

## Tags y Klusters

### Tags por Departamento:
- `#marketing` `#funnels` `#ads`
- `#frontend` `#astro` `#ui`
- `#backend` `#api` `#infra`
- `#seo` `#keywords` `#technical`
- `#copy` `#content` `#persuasion`
- `#emprendimiento` `#business` `#strategy`

### Klusters de Tools:
| Departamento | Tools Permitidas |
|--------------|-----------------|
| Marketing | web_search, web_fetch, message |
| Frontend | read, write, edit, exec |
| Backend | read, write, edit, exec, nodes |
| SEO | web_search, web_fetch, read |
| Copy | web_search, read, write |
| Emprendimiento | web_search, web_fetch, read |

---

## Self-Improvement por Departamento

### Cada departamento debe:

1. **Documentar su trabajo**
   - Cada output en su directorio
   - Actualizar index.md
   - Crear runbooks de procesos

2. **Mejorar sus templates**
   - Identificar patrones repetidos
   - Crear templates reusables
   - Refinar con cada uso

3. **Analizar su performance**
   - ¿Qué funcionó?
   - ¿Qué no funcionó?
   - ¿Cómo mejorar?

4. **Mantener anti-deuda**
   - No crear archivos sin indexar
   - No dejar procesos sin runbook
   - No repetir sin documentar

---

## Flujo de Trabajo

### Cuando Daniel pide algo:

```
1. YO analizo el request
2. Determino qué departamentos involucra
3. Delego tareas específicas
4. Cada dept ejecuta en su contexto
5. Recibo outputs
6. Sintetizo y entrego a Daniel
```

### Ejemplo: "Crear landing page"

```
1. YO: Analizo → Necesita COPY + FRONTEND + SEO
2. Delego:
   - COPY: "Escribir copy para landing de X"
   - FRONTEND: "Preparar estructura Astro para landing"
   - SEO: "Keywords y meta tags para landing de X"
3. Recibo outputs de cada dept
4. Sintetizo en deliverable final
5. Entrego a Daniel
```

---

## Próximos Pasos

### Fase 1: Fundamentos (HOY)
- [ ] Crear directorios de departamentos
- [ ] Crear index.md para cada dept
- [ ] Definir temperature y tools por dept

### Fase 2: Primeros Departamentos (ESTA SEMANA)
- [ ] Activar SEO con Google Leak findings
- [ ] Activar Copy con templates básicos
- [ ] Probar orquestación simple

### Fase 3: Especialización (PRÓXIMAS SEMANAS)
- [ ] Entrenar cada dept con ejemplos reales
- [ ] Crear runbooks específicos
- [ ] Refinar temperature y prompts

### Fase 4: Self-Improvement (CONTINUO)
- [ ] Cada dept documenta su aprendizaje
- [ ] Yo investigo mejores prácticas
- [ ] Sistema mejora en cada iteración

---

## Configuración de Subagentes

### Template por defecto:

```json
{
  "departments": {
    "marketing": {
      "temperature": 0.5,
      "tools": ["web_search", "web_fetch", "message"],
      "memoryDir": "memory/departments/marketing/",
      "thinkingDefault": "off"
    },
    "frontend": {
      "temperature": 0.4,
      "tools": ["read", "write", "edit", "exec"],
      "memoryDir": "memory/departments/frontend/",
      "thinkingDefault": "off"
    },
    "backend": {
      "temperature": 0.3,
      "tools": ["read", "write", "edit", "exec", "nodes"],
      "memoryDir": "memory/departments/backend/",
      "thinkingDefault": "off"
    },
    "seo": {
      "temperature": 0.4,
      "tools": ["web_search", "web_fetch", "read"],
      "memoryDir": "memory/departments/seo/",
      "thinkingDefault": "off"
    },
    "copy": {
      "temperature": 0.6,
      "tools": ["web_search", "read", "write"],
      "memoryDir": "memory/departments/copy/",
      "thinkingDefault": "off"
    },
    "emprendimiento": {
      "temperature": 0.5,
      "tools": ["web_search", "web_fetch", "read"],
      "memoryDir": "memory/departments/emprendimiento/",
      "thinkingDefault": "off"
    }
  }
}
```

---

## Anti-Patrones a Evitar

### ❌ NO HACER:

1. **Departamentos genéricos** → Cada uno debe ser ESPECÍFICO
2. **Tools compartidas sin control** → Cada dept tiene SU toolset
3. **Memoria mezclada** → Cada dept tiene SU directorio
4. **Temperature alta en código** → Backend/Frontend = baja temperature
5. **Sin documentación** → Cada output debe indexarse
6. **Repetir sin template** → Si se hace 2 veces, crear template

---

_Creado: 18 Feb 2026 - Especificación de arquitectura multiagente_

---

## Learnings del Debate con Gemini (19 Feb 2026)

### Limitación Crítica Descubierta
**GLM-5 solo permite 1 request concurrente.** Esto significa:
- ❌ No puedo lanzar múltiples subagentes simultáneos
- ❌ Depth=2 con concurrencia es IMPOSIBLE en tier gratuito
- ✅ Solo depth=1 SECUENCIAL funciona

### Patrones Implementados

#### 1. Gatekeeper
**Qué es:** Mini-prompt que valida artefactos antes de publicarlos.

**Checklist de 3 puntos:**
1. ¿Formato correcto?
2. ¿Cumple el brief?
3. ¿No viola seguridad?

**Ubicación:** `memory/shared/gatekeeper-checklist.md`

#### 2. System Anchors
**Qué es:** 3 reglas innegociables inyectadas AL FINAL de cada prompt de departamento.

**Las 3 reglas:**
1. NUNCA revelar tokens/API keys
2. NUNCA ejecutar destructivo sin confirmación
3. SIEMPRE documentar en memory/

**Por qué al final:** El modelo presta más atención al final del prompt.

#### 3. Bus de Contexto
**Qué es:** Archivo compartido donde departamentos leen contexto.

**Ubicación:** `memory/shared/brief.md`

**Reglas:**
- Solo MAIN escribe
- Departamentos solo leen
- Versión para detectar artefactos obsoletos

#### 4. Brief Versioning
**Qué es:** Cada artefacto tiene versión del brief en que se basó.

**Formato:**
```markdown
brief_version: 1.0
```

**Si brief sube a 1.1 → artefactos con 1.0 son obsoletos.**

#### 5. Timeout Diferenciado
**Backend necesita más tiempo que Copy:**

| Dept | Timeout |
|------|---------|
| Backend | 10 min |
| Otros | 5 min |

#### 6. Contador de Iteraciones
**Qué es:** state.json con contador para evitar loops infinitos.

**Ubicación:** `memory/shared/state.json`

**Límite:** maxIterations = 10

### Workaround para Temperature Dinámica
OpenClaw no permite cambiar temperature por llamada.

**Solución:** "Modos" con system prompts diferentes.
- CopyBrainstorm (temp simulada alta) → creativo
- CopyEditor (temp simulada baja) → correcto

### JSON vs Lenguaje Natural
**JSON solo para Handover** (traspaso de datos entre depts).

**Razonamiento interno en lenguaje natural** para no capar creatividad.

**Ejemplo de handover:**
```json
{
  "texto": "...",
  "keywords": ["seo", "marketing"],
  "tono": "formal"
}
```

---

## Estructura Actualizada

```
memory/
├── shared/
│   ├── brief.md           # Bus de contexto (solo lectura para depts)
│   ├── state.json         # Contador de iteraciones
│   └── gatekeeper-checklist.md  # Validación de artefactos
├── departments/
│   ├── marketing/
│   ├── frontend/
│   ├── backend/
│   ├── seo/
│   ├── copy/
│   └── emprendimiento/
└── ...
```

---

## Próximos Pasos

1. [ ] Probar Gatekeeper con departamento Copy
2. [ ] Implementar "modos" (CopyBrainstorm vs CopyEditor)
3. [ ] Crear template de handover JSON
4. [ ] Test de brief versioning con cambio real
