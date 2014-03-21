#!/bin/bash
mkdir /var/run/sshd
mkdir -p /root/.ssh
chmod 700 /root/.ssh

if [[ -z "$AUTHORIZED_KEYS" ]]; then
		echo "NO AUTHORIZED_KEYS found."
else
	# this comes from the command line
	echo $AUTHORIZED_KEYS > /root/.ssh/authorized_keys
fi

chmod 600 /root/.ssh/*
chown -Rf root:root /root/.ssh

# configure sshd to block authentication via password
sed -i.bak 's/#PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config
rm /etc/ssh/sshd_config.bak

/usr/sbin/sshd