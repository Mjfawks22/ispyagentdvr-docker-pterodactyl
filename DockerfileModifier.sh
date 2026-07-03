FROM mekayelanik/ispyagentdvr:latest

USER root

RUN set -eux; \
    mkdir -p /opt/agentdvr-defaults; \
    for d in Commands Masks sounds Media/XML Media/WebServerRoot/Media Media/Models; do \
        if [ -e "/AgentDVR/Content/$d" ]; then \
            mkdir -p "/opt/agentdvr-defaults/$(dirname "$d")"; \
            cp -a "/AgentDVR/Content/$d" "/opt/agentdvr-defaults/$d"; \
        elif [ -e "/AgentDVR/$d" ]; then \
            mkdir -p "/opt/agentdvr-defaults/$(dirname "$d")"; \
            cp -a "/AgentDVR/$d" "/opt/agentdvr-defaults/$d"; \
        fi; \
    done; \
    rm -rf \
        /AgentDVR/Commands \
        /AgentDVR/Masks \
        /AgentDVR/sounds \
        /AgentDVR/Media/XML \
        /AgentDVR/Media/WebServerRoot/Media \
        /AgentDVR/Media/Models \
        /AgentDVR/tag; \
    mkdir -p /AgentDVR/Media/WebServerRoot; \
    ln -s /home/container/commands /AgentDVR/Commands; \
    ln -s /home/container/masks /AgentDVR/Masks; \
    ln -s /home/container/sounds /AgentDVR/sounds; \
    ln -s /home/container/config /AgentDVR/Media/XML; \
    ln -s /home/container/media /AgentDVR/Media/WebServerRoot/Media; \
    ln -s /home/container/models /AgentDVR/Media/Models; \
    ln -s /home/container/tag /AgentDVR/tag; \
    rm -rf /AgentDVR/Content

COPY resources/pterodactyl-entrypoint.sh /AgentDVR/pterodactyl-entrypoint.sh

RUN chmod +x /AgentDVR/pterodactyl-entrypoint.sh

ENTRYPOINT ["/AgentDVR/pterodactyl-entrypoint.sh"]