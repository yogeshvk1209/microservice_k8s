FROM jenkins/jenkins:lts-jdk11

# Set Jenkins user and group explicitly
ENV JENKINS_USER=jenkins
ENV JENKINS_GROUP=jenkins
ENV JENKINS_UID=1000
ENV JENKINS_GID=1000

USER root
RUN apt-get update && \
    apt-get install -y apt-transport-https \
                       ca-certificates \
                       curl \
                       gnupg \
                       lsb-release && \
    curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg && \
    echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian \
    #echo "deb [arch=arm64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian \
    $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null && \
    apt-get update && \
    apt-get install -y docker-ce-cli && \
    # Ensure Jenkins user and group exist with correct IDs
    groupmod -g ${JENKINS_GID} ${JENKINS_GROUP} && \
    usermod -u ${JENKINS_UID} -g ${JENKINS_GID} ${JENKINS_USER} && \
    # Set correct permissions for Jenkins directories
    mkdir -p /var/jenkins_home && \
    chown -R ${JENKINS_USER}:${JENKINS_GROUP} /var/jenkins_home && \
    chown -R ${JENKINS_USER}:${JENKINS_GROUP} /usr/share/jenkins/ref && \
    chmod -R 755 /var/jenkins_home

# Create entrypoint script
COPY <<EOF /usr/local/bin/jenkins-entrypoint.sh
#!/bin/bash
set -e

# Ensure proper ownership of volume mount
chown -R ${JENKINS_USER}:${JENKINS_GROUP} /var/jenkins_home

# Switch to jenkins user and execute original entrypoint
exec gosu ${JENKINS_USER} /usr/local/bin/jenkins.sh
EOF

RUN chmod +x /usr/local/bin/jenkins-entrypoint.sh && \
    apt-get update && \
    apt-get install -y gosu && \
    # Verify that gosu is working
    gosu nobody true

USER ${JENKINS_USER}
# Install Jenkins plugins
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN jenkins-plugin-cli --plugin-file /usr/share/jenkins/ref/plugins.txt

# Skip initial setup wizard and set Java memory options (Reduce if using smaller instance)
ENV JAVA_OPTS="-Djenkins.install.runSetupWizard=false -Xmx2g -Xms512m"

# Jenkins runs on port 8080 by default
EXPOSE 8080
EXPOSE 50000 

ENTRYPOINT ["/usr/local/bin/jenkins-entrypoint.sh"]
