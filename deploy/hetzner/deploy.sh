#!/usr/bin/env bash
# Pull the fork, rebuild the image and restart AIOStreams. Run on the server,
# or from your machine: ssh hetzner /root/aiostreams/deploy/hetzner/deploy.sh
set -euo pipefail
cd "$(dirname "$0")"

if [ ! -f .env ]; then
  echo "No .env here: copy .env.example to .env and fill it in first." >&2
  exit 1
fi

git -C ../.. pull --ff-only
docker compose build --pull
docker compose up -d
docker image prune -f >/dev/null
docker compose ps
