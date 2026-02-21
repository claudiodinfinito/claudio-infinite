# PocketBase RevOps Agency - Documentación

**Instalado:** 2026-02-21 19:05 UTC
**Ubicación:** `/opt/pocketbase/`
**Puerto:** 8095

---

## Estado

| Componente | Valor |
|------------|-------|
| Servicio | `pocketbase-revops.service` |
| URL Admin | `http://localhost:8095/_/` (solo desde VPS) |
| Admin email | `claudio@revops.agency` |
| Admin password | `ClaudioRevOps2026!` |
| Status | ✅ Activo |

---

## Collections Creadas

| Collection | Propósito | Campos |
|------------|-----------|--------|
| **leads** | Prospectos | name, email, phone, company, source, status, notes |
| **contacts** | Contactos | name, email, phone, company, role |
| **companies** | Empresas | name, website, industry, size |

---

## Cómo Acceder

### Opción 1: Túnel SSH
```bash
ssh -L 8095:localhost:8095 root@192.227.249.251
```
Luego abrir: `http://localhost:8095/_/`

### Opción 2: Desde el VPS directamente
```bash
curl http://localhost:8095/api/collections/leads/records
```

---

## Para Claudio (OpenClaw)

**Puerto:** 8095
**Host:** localhost (desde VPS)
**Auth:** Necesario crear reglas API o usar superuser

**Endpoints:**
- Health: `GET /api/health`
- Collections: `GET /api/collections`
- Records: `GET/POST /api/collections/{collection}/records`

---

## Próximos Pasos

1. Configurar reglas de API (listRule, createRule, etc.)
2. Crear API keys para acceso desde scripts
3. Conectar con Astro frontend
4. Documentar workflows de importación

---

_Instalación completada automáticamente_
