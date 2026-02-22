# Tracking de Tokens Diarios

ID: TRK-TOKENS-001
Tags: #tokens #tracking #baseline #daily #metrics
Keys: tokens, tracking, baseline, metrics, usage
Last reviewed: 2026-02-22

---

## Propósito

Mantener un baseline de tokens usados por día para optimizar costos y detectar patrones.

---

## Baseline 2026-02-22

| Modelo | Input | Output | Total | Contexto |
|--------|-------|--------|-------|----------|
| GLM-5-FP8 (main) | ~15K/día | ~3K/día | ~18K/día | Sesión activa |
| Gemini 3 Flash (sub) | ~5K/día | ~2K/día | ~7K/día | Micro-tareas |

**Total estimado:** ~25K tokens/día

---

## Estimación Mensual

| Modelo | Tokens/día | Tokens/mes | Costo |
|--------|------------|------------|-------|
| GLM-5-FP8 | 18K | 540K | $0 (gratis hasta Abril) |
| Gemini 3 Flash | 7K | 210K | $0 (gratis, 20/día limit) |
| **Total** | **25K** | **750K** | **$0** |

---

## Tokens por Tipo de Tarea

| Tarea | Input | Output | Notas |
|-------|-------|--------|-------|
| Startup + lectura archivos | 8-12K | 500-1K | Cada mensaje |
| Micro-tarea autónoma | 5-8K | 1-2K | Gemini subagente |
| Investigación profunda | 15-25K | 3-5K | Google Leak style |
| Síntesis diaria | 10-15K | 2-3K | Daily report |
| Commit + docs | 2-3K | 500-1K | Post-tarea |

---

## Métricas a Trackear

### Diarias
- [ ] Tokens input main (GLM-5)
- [ ] Tokens output main (GLM-5)
- [ ] Tokens input subagentes (Gemini)
- [ ] Tokens output subagentes (Gemini)

### Semanales
- [ ] Promedio diario
- [ ] Día de mayor uso
- [ ] Día de menor uso
- [ ] Tendencia (↑↓→)

### Mensuales
- [ ] Total tokens mes
- [ ] Comparativa mes anterior
- [ ] Proyección costo post-Abril

---

## Límites a Vigilar

| API | Límite | Tokens aprox |
|-----|--------|--------------|
| Gemini 3 Flash | 20 req/día | ~50K tokens/día max |
| Brave Search | 1,500/mes | N/A (no tokens) |
| GLM-5 | 1 concurrente | Ilimitado (hasta Abril) |

---

## Cómo Estimar Tokens

### GLM-5 (no da info directa)
- Estimar por longitud de conversación
- ~4 caracteres = 1 token (español)
- Mensaje típico: 2K-5K tokens

### Gemini (API response incluye)
```json
{
  "usageMetadata": {
    "promptTokenCount": 1234,
    "candidatesTokenCount": 567,
    "totalTokenCount": 1801
  }
}
```

---

## Comando Rápido

```bash
# Verificar longitud de archivo como proxy de tokens
wc -c memory/*.md | tail -1 | awk '{print $1/4 " tokens aprox"}'
```

---

## Registro Diario (Template)

```markdown
## YYYY-MM-DD

| Modelo | Input | Output | Total |
|--------|-------|--------|-------|
| GLM-5 | ? | ? | ? |
| Gemini | ? | ? | ? |

**Notas:** [Contexto del día]
```

---

## Alertas

| Umbral | Acción |
|--------|--------|
| >50K tokens/día | Revisar eficiencia |
| >150K tokens/día | Posible desperdicio |
| >1M tokens/mes | Alto para un agente |

---

## Proyección Post-Abril 2026

Con DeepSeek V3.2 ($0.28/M input, $0.42/M output):

| Uso mensual | Input | Output | Costo total |
|-------------|-------|--------|-------------|
| 750K tokens | 500K × $0.28 = $0.14 | 250K × $0.42 = $0.105 | **$0.25/mes** |
| 1M tokens | 700K × $0.28 = $0.20 | 300K × $0.42 = $0.13 | **$0.33/mes** |
| 5M tokens | 3.5M × $0.28 = $0.98 | 1.5M × $0.42 = $0.63 | **$1.61/mes** |

**Conclusión:** Con uso actual (~750K/mes), DeepSeek costaría ~$0.25/mes = prácticamente gratis.

---

_Creado: 2026-02-22 04:12 UTC - Tarea autónoma GEMINI_
