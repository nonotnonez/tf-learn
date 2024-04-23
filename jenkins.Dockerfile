FROM jenkins/jenkins:alpine
MAINTAINER tuanta <nonotnonez@gmail.com>

#COPY plugins.txt /usr/share/jenkins/plugins.txt
#RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/plugins.txt

EXPOSE 8080
# EXPOSE 50000 # uncomment this line if you want to attach slaves to this container
