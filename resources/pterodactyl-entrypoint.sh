#!/usr/bin/env bash
set -e

cd /home/container

mkdir -p \
  /home/container/config \
  /home/container/media \
  /home/container/models \
  /home/container/commands \
  /home/container/masks \
  /home/container/sounds

copy_defaults() {
  src="$1"
  dst="$2"

  if [ -d "$src" ] && [ -z "$(ls -A "$dst" 2>/dev/null)" ]; then
    cp -a "$src"/. "$dst"/ 2>/dev/null || true
  fi
}

copy_defaults /opt/agentdvr-defaults/Commands /home/container/commands
copy_defaults /opt/agentdvr-defaults/Masks /home/container/masks
copy_defaults /opt/agentdvr-defaults/sounds /home/container/sounds
copy_defaults /opt/agentdvr-defaults/Media/XML /home/container/config
copy_defaults /opt/agentdvr-defaults/Media/WebServerRoot/Media /home/container/media
copy_defaults /opt/agentdvr-defaults/Media/Models /home/container/models

if [ -n "${SERVER_PORT:-}" ] && [ -z "${AGENTDVR_WEBUI_PORT:-}" ]; then
  export AGENTDVR_WEBUI_PORT="$SERVER_PORT"
fi

if [ -f /AgentDVR/Agent.sh ]; then
  exec /AgentDVR/Agent.sh
fi

exec /AgentDVR/Agent