#!/bin/bash

JENKINS_HOME=/opt/jenkins_home

# Create and set correct permissions for Jenkins mount directory
sudo mkdir -p $JENKINS_HOME
sudo chmod -R 777 $JENKINS_HOME
curl --silent --show-error --retry 5 https://bootstrap.pypa.io/get-pip.py | sudo python
sudo env 'PATH=$PATH:/usr/local/bin' pip install awscli
# Start Jenkins
docker run -u root -id --name jenkins3 -p 80:8080 -p 50000:50000 -v $JENKINS_HOME:/var/jenkins_home -v /var/run/docker.sock:/var/run/docker.sock -v $(which docker):/bin/docker jenkins/jenkins:lts