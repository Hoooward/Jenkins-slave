FROM jenkins/inbound-agent:4.3-4
ARG DOCKER_VERSION=5:19.03.12~3-0~debian-buster
ARG DC_VERSION=1.27.2
ARG TERRAFORM_VERSION=0.13.5
ARG AWS_PROVIDER_VERSION=3.14.1

ARG JENKINSUID
ARG JENKINSGID
ARG DOCKERGID

RUN apt-get update && \	ARG JENKINSUID
    apt-get install -qq -y --no-install-recommends \	ARG JENKINSGID
    apt-transport-https ca-certificates curl zip gnupg2 software-properties-common && \	ARG DOCKERGID
    curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add - && \	
    apt-key fingerprint 0EBFCD88 && \	# Install Docker in the image, which adds a docker group
    add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian buster stable" && \	RUN apt-get -y update && \
    curl -fsSL https://apt.releases.hashicorp.com/gpg | apt-key add - && \	 apt-get -y install \
    add-apt-repository "deb [arch=amd64] https://apt.releases.hashicorp.com buster main" && \	   apt-transport-https \
    apt-get update && \	   ca-certificates \
    apt-get install -qq -y --no-install-recommends docker-ce=${DOCKER_VERSION} terraform=${TERRAFORM_VERSION} && \	   curl \
    curl -L https://github.com/docker/compose/releases/download/${DC_VERSION}/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose && \	   gnupg \
    chmod +x /usr/local/bin/docker-compose && \	   lsb-release \
    usermod -a -G docker jenkins && \	   software-properties-common
    curl -L https://releases.hashicorp.com/terraform-provider-aws/${AWS_PROVIDER_VERSION}/terraform-provider-aws_${AWS_PROVIDER_VERSION}_linux_amd64.zip -o /tmp/aws-provider.zip && \	
    mkdir -p /usr/lib/terraform-plugins/registry.terraform.io/hashicorp/aws/${AWS_PROVIDER_VERSION}/linux_amd64 && \	RUN curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -
    unzip -d /usr/lib/terraform-plugins/registry.terraform.io/hashicorp/aws/${AWS_PROVIDER_VERSION}/linux_amd64 /tmp/aws-provider.zip && \	RUN add-apt-repository \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*	   "deb [arch=amd64] https://download.docker.com/linux/debian \
    $(lsb_release -cs) \


# Setup users and groups
RUN groupadd -g ${JENKINSGID} jenkins
RUN groupmod -g ${-GID} docker
RUN useradd -c "Jenkins user" -g ${JENKINSGID} -G ${DOCKERGID} -M -N -u ${JENKINSUID} jenkins

ENTRYPOINT ["jenkins-agent"]
