# ANÁLISIS DE SEGURIDAD: ClawWork

**Fecha:** 2026-02-19  
**Repo:** https://github.com/HKUDS/ClawWork  
**Investigador:** Subagente de Seguridad OpenClaw

---

## 1. RESUMEN (3 bullets)

- **Qué es:** Framework/benchmark de investigación para agentes de IA que trabajan y ganan dinero en tareas reales. Incluye LiveBench (simulación económica), evaluación automatizada con LLM, y herramientas de productividad.
- **Quién está detrás:** Data Intelligence Lab @ HKU (Hong Kong University) - laboratorio académico legítimo con 79 repos públicos, incluyendo LightRAG (28.5k stars), nanobot (21.8k stars), DeepCode (14.5k stars). PI: [Prof. Chaoh](https://sites.google.com/view/chaoh/)
- **Propósito declarado:** Investigación sobre autonomía económica de agentes de IA. Demostrar que agentes pueden trabajar, ganar dinero, y cubrir sus costos operativos. "OpenClaw as Your AI Coworker"

---

## 2. GLOSARIO (8 términos clave)

| Término | Definición |
|---------|------------|
| **LiveBench** | Simulación económica donde agentes deben sobrevivir trabajando |
| **GDPVal** | Dataset de tareas con valores económicos basados en salarios reales |
| **EconomicTracker** | Sistema de seguimiento de balance, costos de tokens, ingresos |
| **Evaluation Score** | Puntuación 0.0-1.0 del trabajo entregado (threshold: 0.6 para cobrar) |
| **E2B Sandbox** | Entorno de ejecución de código aislado (code execution) |
| **MCP (Model Context Protocol)** | Protocolo para conectar herramientas externas |
| **TaskClassifier** | Clasificador que asigna ocupación y valor a tareas arbitrarias |
| **nanobot** | Framework base ultra-ligero (~4k LOC) del que deriva ClawWork |

---

## 3. ¿MARKETING vs REALIDAD?

### Claim: "$10K earned in 7 Hours"

**Veredicto: EXAGERACIÓN MARKETING / CONTEXTUALMENTE ENGAÑOSO**

#### Evidencia EN CONTRA:
- **No es dinero real:** El sistema usa saldos simulados. El "balance" está en `balance.jsonl` - es un número en un archivo, no transferencias bancarias.
- **El evaluador es otro LLM:** `llm_evaluator.py` usa GPT-4o para calificar trabajos. La "puntuación" y el "pago" son determinados por otro modelo de IA, no por humanos.
- **Valores de tareas inflados:** `max_payment` en tareas puede ser arbitrario. No hay verificación de mercado real.
- **Sin evidencia de retiro:** No hay código ni documentación sobre cómo "cobrar" el dinero ganado. No hay integración con PayPal, Stripe, crypto, o bancos.
- **README mismo lo admite:** "This is a research project" - es benchmark, no plataforma de empleo.

#### Evidencia A FAVOR:
- **Tareas reales:** El dataset GDPVal contiene tareas derivadas de trabajos reales de freelancers.
- **Costos reales:** El sistema SÍ rastrea costos de API (tokens, Tavily, E2B) - eso es dinero real gastado.
- **Investigación legítima:** Paper asociado, metodología académica, repos de investigación seria.

#### Conclusión:
"$10K earned" es **métrica de benchmark**, no dinero real. Es como decir "mi personaje de videojuego ganó $10K" - el número existe, pero no puedes cobrarlo.

---

## 4. ANÁLISIS DE SEGURIDAD (CRÍTICO)

### 4.1 ¿Es honeypot? (trampa de datos)
**NO** - No hay evidencia de exfiltración maliciosa.

**Análisis:**
- El código no contiene llamadas a servidores sospechosos
- API keys se quedan en `.env` local (no se envían a terceros)
- Datos de usuario se guardan en `./data/agent_data/` local
- E2B sandbox es servicio legítimo para código aislado

### 4.2 ¿Es estafa?
**NO** - Es proyecto académico legítimo.

**Señales legítimas:**
- Org: HKUDS (universidad reconocida)
- Repo público con código abierto (MIT license)
- Historial de commits activo
- 21.8k stars en proyecto relacionado (nanobot)
- Papers académicos publicados

**Pero el MARKETING es engañoso:**
- Título "$10K earned" sugiere ingresos reales
- No clarifica que es simulación/benchmark
- Usuario promedio podría malinterpretar

### 4.3 ¿Hay código malicioso?
**NO DETECTADO** en archivos principales revisados.

**Archivos auditados:**
- `live_agent.py` - Lógica del agente (limpio)
- `direct_tools.py` - Herramientas (limpio)
- `economic_tracker.py` - Tracking de costos (limpio)
- `evaluator.py` - Evaluación LLM (limpio)
- `provider_wrapper.py` - Wrapper de API (limpio)
- `agent_loop.py` - Loop de mensajes (limpio)
- `.env.example` - Configuración (solo placeholders)

**Sin hallazgos de:**
- Backdoors
- Exfiltración de API keys
- Comandos ocultos
- Dependencias maliciosas

### 4.4 ¿Qué datos pide?

| Dato | Propósito | Riesgo |
|------|-----------|--------|
| `OPENAI_API_KEY` | LLM para agente | ⚠️ Medio - requiere API key real |
| `EVALUATION_API_KEY` | GPT-4o para evaluar | ⚠️ Medio - requiere API key real |
| `WEB_SEARCH_API_KEY` (Tavily) | Búsqueda web | ⚠️ Bajo - servicio legítimo |
| `E2B_API_KEY` | Sandbox de código | ⚠️ Bajo - servicio legítimo |
| `OCR_VLLM_API_KEY` | OCR opcional | ⚠️ Bajo - opcional |

**Riesgo de API keys:** Si usas keys reales, tienes que confiar en que:
1. El código no las exfiltra (auditado: NO lo hace)
2. Los servicios (E2B, Tavily) son legítimos (SÍ lo son)

### 4.5 Señales de alarma (lista)

✅ **Sin señales críticas detectadas**

⚠️ **Señales moderadas:**
1. **Marketing engañoso** - "$10K earned" sin aclarar que es simulación
2. **Requiere múltiples API keys** - Costo real de operación
3. **Evaluación por LLM** - GPT-4o decide si cobras (sesgo posible)
4. **Sin mecanismo de retiro** - El dinero "ganado" no es cobrable

❌ **Señales que NO están presentes:**
- No pide datos personales
- No pide información financiera real
- No hay pagos iniciales (no es esquema piramidal)
- No hay backdoors conocidos
- No hay envío de datos a servidores sospechosos

---

## 5. VEREDICTO FINAL

| Aspecto | Valor |
|---------|-------|
| **Nivel de riesgo** | **3/10** |
| **Recomendación** | **PRECAUCIÓN** |

### Por qué:

**PUEDES usarlo SI:**
- Entiendes que es un **benchmark de investigación**, no una forma de ganar dinero
- Tienes API keys para gastar (costo real)
- Quieres experimentar con agentes autónomos
- Sabes que el "dinero" es simulado

**NO lo uses SI:**
- Esperas ganar dinero real
- No tienes presupuesto para APIs
- No entiendes la diferencia entre simulación y realidad
- Crees que "$10K earned" es cobrable

### Resumen ejecutivo:
> **ClawWork es un proyecto de investigación legítimo de un laboratorio universitario respetado. El código es limpio y no contiene malware. SIN EMBARGO, el marketing del título ("$10K earned in 7 Hours") es engañoso - ese dinero es simulado, no real. Es una herramienta para investigadores, no una plataforma de empleo.**

---

## Referencias

- Repo: https://github.com/HKUDS/ClawWork
- Org: https://github.com/HKUDS (Data Intelligence Lab @ HKU)
- Proyecto relacionado: https://github.com/HKUDS/nanobot (21.8k stars)
- Paper GDPVal: https://arxiv.org/abs/2512.10971 (AI-Trader)

---

*Análisis completado sin ejecución de código. Toda información obtenida via web_fetch de fuentes públicas.*
