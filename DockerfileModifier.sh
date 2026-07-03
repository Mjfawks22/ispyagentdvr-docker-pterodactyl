FROM mekayelanik/ispyagentdvr:latest

COPY resources/Agent.sh /AgentDVR/Agent.sh
COPY resources/banner.sh /AgentDVR/banner.sh
COPY resources/setup.sh /AgentDVR/setup.sh
COPY resources/cleanup.sh /AgentDVR/cleanup.sh

RUN chmod +x \
    /AgentDVR/Agent.sh \
    /AgentDVR/banner.sh \
    /AgentDVR/setup.sh \
    /AgentDVR/cleanup.sh

ENTRYPOINT ["/AgentDVR/Agent.sh"]