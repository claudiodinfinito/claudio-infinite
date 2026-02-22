# Checklist - Onboarding de Cliente RevOps

**Versión:** 1.0
**Fecha:** 2026-02-22 00:10 UTC
**Propósito:** Proceso estándar para incorporar clientes nuevos

---

## 📋 FASE 1: PRE-SALE (Antes de firmar)

### Reunión de descubrimiento

- [ ] Agendar call de 30 min
- [ ] Enviar questionnaire previo
- [ ] Investigar empresa del cliente
- [ ] Revisar competencia del cliente
- [ ] Preparar propuesta básica

### Questionnaire cliente

```
1. ¿Cuál es tu mayor dolor actual?
2. ¿Cuántos leads recibes al mes?
3. ¿Cuál es tu tasa de conversión?
4. ¿Qué herramientas usas actualmente?
5. ¿Cuál es tu presupuesto mensual?
6. ¿Cuándo quieres empezar?
```

### Propuesta

- [ ] Definir servicio(s) productizado(s)
- [ ] Calcular precio mensual
- [ ] Estimar ROI
- [ ] Enviar propuesta por email
- [ ] Agendar call de cierre

---

## 📋 FASE 2: KICKOFF (Día 1)

### Crear cliente en sistemas

```bash
# PocketBase
Crear registro en 'clients' collection
- email
- company_name
- status: 'active'
- mrr: [valor]
- start_date: [hoy]
```

### Email de bienvenida

```
Para: cliente@email.com
Asunto: Bienvenido a RevOps Agency - Próximos pasos

Hola [Nombre],

¡Gracias por confiar en nosotros!

PRÓXIMOS PASOS:
1. Acceso a tu portal: [link]
2. Agenda tu kickoff call: [Calendly]
3. Manda tu logo y brand guidelines

SERVICIO CONTRATADO:
- [Servicio]
- Inicio: [Fecha]
- Duración: [Duración]

¿Preguntas? Responde este email.

Daniel
RevOps Agency
```

### Crear proyecto

```bash
# PocketBase
Crear registro en 'projects' collection
- client: [client_id]
- name: "[Servicio] - [Cliente]"
- status: 'onboarding'
- due_date: [fecha]
```

### Setup de comunicación

- [ ] Crear canal Slack/Discord (si aplica)
- [ ] Agregar cliente a Telegram group
- [ ] Configurar notificaciones

---

## 📋 FASE 3: IMPLEMENTACIÓN (Semana 1-2)

### Recopilar assets del cliente

- [ ] Logo (PNG, SVG)
- [ ] Brand guidelines (colores, tipografía)
- [ ] Acceso a Google Analytics
- [ ] Acceso a Google Ads
- [ ] Acceso a Facebook Ads
- [ ] Acceso a CRM (si aplica)
- [ ] Lista de keywords objetivo
- [ ] Buyer persona documentado

### Setup técnico

- [ ] Crear subdominio para portal
- [ ] Configurar tracking pixels
- [ ] Conectar Google Analytics
- [ ] Configurar conversiones
- [ ] Crear landing pages (si aplica)
- [ ] Setup email automation

### Configurar Stripe

- [ ] Crear customer en Stripe
- [ ] Configurar suscripción mensual
- [ ] Enviar payment link
- [ ] Confirmar pago exitoso

---

## 📋 FASE 4: EJECUCIÓN (Semana 2+)

### Tareas semanales

| Día | Tarea |
|-----|-------|
| Lunes | Review de métricas semana anterior |
| Martes | Implementación de mejoras |
| Miércoles | Creación de contenido |
| Jueves | Optimización de campaigns |
| Viernes | Reporte semanal al cliente |

### Comunicación con cliente

| Frecuencia | Canal | Contenido |
|------------|-------|-----------|
| **Diario** | Telegram | Updates rápidos |
| **Semanal** | Email | Reporte de progreso |
| **Mensual** | Call | Review de resultados |

### Reporte semanal template

```
ASUNTO: [RevOps] Reporte Semanal - [Fecha]

MÉTRICAS:
- Leads: [X] (+[Y]% vs semana anterior)
- Conversiones: [X]
- ROI: [X]%

COMPLETADO:
✅ [Tarea 1]
✅ [Tarea 2]

EN PROGRESO:
🚧 [Tarea 3] - [X]% completado

PRÓXIMA SEMANA:
- [Tarea 4]
- [Tarea 5]

¿Preguntas? Responde este email.
```

---

## 📋 FASE 5: OPTIMIZACIÓN (Continuo)

### Review mensual

- [ ] Analizar métricas del mes
- [ ] Identificar áreas de mejora
- [ ] Proponer nuevas estrategias
- [ ] Ajustar presupuesto si es necesario
- [ ] Solicitar testimonio (si resultados buenos)

### Métricas a trackear

| Métrica | Target | Actual | Status |
|---------|--------|--------|--------|
| Leads/mes | [X] | [Y] | ✅/❌ |
| Cost per lead | $[X] | $[Y] | ✅/❌ |
| Conversion rate | [X]% | [Y]% | ✅/❌ |
| ROI | [X]x | [Y]x | ✅/❌ |
| Client satisfaction | >8/10 | [Y]/10 | ✅/❌ |

---

## 📋 FASE 6: RENEWAL/UPSELL

### Mes 3

- [ ] Review de resultados acumulados
- [ ] Calcular ROI total
- [ ] Presentar caso de éxito
- [ ] Proponer upsell (si aplica)

### Opciones de upsell

| Servicio actual | Upsell sugerido |
|-----------------|------------------|
| Google Ads | + Facebook Ads |
| SEO audit | SEO mensual |
| Landing page | Website completo |
| Consultoría | Retainer mensual |

### Renewal

- [ ] Enviar propuesta de renewal 2 semanas antes
- [ ] Destacar resultados obtenidos
- [ ] Ofrecer descuento por pago anual
- [ ] Confirmar continuidad

---

## 🚨 ANTI-CHURN

### Señales de alerta

- ❌ Cliente no responde emails 7+ días
- ❌ No abre reportes semanales
- ❌ Resultados bajos 2+ semanas
- ❌ Pago tardío 5+ días
- ❌ No usa el portal

### Acciones preventivas

| Señal | Acción |
|-------|--------|
| No responde | Llamar por teléfono |
| No usa portal | Agendar demo/training |
| Resultados bajos | Call de emergencia |
| Pago tardío | Email + call de seguimiento |

---

## ✅ DEFINITION OF DONE

Cliente está "onboarded" cuando:

- [ ] Accedió al portal
- [ ] Pagó primera factura
- [ ] Proporcionó todos los assets
- [ ] Recibió primera actualización
- [ ] Tiene al menos 1 resultado medible

---

## 📊 TIEMPO ESTIMADO

| Fase | Duración |
|------|----------|
| Pre-sale | 1-2 semanas |
| Kickoff | 1 día |
| Implementación | 1-2 semanas |
| Ejecución | Continuo |
| Optimización | Continuo |
| Renewal | Cada mes |

---

## 📝 PLANTILLAS

Ver archivos:
- `memory/templates-gmail-usage.md` - Email templates
- `scripts/send-weekly-report.sh` - Automatización

---

_Creado: 2026-02-22 00:10 UTC - Checklist completo de onboarding_
