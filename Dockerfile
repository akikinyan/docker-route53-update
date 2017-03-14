FROM ubuntu:trusty

# initialize
RUN apt-get update && apt-get -y upgrade
RUN apt-get -y install curl
RUN apt-get -y install python

# awscli
RUN curl "https://bootstrap.pypa.io/get-pip.py" -o "get-pip.py"
RUN sudo python get-pip.py
RUN sudo pip install awscli
RUN rm -f /get-pip.py

# user command
ADD ./run.sh /root
ADD ./ip_watch.sh /root

ENTRYPOINT ["/bin/bash", "/root/run.sh"]
