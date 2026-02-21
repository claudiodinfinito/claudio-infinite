#!/bin/bash
# ==============================================================================
# SCRIPT: cleanup-old-logs.sh
# PROPÓSITO: Limpiar logs antiguos >30 días de forma segura
# CREADO: 2026-02-21 (autonomía 3h)
# AUTOR: Claudio
# ==============================================================================

set -e

echo "🦉 LIMPIEZA DE LOGS ANTIGUOS"
echo "============================"
echo ""

# Configuración
DAYS_OLD=30
DRY_RUN=true  # Por defecto, solo mostrar qué se borraría

# Parsear argumentos
if [ "$1" = "--execute" ]; then
    DRY_RUN=false
fi

# Directorios a limpiar
DIRS=(
    "/tmp/openclaw"
    "/var/log"
)

# Extensiones de log
EXTENSIONS=("*.log" "*.log.*")

# Contadores
TOTAL_FILES=0
TOTAL_SIZE=0

# Función para formatear tamaño
format_size() {
    local bytes=$1
    if [ $bytes -lt 1024 ]; then
        echo "${bytes}B"
    elif [ $bytes -lt 1048576 ]; then
        echo "$((bytes / 1024))KB"
    else
        echo "$((bytes / 1048576))MB"
    fi
}

# Buscar archivos antiguos
echo "Buscando archivos con más de $DAYS_OLD días..."
echo ""

for dir in "${DIRS[@]}"; do
    if [ -d "$dir" ]; then
        for ext in "${EXTENSIONS[@]}"; do
            while IFS= read -r -d '' file; do
                if [ -f "$file" ]; then
                    SIZE=$(stat -f%z "$file" 2>/dev/null || stat -c%s "$file" 2>/dev/null || echo "0")
                    TOTAL_FILES=$((TOTAL_FILES + 1))
                    TOTAL_SIZE=$((TOTAL_SIZE + SIZE))

                    if [ "$DRY_RUN" = true ]; then
                        echo "  [DRY RUN] Se borraría: $file ($(format_size $SIZE))"
                    else
                        echo "  Borrando: $file ($(format_size $SIZE))"
                        rm -f "$file"
                    fi
                fi
            done < <(find "$dir" -type f -name "$ext" -mtime +$DAYS_OLD -print0 2>/dev/null)
        done
    fi
done

echo ""
echo "============================"
echo "Resumen:"
echo "  Archivos encontrados: $TOTAL_FILES"
echo "  Tamaño total: $(format_size $TOTAL_SIZE)"

if [ "$DRY_RUN" = true ]; then
    echo ""
    echo "⚠️  MODO DRY RUN - No se borró nada"
    echo "Para ejecutar realmente: $0 --execute"
else
    echo ""
    echo "✅ Limpieza completada"
fi

echo "🦉 Fin de limpieza"
