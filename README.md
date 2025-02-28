# asnp
almalinux-snmp-nginx-php

docker build -t almalinux-snmp-nginx-php .


docker run \
-d \
--restart=always \
--network=bridge \
--privileged \
--log-opt max-size=200M  \
--name=asnp \
--volume /etc/mydoc/snmp/snmp:/etc/snmp \
--volume /etc/mydoc/snmp/html:/var/www/html \
--publish 8080:80/tcp \
--publish 161:161/udp \
--publish 162:162/udp \
almalinux-snmp-nginx-php \


docker build -t almalinux-snmp-nginx-php .
