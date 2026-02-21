# SPEC - Revenue Software CRM Sync

**ID:** #9 (Dept 2)
**Fecha:** 2026-02-21 12:53 UTC
**Autor:** Claudio 🦉
**Estado:** DRAFT

---

## 🎯 Objetivo
Definir el flujo de sincronización bidireccional entre el núcleo de datos (**PocketBase**) y CRMs externos (HubSpot, Salesforce, Pipedrive) para el **Revenue Software**.

## 🏗️ Arquitectura
- **Source of Truth:** PocketBase (`contacts` table)
- **Middleware:** n8n (Webhooks + CRM Nodes)
- **External:** CRM API

## 🔄 Flujo de Sincronización

### 1. PocketBase → CRM (Outbound)
- **Trigger:** PocketBase `collections/contacts/records` (Create/Update Hook)
- **Action:** Enviar POST a webhook de n8n
- **n8n Logic:**
  1. Identificar si el contacto ya existe en el CRM (vía Email)
  2. Si existe: UPDATE
  3. Si no existe: CREATE
  4. Actualizar `crm_id` en PocketBase

### 2. CRM → PocketBase (Inbound)
- **Trigger:** CRM Webhook (Contact change)
- **Action:** n8n recibe el cambio
- **n8n Logic:**
  1. Buscar contacto en PocketBase vía `crm_id` o `email`
  2. Aplicar cambios (Merge logic: CRM gana en campos de ventas, PB gana en campos de marketing)

## 🛠️ Campos Core
- `email` (Primary Key)
- `first_name`
- `last_name`
- `phone`
- `lead_source`
- `lifecycle_stage`
- `crm_id`
- `last_sync_at`

## ⚠️ Riesgos
- **Race conditions:** Doble actualización simultánea
- **API Limits:** Rate limits de los CRMs
- **Loop infinito:** A actualiza B -> B actualiza A

## ✅ Próximos Pasos
1. Configurar Webhook en PocketBase
2. Crear workflow base en n8n
3. Implementar lógica de merge (conflict resolution)
