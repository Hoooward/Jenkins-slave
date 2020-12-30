FROM jenkins/inbound-agent:latest
USER root
RUN apk add docker

USER jenkins

ENTRYPOINT ["jenkins-slave"]
