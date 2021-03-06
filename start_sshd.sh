#!/bin/bash

echo "Creating required directories"
mkdir /var/run/sshd
mkdir -p /root/.ssh
chmod 700 /root/.ssh

if [[ -z "$AUTHORIZED_KEYS" ]]; then
		echo "NO AUTHORIZED_KEYS found."
else
	echo "Writing authorized_keys"
	# sed will find the email address looking names and append a carriage return
	echo $AUTHORIZED_KEYS | sed -e "s/\S\+@\S\+\s/&\n/g" > /root/.ssh/authorized_keys
fi

chmod 600 /root/.ssh/*
chown -Rf root:root /root/.ssh

# configure sshd to block authentication via password
sed -i.bak 's/#PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config
rm /etc/ssh/sshd_config.bak

echo "Starting sshd"
/usr/sbin/sshd