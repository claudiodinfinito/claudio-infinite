#!/bin/bash
# ==============================================================================
# SCRIPT: system-health-check.sh
# PROPÓSITO: Verificar que el sistema de Claudio está funcionando
# CREADO: 2026-02-21 (autonomía 30 min)
# ==============================================================================

echo "🦉 SYSTEM HEALTH CHECK - $(date)"
echo "================================"

# 1. Gateway status
echo ""
echo "1. GATEWAY STATUS"
if systemctl --user is-active openclaw-gateway &>/dev/null; then
    echo "   ✅ Gateway: Running"
else
    echo "   ❌ Gateway: NOT RUNNING"
fi

# 2. Docker containers
echo ""
echo "2. DOCKER CONTAINERS"
CONTAINERS=$(docker ps --format "{{.Names}}" 2>/dev/null | wc -l)
echo "   Containers running: $CONTAINERS"
if [ "$CONTAINERS" -lt 6 ]; then
    echo "   ⚠️  Less than 6 containers (expected 8)"
fi

# 3. Disk space
echo ""
echo "3. DISK SPACE"
DISK_USAGE=$(df -h / | tail -1 | awk '{print $5}' | sed 's/%//')
echo "   Disk usage: ${DISK_USAGE}%"
if [ "$DISK_USAGE" -gt 80 ]; then
    echo "   ⚠️  Disk usage > 80%"
fi

# 4. RAM
echo ""
echo "4. MEMORY"
RAM_USED=$(free | grep Mem | awk '{print int($3/$2 * 100)}')
echo "   RAM used: ${RAM_USED}%"
if [ "$RAM_USED" -gt 90 ]; then
    echo "   ⚠️  RAM usage > 90%"
fi

# 5. Git status
echo ""
echo "5. GIT STATUS"
cd /root/.openclaw/workspace
if git diff-index --quiet HEAD --; then
    echo "   ✅ Workspace: Clean"
else
    echo "   ⚠️  Uncommitted changes"
fi

# 6. Essential files
echo ""
echo "6. ESSENTIAL FILES"
FILES=("SOUL.md" "PROTOCOLS.md" "AGENTS.md" "USER.md" "MEMORY.md" "SECURITY.md")
for FILE in "${FILES[@]}"; do
    if [ -f "/root/.openclaw/workspace/$FILE" ]; then
        echo "   ✅ $FILE exists"
    else
        echo "   ❌ $FILE MISSING"
    fi
done

# 7. Psych logs directory
echo ""
echo "7. PSYCH LOGS"
if [ -d "/root/.openclaw/workspace/psych_logs" ]; then
    LOG_COUNT=$(ls /root/.openclaw/workspace/psych_logs/*.md 2>/dev/null | wc -l)
    echo "   ✅ psych_logs/ exists ($LOG_COUNT logs)"
else
    echo "   ❌ psych_logs/ missing"
fi

# 8. Cronjobs
echo ""
echo "8. CRONJOBS"
CRON_COUNT=$(crontab -l 2>/dev/null | grep -v "^#" | grep -v "^$" | wc -l)
echo "   Active cronjobs: $CRON_COUNT"

echo ""
echo "================================"
echo "🦉 Health check complete"

# Return code
if [ "$DISK_USAGE" -gt 90 ] || [ "$RAM_USED" -gt 95 ]; then
    exit 1  # Critical
else
    exit 0  # OK
fi
