FROM jenkins/jenkins:latest

USER root

# Install necessary packages
RUN apt-get update && apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

# Add Docker's official GPG key
RUN curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -

RUN curl -fsSL https://get.docker.com | sh
RUN usermod -aG docker jenkins

# Add the Jenkins user to the Docker group
RUN usermod -aG docker jenkins

USER jenkins

# Install docker-rollout plugin
RUN mkdir -p $HOME/.docker/cli-plugins && \
    curl -fsSL https://raw.githubusercontent.com/wowu/docker-rollout/master/docker-rollout -o $HOME/.docker/cli-plugins/docker-rollout && \
    chmod +x $HOME/.docker/cli-plugins/docker-rollout

# Enable blueocean plugin
RUN jenkins-plugin-cli --plugins "blueocean"
