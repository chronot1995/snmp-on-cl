#!/usr/bin/env bash

# leaf01
sudo docker exec -it librenms /opt/librenms/addhost.php 192.168.200.11 neteng v2c
sleep 2
# leaf02
sudo docker exec -it librenms /opt/librenms/addhost.php 192.168.200.12 neteng v2c
sleep 2
# leaf03
sudo docker exec -it librenms /opt/librenms/addhost.php 192.168.200.13 neteng v2c
sleep 2
# leaf04
sudo docker exec -it librenms /opt/librenms/addhost.php 192.168.200.14 neteng v2c
sleep 2
# spine01
sudo docker exec -it librenms /opt/librenms/addhost.php 192.168.200.21 neteng v2c
sleep 2
# spine02
sudo docker exec -it librenms /opt/librenms/addhost.php 192.168.200.22 neteng v2c
sleep 2
# spine03
sudo docker exec -it librenms /opt/librenms/addhost.php 192.168.200.23 neteng v2c
sleep 2
# spine04
sudo docker exec -it librenms /opt/librenms/addhost.php 192.168.200.24 neteng v2c
sleep 2
# fw01
sudo docker exec -it librenms /opt/librenms/addhost.php 192.168.200.61 neteng v2c
sleep 2
# fw02
sudo docker exec -it librenms /opt/librenms/addhost.php 192.168.200.62 neteng v2c
sleep 2
# border01
sudo docker exec -it librenms /opt/librenms/addhost.php 192.168.200.63 neteng v2c
sleep 2
# border02
sudo docker exec -it librenms /opt/librenms/addhost.php 192.168.200.64 neteng v2c
sleep 2
#
echo "Please give librenms 10 minutes to begin polling all of the above devices"
