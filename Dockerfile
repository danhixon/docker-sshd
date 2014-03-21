FROM zumbrunnen/base

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get -qq update
RUN apt-get -yqq upgrade
RUN apt-get -yqq install openssh-server

ADD start_sshd.sh /start_sshd.sh
RUN chmod +x /start_sshd.sh

ADD supervisor.conf /etc/supervisor/conf.d/sshd.conf

EXPOSE 22

CMD ["/usr/bin/supervisord", "-n"]

