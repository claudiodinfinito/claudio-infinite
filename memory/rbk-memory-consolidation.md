# Runbook: Consolidación de Memoria

ID: RBK-MEMORY-CONSOLID-001
Status: active
Tags: #memory #cleanup #consolidation #maintenance
Keys: memory, consolidation, cleanup, duplicates, maintenance
Last reviewed: 2026-02-21

---

## Propósito

Mantener el directorio `memory/` limpio y sin duplicados.

---

## Cuándo Ejecutar

- Micro-tarea autónoma (5 min)
- Cuando `ls memory/*.md | wc -l` > 100
- Cuando identifique archivos similares en index.md

---

## Flujo de Trabajo

### Paso 1: Identificar Candidatos

```bash
# Buscar archivos con nombres similares
ls memory/ | grep -E "(ref-one-liners|rbk-auto-repair|rbk-cronjob)"
```

### Paso 2: Comparar Contenido

```bash
# Comparar dos archivos
diff -u memory/archivo1.md memory/archivo2.md
```

### Paso 3: Decidir

| Situación | Acción |
|-----------|--------|
| Duplicado exacto | Eliminar el más viejo |
| Similar, diferentes IDs | Consolidar en uno, referenciar desde el otro |
| Tema común, enfoques diferentes | Mantener ambos, añadir referencia cruzada |

### Paso 4: Ejecutar

```bash
# Si eliminé archivo, actualizar index
# Editar index.md para reflejar cambio
```

### Paso 5: Commit

```bash
git add -A && git commit -m "consolidate: elimino duplicado X, mantengo Y"
```

---

## Reglas de Consolidación

### NO Consolidar

| Tipo | Razón |
|------|-------|
| Archivos de días diferentes | Cada día = log independiente |
| Temas con enfoques diferentes | Anchor deep ≠ SEO checklist |
| Runbooks específicos vs generales | Auto-repair general ≠ Cronjob específico |
| Specs de sistemas diferentes | Cada sistema tiene su propio scope |

### SÍ Consolidar

| Tipo | Acción |
|------|--------|
| Mismo ID, diferentes archivos | Mantener uno, eliminar otro |
| Mismo contenido, diferente nombre | Mantener el más reciente/mejor formato |
| Archivos vacíos o placeholders | Eliminar |

---

## Consolidaciones Realizadas

| Fecha | Eliminado | Mantenido | Razón |
|-------|-----------|-----------|-------|
| 2026-02-21 | `ref-one-liners-glm5.md` | `ref-one-liners-glm5-optimized.md` | Duplicado, mejor formato en optimized |

---

## Categorías con Múltiples Archivos (Revisar)

| Categoría | Archivos | Estado |
|-----------|----------|--------|
| One-liners | `ref-one-liners-glm5-optimized.md`, `ref-one-liners-advanced.md` | ✅ Complementarios (básicos vs avanzados) |
| Auto-repair | `rbk-auto-repair.md`, `rbk-auto-repair-cronjobs.md`, `rbk-cronjob-errors.md` | ✅ Diferentes scopes (general vs específico) |
| Google Leak | 6 archivos | ✅ Diferentes temas (urls, source, anchors, demotions, ranking, checklist) |

---

## Comando Rápido

```bash
# Ver cantidad de archivos en memory/
ls memory/*.md | wc -l

# Ver archivos que empiezan igual
ls memory/ | cut -d'-' -f1-2 | sort | uniq -c | sort -rn | head -10
```

---

## Referencias

- `memory/index.md` - Índice principal
- `memory/glossary.md` - Términos
- `ref-cleanup-patterns.md` - Patrones de limpieza

---

_Creado: 2026-02-21 - Tarea autónoma de consolidación_
