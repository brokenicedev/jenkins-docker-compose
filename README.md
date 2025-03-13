# Official Jenkins Docker image

[![Docker Stars](https://img.shields.io/docker/stars/jenkins/jenkins.svg)](https://hub.docker.com/r/jenkins/jenkins/)
[![Docker Pulls](https://img.shields.io/docker/pulls/jenkins/jenkins.svg)](https://hub.docker.com/r/jenkins/jenkins/)
[![Join the chat at https://gitter.im/jenkinsci/docker](https://badges.gitter.im/jenkinsci/docker.svg)](https://gitter.im/jenkinsci/docker?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

The Jenkins Continuous Integration and Delivery server [available on Docker Hub](https://hub.docker.com/r/jenkins/jenkins).

This is a fully functional Jenkins server with docker and docker-compose installed.
[https://jenkins.io/](https://jenkins.io/).

<img src="https://jenkins.io/sites/default/files/jenkins_logo.png"/>

# Build local

```
docker build -t brokenice/jenkins-docker-compose:0.0.1 .
```

or for amd:

```
docker pull --platform=linux/amd64 jenkins/jenkins:latest
docker build --platform=linux/amd64 --no-cache -t brokenice/jenkins-docker-compose:3.0.3 .
```

# Push new version to docker-hub


```
docker login -u brokenice
docker push brokenice/jenkins-docker-compose:0.0.1
```

# Usage publish version

create a folder called jenkins-docker, inside the folder make a directory called **jenkins** and a file called **docker-compose.yml** with this content:


```
version: '3.7'
services:
  jenkins:
    image: brokenice/jenkins:2.249.1
    privileged: true
    #user: root
    user 1000:998
    ports:
      - 8081:8080
      - 50000:50000
    container_name: jenkins
    volumes:
      - ~/jenkins:/var/jenkins_home
      - /var/run/docker.sock:/var/run/docker.sock
      - /usr/local/bin/docker:/usr/local/bin/docker

```

Now you can run

```
docker-compose up
```

The jenkins data will survive in the folder **jenkins**

# to check docker group id
getent group docker


