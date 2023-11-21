FROM jenkins/jenkins:latest
MAINTAINER luca.becchetti@brokenice.it
USER root

# Install the latest Docker CE binaries
RUN apt-get update && \
    apt-get -y install apt-transport-https \
      ca-certificates \
      curl \
      gnupg2 \
      software-properties-common && \
    curl -fsSL https://download.docker.com/linux/$(. /etc/os-release; echo "$ID")/gpg > /tmp/dkey; apt-key add /tmp/dkey && \
    add-apt-repository \
      "deb [arch=amd64] https://download.docker.com/linux/$(. /etc/os-release; echo "$ID") \
      $(lsb_release -cs) \
      stable" && \
   apt-get update && \
   apt-get -y install docker-ce docker-compose

RUN adduser jenkins docker
RUN adduser root docker

USER jenkins

# Install docker-rollout plugin
RUN mkdir -p $HOME/.docker/cli-plugins && \
    curl -fsSL https://raw.githubusercontent.com/wowu/docker-rollout/master/docker-rollout -o $HOME/.docker/cli-plugins/docker-rollout && \
    chmod +x $HOME/.docker/cli-plugins/docker-rollout

# Enable blueocean plugin
RUN jenkins-plugin-cli --plugins "blueocean"