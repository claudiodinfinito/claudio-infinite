# Comandos de Control Manual

## ACTIVAR MODO AUTÓNOMO (30 min)

Cuando Daniel diga: "activa modo autónomo por 30 minutos"

**Acción:**
1. Crear flag: `touch /tmp/claudio_manual_autonomy`
2. Eliminar timestamp idle: `rm -f /tmp/claudio_last_message`
3. Responder: "🦉 Modo autónomo ACTIVO por 30 min. Trabajaré sin detectar idle."

**Qué pasa:**
- GLM-5 Main: Trabaja inmediatamente (sin esperar idle)
- Gemini cronjob: Sigue cada 5 min
- Ambos reportan a mí (no a Daniel)
- Después de 30 min: Eliminar flag, volver a detección normal

## DESACTIVAR MODO AUTÓNOMO

Cuando Daniel diga: "detén modo autónomo"

**Acción:**
1. Eliminar flag: `rm -f /tmp/claudio_manual_autonomy`
2. Actualizar timestamp: `date +%s > /tmp/claudio_last_message`
3. Responder: "🦉 Modo autónomo DETENIDO. Vuelvo a detección de idle."

## ESTADO ACTUAL

Comando: "estado autonomía"

**Respuesta:**
- ¿Modo manual activo? (flag existe)
- ¿Idle actual? (minutos sin interacción)
- ¿Lock file activo? (trabajando ahora)
- Última tarea ejecutada
- Próxima ejecución cronjob

---

_Añadir a PROTOCOLS.md como comando directo_
