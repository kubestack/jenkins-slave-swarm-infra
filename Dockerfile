FROM java:8-jdk
MAINTAINER Yolanda Robla <info@ysoft.biz>
ENV JENKINS_SWARM_VERSION 2.0
ENV HOME /home/jenkins-slave
RUN apt-get -y update
RUN apt-get -y install sudo git build-essential python-dev gcc python-virtualenv python-yaml python-pip libffi-dev
RUN useradd -c "Jenkins Slave user" -d $HOME -m jenkins-slave -g sudo
RUN curl --create-dirs -sSLo /usr/share/jenkins/swarm-client-$JENKINS_SWARM_VERSION-jar-with-dependencies.jar http://maven.jenkins-ci.org/content/repositories/releases/org/jenkins-ci/plugins/swarm-client/$JENKINS_SWARM_VERSION/swarm-client-$JENKINS_SWARM_VERSION-jar-with-dependencies.jar \
  && chmod 755 /usr/share/jenkins
COPY jenkins-slave.sh /usr/local/bin/jenkins-slave.sh
ENTRYPOINT ["/usr/local/bin/jenkins-slave.sh"]
