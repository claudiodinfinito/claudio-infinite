# Spec: Client Portal - Kanban de Proyectos

**ID:** SPEC-CLIENT-PORTAL-KANBAN-001
**Fecha:** 2026-02-21 23:15 UTC
**Prioridad:** ALTA
**Tiempo estimado:** 2 horas

---

## 🎯 OBJETIVO

Crear vista Kanban para que clientes vean el estado de sus proyectos en tiempo real.

---

## 📊 FLUJO

```
Cliente login
    ↓
Ve su dashboard
    ↓
Kanban con columnas:
  - Backlog
  - En progreso
  - En revisión
  - Completado
    ↓
Puede mover cards (drag & drop)
    ↓
Comentarios en cada card
    ↓
Notificaciones automáticas
```

---

## 🏗️ ARQUITECTURA

### Frontend (Astro):

```
/src/pages/portal/[clientId]/index.astro
  ├── Dashboard.astro
  ├── Kanban.astro
  └── ProjectCard.astro
```

### Backend (PocketBase):

**Nueva collection: `project_cards`**

| Campo | Tipo | Propósito |
|-------|------|-----------|
| client | relation | Cliente dueño |
| title | text | Título de la tarea |
| description | text | Descripción |
| status | select | backlog, in_progress, review, done |
| priority | select | low, medium, high, urgent |
| assigned_to | relation | Usuario responsable |
| due_date | date | Fecha límite |
| comments | relation | Comentarios |
| created | autodate | Fecha creación |
| updated | autodate | Última actualización |

**Nueva collection: `comments`**

| Campo | Tipo | Propósito |
|-------|------|-----------|
| card | relation | Card relacionada |
| author | relation | Usuario que comenta |
| text | text | Comentario |
| created | autodate | Fecha |

---

## 🎨 UI/UX

### Columnas Kanban:

```
┌─────────────┬─────────────┬─────────────┬─────────────┐
│  BACKLOG    │ EN PROGRESO │ EN REVISIÓN │ COMPLETADO  │
│  (2 cards)  │  (1 card)   │  (0 cards)  │  (3 cards)  │
├─────────────┼─────────────┼─────────────┼─────────────┤
│ ┌─────────┐ │ ┌─────────┐ │             │ ┌─────────┐ │
│ │Task 1   │ │ │Task 3   │ │             │ │Task 5   │ │
│ │Due: Feb │ │ │Due: Mar │ │             │ │Done ✓   │ │
│ │P: High  │ │ │P: Med   │ │             │ │Done ✓   │ │
│ └─────────┘ │ └─────────┘ │             │ └─────────┘ │
│ ┌─────────┐ │             │             │ ┌─────────┐ │
│ │Task 2   │ │             │             │ │Task 6   │ │
│ │Due: Mar │ │             │             │ │Done ✓   │ │
│ │P: Low   │ │             │             │ └─────────┘ │
│ └─────────┘ │             │             │             │
└─────────────┴─────────────┴─────────────┴─────────────┘
```

### Colores por prioridad:

| Prioridad | Color |
|-----------|-------|
| Low | Gris |
| Medium | Azul |
| High | Naranja |
| Urgent | Rojo |

### Indicadores visuales:

- 🔴 Overdue (pasó fecha límite)
- 🟡 Due soon (en 3 días)
- 🟢 On track
- ✓ Completed

---

## 🔧 TECNOLOGÍAS

### Frontend:

| Tecnología | Uso |
|------------|-----|
| **Astro 5** | Framework |
| **React** | Componentes interactivos |
| **Tailwind** | Estilos |
| **@dnd-kit** | Drag & drop |

### Backend:

| Tecnología | Uso |
|------------|-----|
| **PocketBase** | DB + Auth |
| **Realtime API** | Updates en vivo |

---

## 📝 CÓDIGO

### Componente Kanban:

```astro
---
// src/pages/portal/[clientId]/index.astro
import { DndContext } from '@dnd-kit/core';
import KanbanColumn from '../../components/KanbanColumn.astro';

const clientId = Astro.params.clientId;
const cards = await pb.collection('project_cards').getFullList({
  filter: `client = "${clientId}"`,
  sort: '-created'
});
---

<DndContext onDragEnd={handleDragEnd}>
  <div class="kanban-grid">
    <KanbanColumn title="Backlog" status="backlog" cards={cards} />
    <KanbanColumn title="En Progreso" status="in_progress" cards={cards} />
    <KanbanColumn title="En Revisión" status="review" cards={cards} />
    <KanbanColumn title="Completado" status="done" cards={cards} />
  </div>
</DndContext>
```

### Drag & Drop handler:

```typescript
async function handleDragEnd(event) {
  const { active, over } = event;
  
  if (!over) return;
  
  const cardId = active.id;
  const newStatus = over.data.current.status;
  
  await pb.collection('project_cards').update(cardId, {
    status: newStatus
  });
}
```

---

## 🔔 NOTIFICACIONES

### Webhook PocketBase → Telegram:

```javascript
// Cuando se actualiza una card
pb.collection('project_cards').subscribe('*', function(e) {
  if (e.action === 'update') {
    // Enviar notificación a Telegram
    fetch('https://api.telegram.org/bot[TOKEN]/sendMessage', {
      method: 'POST',
      body: JSON.stringify({
        chat_id: '[CLIENT_CHAT]',
        text: `📋 Proyecto actualizado: ${e.record.title}`
      })
    });
  }
});
```

---

## 🔐 SEGURIDAD

### Reglas PocketBase:

```javascript
// listRule
@request.auth.id != "" && client = @request.auth.id

// viewRule
@request.auth.id != "" && client = @request.auth.id

// createRule
@request.auth.id != "" && client = @request.auth.id

// updateRule
@request.auth.id != "" && client = @request.auth.id

// deleteRule
@request.auth.id != "" && client = @request.auth.id
```

**Solo el cliente dueño puede ver/editar sus cards.**

---

## 📱 RESPONSIVE

### Mobile:

- 1 columna a la vez
- Swipe para cambiar columna
- Cards expandidas al tap

### Desktop:

- 4 columnas visibles
- Drag & drop habilitado
- Hover effects

---

## 🚀 MILESTONES

| # | Tarea | Tiempo |
|---|-------|--------|
| 1 | Crear collection project_cards | 10 min |
| 2 | Crear collection comments | 5 min |
| 3 | Implementar Kanban.astro | 30 min |
| 4 | Añadir drag & drop | 20 min |
| 5 | Configurar realtime updates | 15 min |
| 6 | Estilar con Tailwind | 20 min |
| 7 | Notificaciones Telegram | 10 min |
| 8 | Testing | 10 min |

**Total: 2 horas**

---

## ✅ DEFINITION OF DONE

- [ ] Cliente puede ver sus cards
- [ ] Cliente puede mover cards entre columnas
- [ ] Cliente puede agregar comentarios
- [ ] Notificaciones llegan a Telegram
- [ ] Responsive en móvil y desktop
- [ ] Tests básicos pasando
- [ ] Documentación actualizada

---

## 📚 REFERENCIAS

- PocketBase Realtime: https://pocketbase.io/docs/manage-realtime/
- @dnd-kit: https://docs.dndkit.com/
- RevOps MVP Spec: `memory/spec-revenue-software-mvp.md`

---

_Creado: 2026-02-21 23:15 UTC - Ready to implement_
