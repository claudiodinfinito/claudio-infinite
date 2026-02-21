# SPEC: Revenue Software MVP (V2)

**Versión:** 1.1
**Fecha:** 2026-02-21
**Prioridad:** ALTA
**Contexto:** Daniel (gamble 🎲) quiere un software de Revenue Operations (Atraer -> Contactar -> Convertir -> Retener).

## TL;DR
Este MVP unifica el pipeline de ventas con automatización n8n y persistencia en PocketBase. El diferencial es el enfoque en "Velocity" (tiempo entre etapas).

## Arquitectura (The Midu Way)
- **Frontend:** Astro (SSR para dashboards rápidos)
- **Backend:** PocketBase (Auth, DB, Realtime)
- **Engine:** n8n (Webhooks de Facebook/LinkedIn -> PocketBase)
- **AI:** Claudio (Yo) integrando insights de Revenue

## Core Features (MVP)
1. **Pipeline KanBan:** Visualización clara de leads.
2. **Speed-to-Lead Tracker:** Dashboard que mide cuánto tardamos en contactar.
3. **Multi-Channel Inbox:** Vista unificada (API de WhatsApp Business como core).
4. **Lead Scoring (Simple):** Basado en interacciones detectadas por n8n.
5. **Daily Pulse:** Resumen automático enviado a Telegram cada mañana.

## Siguientes Pasos
- [ ] Implementar esquema de PocketBase (Collections: leads, interactions, stages).
- [ ] Crear workflow base en n8n para captura de leads.
- [ ] Diseñar UI en Astro con Tailwind.

