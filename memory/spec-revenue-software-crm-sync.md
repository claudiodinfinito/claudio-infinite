# Spec: Revenue Software CRM Sync (MVP Part 2)

**Version:** 1.0.0
**Status:** DRAFT
**Task ID:** #9 (Multi-agent System - Department 2: Sales/CRM)
**Date:** 2026-02-21

## 🎯 Purpose
Define the synchronization mechanism between the Revenue Software MVP (Astro/PocketBase) and external CRMs to avoid data silos.

## 🛠 Tech Stack
- **Source:** PocketBase (leads/deals)
- **Engine:** n8n (Webhooks + HTTP Request)
- **Targets:** Airtable, HubSpot, or Pipedrive (standardized via JSON mapping)

## 🔄 Sync Logic
1. **Trigger:** `leads` collection create/update in PocketBase.
2. **Action:** Webhook fires to n8n endpoint.
3. **Logic:** 
   - Check for `external_id` in lead metadata.
   - If `external_id` exists: Update external CRM.
   - If NO `external_id`: Create in external CRM + Update PocketBase with `external_id`.

## 📦 Data Schema (Sync Object)
```json
{
  "pb_id": "record_id",
  "name": "Full Name",
  "email": "email@example.com",
  "phone": "+52...",
  "status": "new|qualified|lost|won",
  "metadata": {
    "source": "fb_ads|web|referral",
    "external_id": "crm_12345"
  }
}
```

## 🚀 Next Steps
1. Implement the first worker (Sales Department) to handle these events.
2. Build the n8n template for PocketBase -> Airtable.
