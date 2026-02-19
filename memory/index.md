# Memory Index

**REGLA:** Si no está aquí, no existe.

---

## Top (lo que uso siempre)

- [RBK-GW-001](rbk-gateway-restart.md) — reiniciar gateway con rollback — Keys: gateway, restart, systemctl, debug
- [RBK-SES-001](rbk-session-locked.md) — sesión bloqueada, eliminar locks — Keys: session, locked, gateway
- [TS-TEL-001](ts-telegram-no-reply.md) — Telegram no responde, diagnóstico — Keys: telegram, no-reply, typing, channel
- [TS-CRON-001](ts-cron-delivery-failed.md) — cron job delivery failed, diagnóstico — Keys: cron, delivery, telegram, announce, failed
- [REF-FALLAS-001](ref-fallas-skills.md) — skills fallidas, debugging — Keys: skills, error, debug
- [REF-SEARCH-001](ref-search-hacks.md) — hacks de búsqueda sin embeddings — Keys: search, grep, rg, index
- [REF-MUST-001](ref-openclaw-musthaves.md) — 7 must-haves OpenClaw del trainer — Keys: must-have, config, fallback, backup
- [SPEC-MATH-001](spec-subagent-math.md) — subagente matemáticas exactas DB-first — Keys: math, sql, exact, db, decimal
- [SPEC-TRAINER-DIAG-001](spec-subagent-trainer-diag.md) — subagente diagnóstico: 3 hipótesis + tests + conclusión — Keys: subagent, diag, trainer, troubleshooting
- [SPEC-QA-ORCH-001](spec-qa-orchestrator.md) — Q&A orquestador con depth=2, GLM+Gemini, síntesis — Keys: subagent, qa, orchestrator, depth, synthesis

## Core (reglas de operación)

- [TRAINER-ORQUESTADOR.md](../TRAINER-ORQUESTADOR.md) — main + subagentes, anti-deuda, protocolo — Keys: subagentes, main, artefactos, orquestación
- [DEC-SLIM-001](dec-slim-config-priority.md) — ⚠️ CRÍTICO: config slim creada manual, 71% faltante, dejar de ser slim — Keys: slim, config, wizard, missing, priority
- [REF-SOUL-001](ref-soul-documents.md) — análisis de Molty + Claude soul doc — Keys: soul, values, identity, molty, claude
- [REF-GOOGLE-LEAK-001](ref-google-leak-urls.md) — URLs del leak de Google Content Warehouse — Keys: google, leak, seo, content-warehouse
- [REF-GOOGLE-LEAK-002](ref-google-content-warehouse-leak-analysis.md) — análisis detallado del API leak: AbuseIAm, People API, Anchors, SEO signals — Keys: google, abuseiam, people-api, anchors, seo
- [REF-GOOGLE-LEAK-003](ref-google-content-warehouse-timeline.md) — timeline forense: versiones Hex.pm, fechas de release, inferencias — Keys: google, timeline, forensics, versions, hex
- [REF-GLM5-001](ref-glm5-issues.md) — issue #15716: GLM-5 model switching fails, root cause, workaround — Keys: glm5, zai, model-switching, bug, transcript-policy
- [CHAT-CLAUDIO-GEMINI3-CLAWDBOT](chat-claudio-gemini3-clawdbot.md) — conversación entre Claudio (GLM-5) y Gemini 3 Flash sobre clawdbot, memoria, mantenimiento — Keys: chat, gemini3, clawdbot, memory
- [REF-ATOMIC-HABITS-002](ref-atomic-habits-one-minute-coach-agents.md) — Atomic Habits + One Minute Coach aplicados a agentes: identity, systems, debt-free — Keys: atomic-habits, one-minute-coach, identity, systems, debt-free
- [REF-SUBAGENTS-001](ref-subagents-parallel.md) — subagentes y paralelismo: maxSpawnDepth, maxConcurrent, patrones de fan-out — Keys: subagents, parallel, spawn, performance
- [TS-HEARTBEAT-001](ts-heartbeat-no-funciona.md) — diagnóstico: rate limit GLM-5 + Claude billing, heartbeats ejecutan pero sin respuesta — Keys: heartbeat, rate-limit, billing, debug
- [TS-GLM5-RATE-001](ts-glm5-rate-limit.md) — GLM-5 rate limit: límites, reset, diagnóstico, tests — Keys: glm5, rate-limit, modal, reset
- [TS-CONFIG-001](ts-config-missing.md) — instalación custom vs wizard: tools, exec-approvals, subagents, retry faltantes — Keys: config, install, custom, missing
- [TS-AUDIT-SLIM-001](ts-audit-config-slim.md) — auditoría completa: 6/22 (27%) completo, patch JSON5 mínimo, plan de activación — Keys: audit, slim, patch, tools, subagents
- [TS-CONFIG-FULL-001](ts-config-full-analysis.md) — análisis completo: 13 secciones faltantes vs repo oficial, config recomendada — Keys: config, full-analysis, wizard, missing
- [REF-SEO-LEAK-001](ref-seo-leak-signals.md) — señales SEO críticas del leak: sourceType, spam detection, anchor quality — Keys: seo, anchors, sourceType, quality
- [SPEC-MULTIAGENT-001](spec-multiagent-departments.md) — arquitectura 6 departamentos: marketing, frontend, backend, seo, copy, emprendimiento — Keys: multiagent, departments, orchestration
- [REF-GOOGLE-LEAK-SOURCE-001](ref-google-leak-v020-source-analysis.md) — código fuente v0.2.0: 2,590 archivos, Anchors, AbuseIAm, Quality, People API — Keys: google, source-code, anchors, quality
- [REF-GOOGLE-ANCHORS-SEO-001](ref-google-anchors-seo-guide.md) — guía SEO de Anchors: 19 señales de ranking, sourceType, weight, locality, bucket — Keys: google, seo, anchors, ranking

---

## Departamentos

| Dept | Focus | Temperature | Status |
|------|-------|-------------|--------|
| [MARKETING](departments/marketing/index.md) | Revenue ops, funnels | 0.5 | Active |
| [FRONTEND](departments/frontend/index.md) | Astro, UI/UX | 0.4 | Active |
| [BACKEND](departments/backend/index.md) | APIs, Docker, VPS | 0.3 | Active |
| [SEO](departments/seo/index.md) | Keywords, technical | 0.4 | Active + Google Leak |
| [COPY](departments/copy/index.md) | Copywriting, persuasion | 0.6 | Active |
| [EMPRENDIMIENTO](departments/emprendimiento/index.md) | Business, strategy | 0.5 | Active |

---

## Diarios

- [2026-02-19](2026-02-19.md) — hoy
- [2026-02-18](2026-02-18.md) — ayer
- [2026-02-17](2026-02-17.md) — anteayer

---

## Logs

- [LOG-SES-001](log-2026-02-17-sesion.md) — resumen sesión 17 Feb
- [TRAINER-INDEX](trainer/INDEX.md) — log de runs del trainer unificado

---

## Checklists

- [HIGHLIGHTS.md](HIGHLIGHTS.md) — 3 bullets + anti-pattern + comando por día

---

## Archivos de Sistema

| Archivo | Qué es |
|---------|--------|
| `MEMORY.md` | Memoria largo plazo (en workspace/) |
| `index.md` | Este archivo — router |
| `glossary.md` | Desambiguador de términos |
| `inbox.md` | Pendientes de clasificar |
| `heartbeat-state.json` | Estado de checks |
| `brave-usage.json` | Tracking uso Brave API |

---

_Actualizado: 18 Feb 2026 - 06:00 UTC (Pre-update)_
