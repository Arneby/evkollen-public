#!/bin/bash
# Kör som User Script i Unraid (t.ex. varje natt via cron).
# Kräver att WORKER_SECRET sätts som miljövariabel i Unraid,
# eller ändra till ett fast värde nedan.

IMAGE="ghcr.io/arneby/evkollen-public-scraper:latest"
LOG="/mnt/user/appdata/evkollen-public/scraper.log"
WORKER_URL="https://evkollen-public-worker.gurka.workers.dev"

mkdir -p "$(dirname "$LOG")"

{
  echo "--- $(date '+%Y-%m-%d %H:%M:%S') ---"
  docker pull "$IMAGE"
  docker run --rm \
    -e WORKER_URL="$WORKER_URL" \
    -e WORKER_SECRET="$WORKER_SECRET" \
    "$IMAGE"
} >> "$LOG" 2>&1
