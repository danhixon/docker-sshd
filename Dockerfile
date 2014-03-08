FROM zumbrunnen/base

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get -qq update
RUN apt-get -yqq upgrade
RUN apt-get -yqq install openssh-server

ADD authorized_keys /authorized_keys
ADD configure.sh /configure.sh
RUN bin/bash /configure.sh && rm /configure.sh

ADD supervisor.conf /etc/supervisor/conf.d/sshd.conf

EXPOSE 22

CMD ["/usr/bin/supervisord","-n"]

