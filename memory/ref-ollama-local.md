# Ollama Local Reference

**Propósito:** Ollama como alternativa local (sin API costs).
**Contexto:** Evaluar si el VPS tiene recursos para correr modelos locales.

---

## ¿Qué es Ollama?

Runtime para correr LLMs localmente sin depender de APIs externas.

| Característica | Valor |
|----------------|-------|
| **Costo** | Gratis (solo recursos) |
| **Privacidad** | 100% local |
| **Latencia** | Depende de hardware |
| **Modelos** | Llama, Mistral, DeepSeek, etc. |

---

## Requisitos de Hardware

| Modelo | RAM Mínima | RAM Recomendada | VRAM |
|--------|------------|-----------------|------|
| Llama 3.2 1B | 2 GB | 4 GB | Opcional |
| Llama 3.2 3B | 4 GB | 8 GB | Opcional |
| Llama 3.1 8B | 8 GB | 16 GB | 6 GB+ |
| Mistral 7B | 8 GB | 16 GB | 6 GB+ |
| DeepSeek R1 7B | 8 GB | 16 GB | 6 GB+ |
| Llama 3.1 70B | 40 GB | 80 GB | 48 GB+ |

---

## Estado del VPS Actual

| Métrica | Valor | ¿Suficiente? |
|---------|-------|--------------|
| **RAM Total** | 7.8 GB | ✅ Para modelos pequeños |
| **RAM Disponible** | ~5.5 GB | ✅ Para 3B-7B quantized |
| **GPU** | No detectada | ❌ Sin aceleración |
| **CPU** | 4 cores | ✅ Suficiente |
| **Disco** | 93 GB libres | ✅ Suficiente |

**Conclusión:** Puedo correr modelos 3B-7B con cuantización (Q4_Q8).

---

## Modelos Recomendados para este VPS

| Modelo | Tamaño | Calidad | Recomendación |
|--------|--------|---------|---------------|
| **Llama 3.2 3B** | ~2 GB | Buena | ✅ Óptimo |
| **Mistral 7B Q4** | ~4 GB | Muy buena | ✅ Funcionará |
| **DeepSeek R1 7B Q4** | ~4 GB | Excelente | ✅ Funcionará |
| **Llama 3.1 8B Q4** | ~5 GB | Muy buena | ⚠️ Ajustado |

---

## Instalación

```bash
# Instalar Ollama
curl -fsSL https://ollama.com/install.sh | sh

# Descargar modelo
ollama pull llama3.2:3b

# Correr
ollama run llama3.2:3b

# API mode (puerto 11434)
ollama serve
```

---

## Uso via API

```python
import requests

response = requests.post(
    "http://localhost:11434/api/generate",
    json={
        "model": "llama3.2:3b",
        "prompt": "Hola, ¿cómo estás?",
        "stream": False
    }
)
print(response.json()["response"])
```

---

## Ventajas

| Ventaja | Descripción |
|---------|-------------|
| **Costo cero** | Sin API costs |
| **Privacidad** | Datos nunca salen del VPS |
| **Sin rate limits** | Uso ilimitado |
| **Sin expiración** | Modelo tuyo para siempre |

---

## Desventajas

| Desventaja | Descripción |
|------------|-------------|
| **Calidad inferior** | vs Claude/GPT-4 |
| **Sin GPU** | Inference lento (2-10 tokens/s) |
| **RAM limitada** | Solo modelos pequeños |
| **Sin features avanzadas** | No extended thinking, tools limitadas |

---

## Benchmark de Velocidad Esperado

| Configuración | Tokens/segundo |
|---------------|----------------|
| CPU only, 7B Q4 | 2-5 t/s |
| CPU only, 3B | 5-10 t/s |
| GPU RTX 3060, 7B | 30-50 t/s |

**Este VPS:** ~3-5 t/s con modelo 7B Q4 (CPU only).

---

## Integración con OpenClaw

**Config hipotética:**
```json
{
  "models": {
    "providers": {
      "ollama": {
        "type": "ollama",
        "baseUrl": "http://localhost:11434"
      }
    },
    "defaults": {
      "local": "ollama/llama3.2:3b"
    }
  }
}
```

---

## Cuándo Usar

| ✅ Usar Ollama | ❌ Mejor API |
|-----------------|--------------|
| Tareas no urgentes | Respuesta rápida |
| Privacidad crítica | Calidad máxima |
| Batch processing | Conversación fluida |
| Sin presupuesto | Feature-rich |

---

## Estado Actual en VPS

```bash
# Verificar si Ollama está instalado
which ollama || echo "No instalado"

# Verificar contenedor
docker ps | grep ollama
```

**Container activo:** `ollama` (7 días uptime) + `open-webui`

---

## Plan de Acción

1. **Verificar Ollama existente** en Docker
2. **Testear modelo pequeño** (Llama 3.2 3B)
3. **Medir velocidad** real en este VPS
4. **Decidir:** ¿Vale la pena vs DeepSeek API?

---

## Referencias

- [Ollama Official](https://ollama.com/)
- [Ollama Models Library](https://ollama.com/library)
- TODO.md items #29, #71

---

_Creado: 2026-02-20 04:47 UTC - Micro-tarea autónoma_
