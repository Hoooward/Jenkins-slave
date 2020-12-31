FROM jenkins/inbound-agent
# The jenkins/inbound-agent is configured to run as the `jenkins` user. To install new software & packages, we'll need to change back to `root`
USER root

# Install Docker
RUN apt update
RUN apt -y install apt-transport-https ca-certificates curl gnupg2 software-properties-common
RUN curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -
RUN add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/debian \
   $(lsb_release -cs) \
   stable"
RUN apt update
RUN apt -y install docker-ce docker-ce-cli containerd.io
RUN usermod -aG docker jenkins
RUN newgrp docker

# Now that we've finished customizing our Jenkins image, we should drop back to the `jenkins` user.
USER jenkins


ENTRYPOINT ["jenkins-agent"]
