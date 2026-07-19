#!/bin/bash
# Lightweight Brute-Force Detection Script

LOG_FILE="/var/log/auth.log"
THRESHOLD=5

echo "=================================================="
echo "🛡️ SECURITY AUDIT: SCANNING FOR BRUTE-FORCE THREATS"
echo "=================================================="
echo "[*] Analyzing system logs..."

# Extract failed logins, isolate IPs, count duplicates, and filter by threshold
failed_ips=$(grep "Failed password" "$LOG_FILE" | awk '{print $(NF-3)}' | sort | uniq -c)

echo "$failed_ips" | while read count ip; do
    if [ "$count" -gt "$THRESHOLD" ]; then
        echo "--------------------------------------------------"
        echo "[🚨 ALERT] Malicious Activity Detected!"
        echo "    -> Source IP: $ip"
        echo "    -> Failed Attempts: $count"
        echo "--------------------------------------------------"
    fi
done

echo "[*] Scan complete. Audit finalized."
