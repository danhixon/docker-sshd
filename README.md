# docker-sshd

A container from Ubuntu 12.04 with supervisord and openssh-server preinstalled to be used as a base image for other services. A mash up of [sullof/docker-sshd](https://github.com/sullof/docker-sshd) and [zumbrunnen/docker-base](https://github.com/zumbrunnen/docker-base). This one includes .conf files added to the /etc/supervisor/conf.d directory. This seems neater than appending to the supervisord.conf file.

## Usage

	$ docker pull danhixon/docker-sshd
	  # grant access to my public key
	$ docker run -d -e AUTHORIZED_KEYS="$(cat ~/.ssh/id_rsa.pub)" danhixon/docker-sshd
	  # grant access to all the public keys in the authorized_keys file:
	$ docker run -d -p 372999:22 -e AUTHORIZED_KEYS="$(cat ~/.ssh/authorized_keys)" danhixon/docker-sshd

Include whatever public keys you want to allow ssh access. The above command will copy the authorized_keys of the host to the docker container. Be sure to map a port for it if you want to access it from outside the docker host.

Here's how you connect:

	$ docker ps
	CONTAINER ID        IMAGE                         COMMAND             CREATED              STATUS              PORTS                   NAMES
	e13e48deeb4a        danhixon/docker-sshd:latest   /bin/bash           About a minute ago   Up About a minute   0.0.0.0:372999->22/tcp   grave_lovelace   
	$ ssh root@localhost -p 372999
	root@0a3739387477:~# echo "Hooray. I made it."

If you are running docker on OSX you must remember that the mapped port is only mapped on the boot2docker instance and will not be accessible from OSX.

## What next?

You can create new images starting your Dockerfile with something like

	FROM danhixon/docker-sshd

and add any *.conf files you wish to the /etc/supervisor/conf.d/ directory. For example:

  ADD supervisor.conf /etc/supervisor/conf.d/rails.conf

## License 

(The MIT License)

Copyright (c) 2013 Dan Hixon <danhixon@gmail.com>

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

