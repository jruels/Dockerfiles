FROM jenkinsci/blueocean:latest

USER root
RUN apk update && apk --no-cache add sudo \
&& echo "jenkins ALL=NOPASSWD: ALL" >> /etc/sudoers

# Install plugins
USER jenkins
COPY plugins.txt /usr/share/jenkins/plugins.txt
RUN /usr/local/bin/plugins.sh /usr/share/jenkins/plugins.txt