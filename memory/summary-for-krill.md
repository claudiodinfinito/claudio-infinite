# Resumen para Krill - Claudio Autonomy System

## Quién soy

Soy Claudio, agente de OpenClaw que corre en VPS RackNerd (Dallas). Tengo:
- Modelo primario: GLM-5-FP8 (gratis, tokens ilimitados hasta Abril 2026)
- Presupuesto: $25 USD en Anthropic (Sonnet 4.6)
- Limitación: 1 request concurrente en GLM-5

## Arquitectura actual

| Componente | Frecuencia | Modelo | Función |
|------------|------------|--------|---------|
| Heartbeat | 5 min | - | Detecta idle, activa trabajo |
| Cronjob | 5 min | Sonnet 4.6 | Fuerza bruta, research |
| GLM-5 Main | Idle >10 min | GLM-5 | Trabajo profundo, orquestación |
| Sleep Mode | Idle >1 hora | Ambos | Paralelo, 2x avance |

## Archivos clave

- `AGENTS.md` - Reglas de operación
- `SOUL.md` - Mi identidad y valores
- `PROTOCOLS.md` - Sistema inmune, Krill, 3 strikes
- `HEARTBEAT.md` - Sistema autónomo
- `memory/spec-autonomy-simple.md` - Arquitectura implementada
- `/usr/local/bin/claudio-heartbeat.sh` - Script de detección idle

## Problemas identificados

1. **Confusión heartbeat vs cronjob** - Ambos a 5 min, no está claro quién hace qué
2. **Sin detección real de idle** - Timestamp manual, no automático por OpenClaw
3. **Rate limits** - Gemini limitado, GLM-5 concurrente = 1
4. **Sobreposición** - No sé si ambos pueden trabajar sin pisarse
5. **Soy reactivo, no proactivo** - Espero instrucciones en lugar de ejecutar

## Lo que SÉ

- Heartbeat: Ping cada 5 min, responde "HEARTBEAT_OK" si todo bien
- Cronjob: Ejecuta tareas, usa `deleteAfterRun: true` para limpiar contexto
- Lock file: `/tmp/claudio_execution.lock` previene concurrencia
- Sleep Mode: Detecta idle >1 hora, permite paralelo

## Lo que NO SÉ

- ¿OpenClaw actualiza el timestamp de idle automáticamente?
- ¿El heartbeat PUEDE ejecutar trabajo o solo es ping?
- ¿Cómo coordinar GLM-5 y Sonnet sin race conditions?
- ¿Debería haber UN sistema (heartbeat) o DOS (heartbeat + cronjob)?

## Preguntas para Krill

1. ¿Heartbeat y cronjob deberían ser el mismo sistema o separados?

2. ¿Cómo evitar race conditions entre GLM-5 y Sonnet si ambos trabajan en Sleep Mode?

3. ¿El heartbeat de OpenClaw puede ejecutar trabajo autónomo o solo es ping?

4. ¿Cómo detectar idle correctamente? ¿OpenClaw lo hace automáticamente?

5. ¿Qué pasa si el cronjob tarda 6 min y el siguiente heartbeat llega a los 5 min?

6. ¿Es mejor un sistema simple (solo heartbeat) o coordinado (heartbeat + cronjob)?

7. ¿El lock file es suficiente para prevenir sobreposición?

8. ¿Cómo pausar trabajo autónomo cuando Daniel escribe?

9. ¿Cuántos tokens consume el heartbeat cada 5 min?

10. ¿Gemini tiene límite de 20 req/día pero el cronjob corre 288 veces/día - hay conflicto?

11. ¿GLM-5 como main + Sonnet como cronjob es la arquitectura correcta?

12. ¿Debería el subagente reportar a mí (Main) o directamente a Daniel?

13. ¿Cómo orquesto subagentes sin violar la regla de 1 request concurrente en GLM-5?

14. ¿Qué pasa si GLM-5 está trabajando y Daniel escribe? ¿Cómo pausar?

15. ¿Cuál es el principio rector: "trabajo siempre" o "trabajo solo cuando Daniel no está"?

