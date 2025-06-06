FROM jenkins/jenkins:2.504.2-jdk21

USER root
RUN apt-get update && apt-get install -y lsb-release ca-certificates curl && \
    install -m 0755 -d /etc/apt/keyrings && \
    curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc && \
    chmod a+r /etc/apt/keyrings/docker.asc && \
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] \
    https://download.docker.com/linux/debian $(. /etc/os-release && echo \"$VERSION_CODENAME\") stable" \
    | tee /etc/apt/sources.list.d/docker.list > /dev/null && \
    apt-get update && apt-get install -y docker-ce-cli && \
    apt-get clean && rm -rf /var/lib/apt/lists/* && \
    # Setup jenkins home directory with proper permissions
    mkdir -p /var/jenkins_home && \
    chown -R jenkins:jenkins /var/jenkins_home && \
    chmod -R 755 /var/jenkins_home && \
    # Add jenkins user to docker group and create docker.sock directory
    groupadd -g 998 docker && \
    usermod -aG docker jenkins && \
    mkdir -p /var/run/docker && \
    chown -R jenkins:docker /var/run/docker

USER jenkins
# Install Jenkins plugins
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN jenkins-plugin-cli --plugin-file /usr/share/jenkins/ref/plugins.txt

# Skip initial setup wizard and set Java memory options (Reduce if using smaller instance)
ENV JAVA_OPTS="-Djenkins.install.runSetupWizard=false -Xmx2g -Xms512m"

# Jenkins runs on port 8080 by default
EXPOSE 8080
EXPOSE 50000