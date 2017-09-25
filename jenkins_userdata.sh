#!/bin/bash

JENKINS_HOME=/opt/jenkins_home
if [ ! -e ~/.aws/config  ]; then
    # NOTE: The "Indexes" option is disabled in the php:apache base image
    cat > ~/.aws/config <<-'EOF'
        [default]
        region = ${region}
    EOF
fi
if [ ! -e ~/.aws/credentials  ]; then
    # NOTE: The "Indexes" option is disabled in the php:apache base image
    cat > ~/.aws/credentials <<-'EOF'
        [default]
        aws_access_key_id = ${aws_access_key}
        aws_secret_access_key = ${aws_secret_key}
    EOF
fi
# Create and set correct permissions for Jenkins mount directory
sudo mkdir -p $JENKINS_HOME
sudo chmod -R 777 $JENKINS_HOME
# Start Jenkins
docker run -u root -id --name jenkins3 -p 80:8080 -p 50000:50000 -v $JENKINS_HOME:/var/jenkins_home -v /var/run/docker.sock:/var/run/docker.sock -v $(which docker):/bin/docker jamsheer/awscli-jenkins:latest