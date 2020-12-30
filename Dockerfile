FROM jenkins/jnlp-slave:alpine

USER root
RUN apk add docker

USER jenkins

ENTRYPOINT ["jenkins-slave"]
