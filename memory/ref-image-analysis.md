# Image Analysis Reference

**Propósito:** Capacidades de análisis de imágenes con OpenClaw.
**Fuente:** Item #96 de ref-interests-real-100.md

---

## Tool Disponible

```javascript
image({
  prompt: "Describe esta imagen",
  image: "/path/to/image.png"
})
```

---

## Capacidades

| Capacidad | Uso |
|-----------|-----|
| **OCR** | Extraer texto de imágenes |
| **Descripción** | Describir contenido visual |
| **Análisis técnico** | Diagramas, código en screenshots |
| **Comparación** | Múltiples imágenes |
| **Clasificación** | Categorizar contenido |

---

## Casos de Uso

### 1. Screenshots de código

```javascript
image({
  prompt: "Extrae el código de esta screenshot y formatealo",
  image: "/path/to/screenshot.png"
})
```

### 2. Diagramas técnicos

```javascript
image({
  prompt: "Explica este diagrama de arquitectura",
  image: "/path/to/diagram.png"
})
```

### 3. Google Leak screenshots

```javascript
image({
  prompt: "Analiza este screenshot del Google Leak. Identifica: campos, estructuras, relaciones.",
  image: "/path/to/google-leak-screenshot.png"
})
```

### 4. Múltiples imágenes

```javascript
image({
  prompt: "Compara estas dos interfaces. ¿Qué diferencias hay?",
  images: ["/path/to/before.png", "/path/to/after.png"]
})
```

---

## Modelos Soportados

OpenClaw usa el modelo configurado en `agents.defaults.imageModel`.

| Modelo | Mejor para |
|--------|------------|
| Claude 3.5 Sonnet | OCR, análisis complejo |
| GPT-4 Vision | Descripción general |
| Gemini Pro Vision | Análisis técnico |

---

## Límites

| Parámetro | Valor |
|-----------|-------|
| **maxImages** | 20 por request |
| **maxBytesMb** | Configurable |
| **Formatos** | jpg, png, gif, webp |

---

## Ejemplo Real

### Input: Screenshot de error

```javascript
image({
  prompt: "¿Qué error muestra esta screenshot? ¿Cómo lo soluciono?",
  image: "/tmp/error-screenshot.png"
})
```

### Output esperado:

```
Error: ENOENT: no such file or directory, open '/config/app.json'

Solución:
1. Crear directorio: mkdir -p /config
2. Crear archivo: touch /config/app.json
3. Añadir configuración necesaria
```

---

## Aplicaciones para Daniel

| Uso | Beneficio |
|-----|-----------|
| **Debug visual** | Screenshots de errores |
| **Análisis UI** | Comparar diseños |
| **OCR docs** | Digitalizar documentos |
| **Google Leak** | Analizar screenshots del código |

---

## Workflow Sugerido

```
Daniel envía imagen
    ↓
Guardar en /tmp/
    ↓
Analizar con image()
    ↓
Responder con análisis
    ↓
Eliminar imagen temporal
```

---

## Estado Actual

- **Tool:** ✅ Disponible
- **Uso:** No utilizado aún
- **Configuración:** Usar modelo default

---

_Creado: 2026-02-20 20:06 UTC - Micro-tarea autónoma_
