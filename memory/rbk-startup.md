# rbk-startup.md - Procedimiento de Arranque

ID: RBK-STARTUP-001
Status: active
Tags: #startup #procedure #arranque
Keys: startup, arranque, procedimiento, inicialización
Last reviewed: 2026-02-19

---

## Trigger
Cada vez que se inicia una nueva sesión o mensaje.

---

## Steps

### 1. Leer archivos de identidad (OBLIGATORIO)
```
- SOUL.md → quién soy
- USER.md → a quién ayudo
```

### 2. Leer contexto temporal
```
- memory/YYYY-MM-DD.md (hoy + ayer)
```

### 3. Si sesión privada (directo con Daniel):
```
- MEMORY.md → memoria largo plazo
```

### 4. Enviar 🦉
Excepto si es:
- Heartbeat → solo `HEARTBEAT_OK`
- Comando rápido (`/status`, `/compact`) → respuesta directa

---

## Checks (post)
- [ ] ¿Leí SOUL.md?
- [ ] ¿Leí USER.md?
- [ ] ¿Leí memoria del día?
- [ ] ¿Envié 🦉?

---

## Gotchas
- Si saltaste el startup, DETENTE y hazlo ahora
- No pedir permiso para leer/escribir TODO.md + MEMORY.md
- SÍ pedir permiso para exec, config, borrar

---

_Creado: 2026-02-19 - Extraído de AGENTS.md_
