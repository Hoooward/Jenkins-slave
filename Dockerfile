FROM jenkins/inbound-agent:4.3-4
ARG DOCKER_VERSION=5:19.03.12~3-0~debian-buster
ARG DC_VERSION=1.27.2
ARG TERRAFORM_VERSION=0.13.5
ARG AWS_PROVIDER_VERSION=3.14.1

ARG JENKINSUID
ARG JENKINSGID
ARG DOCKERGID

# Install Docker in the image, which adds a docker group
RUN apt-get -y update && \
 apt-get -y install \
   apt-transport-https \
   ca-certificates \
   curl \
   gnupg \
   lsb-release \
   software-properties-common

RUN curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -
RUN add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/debian \
   $(lsb_release -cs) \
   stable"

RUN apt-get -y update && \
 apt-get -y install \
   docker-ce \
   docker-ce-cli \
   containerd.io

# Setup users and groups
RUN groupadd -g ${JENKINSGID} jenkins
RUN groupmod -g ${-GID} docker
RUN useradd -c "Jenkins user" -g ${JENKINSGID} -G ${DOCKERGID} -M -N -u ${JENKINSUID} jenkins

ENTRYPOINT ["jenkins-agent"]
