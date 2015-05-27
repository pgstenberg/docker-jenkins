#Hello World test

FROM jenkins
MAINTAINER Per-Gustaf Stenberg

USER root

#Installing core-stuff
RUN apt-get update
RUN apt-get -y install software-properties-common

#Install Java8
RUN add-apt-repository ppa:webupd8team/java
RUN apt-get update
RUN echo debconf shared/accepted-oracle-license-v1-1 select true | sudo debconf-set-selections
RUN echo debconf shared/accepted-oracle-license-v1-1 seen true | sudo debconf-set-selections
RUN apt-get -y install oracle-java8-installer

#Installing Maven
RUN apt-get -y install maven2
#Installing Gradle
RUN apt-get -y install gradle
#Installing Docker
RUN apt-get -y install docker.io

#Install more stuff here.

USER jenkins