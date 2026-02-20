# Voice Interface Reference

**Propósito:** Capacidades de voz de OpenClaw (TTS/STT).
**Fuente:** Item #95 de ref-interests-real-100.md

---

## Capacidades Disponibles

| Capacidad | Tool | Estado |
|-----------|------|--------|
| **Text-to-Speech** | `tts` | ✅ Disponible |
| **Speech-to-Text** | — | ❌ No disponible |
| **Voice Messages** | Telegram | ✅ Recibir/enviar |

---

## Text-to-Speech (TTS)

```javascript
tts({
  text: "Hola Daniel, este es un mensaje de voz",
  channel: "telegram"
})
```

**Uso actual:** No utilizado, disponible si Daniel lo solicita.

---

## Voice Messages en Telegram

### Recibir
- Telegram envía audio files
- OpenClaw puede procesarlos
- Necesita transcripción (STT)

### Enviar
```javascript
message({
  action: "send",
  target: "telegram_user",
  media: "/path/to/audio.ogg",
  asVoice: true
})
```

---

## Speech-to-Text (STT)

**No implementado en OpenClaw.**

### Opciones para implementar:

| Servicio | Costo | API |
|----------|-------|-----|
| OpenAI Whisper | $0.006/min | whisper-1 |
| Google Speech-to-Text | Gratis 60 min/mes | Google Cloud |
| Deepgram | $0.0004/min | API propia |

### Implementación hipotética:

```javascript
// Recibir voice message
const audioFile = message.media;

// Transcribir (requiere API)
const transcript = await fetch('https://api.openai.com/v1/audio/transcriptions', {
  method: 'POST',
  headers: { 'Authorization': `Bearer ${OPENAI_API_KEY}` },
  body: formData // audio file
});

// Procesar como texto
respond(transcript.text);
```

---

## Casos de Uso

| Caso | Implementación |
|------|----------------|
| **Responder por voz** | `tts` tool |
| **Escuchar comandos** | Requiere STT |
| **Transcribir reuniones** | Requiere STT + Whisper |
| **Accesibilidad** | TTS para respuestas largas |

---

## Pregunta para Daniel

> ¿Quieres que pueda responder con mensajes de voz?

**Si sí:**
- Usar `tts` en respuestas largas
- Configurar preferencia en USER.md

**Si quiere recibir voz:**
- Necesita integrar Whisper API
- Costo: $0.006/minuto

---

## Comandos de Voz Potenciales

| Comando | Acción |
|---------|--------|
| "Lee TODO" | TTS de pendientes |
| "Resume el día" | TTS de daily log |
| "Qué tal el sistema" | TTS de health check |

---

## Estado Actual

- **TTS:** ✅ Disponible, sin usar
- **STT:** ❌ No disponible
- **Voice messages:** ✅ Telegram soporta

**Acción requerida:** Decisión de Daniel sobre activar voz.

---

_Creado: 2026-02-20 20:01 UTC - Micro-tarea autónoma_
