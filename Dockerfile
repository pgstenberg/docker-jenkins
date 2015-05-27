FROM ubuntu:14.04
MAINTAINER Per-Gustaf Stenberg

USER root

#Installing core-stuff
RUN apt-get update && apt-get -y install software-properties-common

#Install Java8
RUN add-apt-repository ppa:webupd8team/java && apt-get update
RUN echo debconf shared/accepted-oracle-license-v1-1 select true | sudo debconf-set-selections
RUN echo debconf shared/accepted-oracle-license-v1-1 seen true | sudo debconf-set-selections
RUN apt-get -y install oracle-java8-installer

#Installing CI-Tools
RUN apt-get -y install maven2 gradle

#Install Docker
RUN wget -qO- https://get.docker.com/ | sh

#Install Jenkins
RUN wget -q -O - http://pkg.jenkins-ci.org/debian-stable/jenkins-ci.org.key | sudo apt-key add -
RUN echo deb http://pkg.jenkins-ci.org/debian-stable binary/ >> /etc/apt/sources.list
RUN apt-get update && apt-get install -y jenkins
RUN mkdir -p /var/jenkins_home && chown -R jenkins /var/jenkins_home

#Add jenkins to dockergroup
RUN usermod -aG docker jenkins

USER jenkins
# VOLUME /var/jenkins_home - bind this in via -v if you want to make this persistent.
ENV JENKINS_HOME /var/jenkins_home

# for main web interface:
EXPOSE 8080

CMD ["/usr/bin/java",  "-jar",  "/usr/share/jenkins/jenkins.war"]

