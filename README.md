# SNMP and CL

### Description:

This is a demo of LibreNMS and SNMP enabled on the cldemo2 Cumulus Linux topology

This demo will show the following information using SNMP:

Device Specific:

- Uptime
- Memory Utilization
- Storage Utilization
- Storage I/O
- CPU Utilization
- Fan Status
- Temp Sensors
- PSU Status
- Fan Speed
- Device Latency
- Device Health
- Device Logging

Per Interface:

- IPv4 / IPv6 - Total Bandwidth
- IPv4 / IPv6 Fragmentation
- IP Statistics - (Errors / Discards / Restablis)
- Traffic (standard SNMNP non \*Flow/IPFix)
- Interface up/down statistics

Routing Information:

- BGP Unnumbered (As of Cumulus Linux 4.3.x)

### Note:

1. First, create a "Cumulus In the Cloud" Reference Topology within Cumulus Air.

2. Configure the appropriate Production Ready Automation / Golden Turtle - this demo used the Symmetric EVPN configuration

3. SSH into the oob-mgmt-server and clone this repo with the following command:

```
git clone https://gitlab.com/nvidia-networking/systems-engineering/poc-support/snmp-and-cl
```

4. Change directories into the "automation" directory with the following command:

```
cd snmp-and-cl/automation
```

5. Run the playbook which will configure the oob-mgmt-server for Docker and the topology for SNMP:

```
ansible-playbook snmpandcl.yml
```

6. Change directories to the docker directory with the following command:

```
cd ../docker
```

7. Load the LibreNMS containers with the following command:

```
sudo docker-compose up -d
```

8. Finally, populate the LibreNMS application with the cldemo2 topology by running the following command:

```
./loadcldemo2.sh
```

It will take about 10 minutes for the various devices within LibreNMS to start reporting some level of data.

### Cumulus Air - External Service

## Description

In order to access the GUI through Cumulus Air, you need to create an external service that redirects HTTP to the LibreNMS port of 8000.

1. In Cumulus, click on the "Advanced" option on the right-hand pane

2. In Cumulus Air, you will need to set an HTTP Service under the "Advanced" options that will redirect HTTP traffic to port 8000 on the oob-mgmt-server. See the "documentation" directory for screenshots

### Helpful Docker Commands:

```
sudo docker-compose stop
sudo docker exec -it <container name> /bin/bash
sudo docker ps
sudo docker container stats
sudo docker image ls
sudo docker image rm <container ID>
```

Manually copy files from a local host to a container:

```
sudo docker cp cumulusmibs4.3/. librenms:/opt/librenms/mibs/cumulus
```

### LibreNMS Tips

LibreNMS login:

Username: librenms
Password: librenms

To see all of the devices being monitored, click the following on the top:

Devices > All Devices > Network

On the top bar, there are "Graphs" for the various elements, such as CPU, Load, Memory, Uptime, etc., that can be viewed on a per-device or global basis

To view per-interface counters, click the following:

"Click the specific switch" > Graphs > Netstats

One of the reasons to use a Production Ready Automation templates is to generate some traffic between the various switches in order to populate these graphs.

MIBS in Librenms:

/opt/librenms/mibs

Manual polling:

Hop into the librenms with the following command:

sudo docker exec -it librenms /bin/bash

This will place you in the /opt/librenms directory. From here, run the follwoing command:

./poller.php -h 192.168.200.11

You can specify specific modules using the following:

./poller.php -h 192.168.200.11 -m ports

The above is described here:

https://docs.librenms.org/Support/Poller%20Support/

### Errata:

Example SNMPWalk Command from the oob-mgmt-server to leaf02:

sudo snmpwalk -v2c -cneteng 192.168.200.12

To specify a specific OID, in this case BGP Unnumbered:

sudo snmpwalk -v2c -cneteng 192.168.200.12 1.3.6.1.4.1.40310.4

The MIB OID values can be found in /etc/snmp/snmpd.conf

Examples SNMP Translate command:

snmptranslate -On CUMULUS-BGPUN-MIB::bgpVersion
.1.3.6.1.4.1.40310.4.1

snmptranslate -On CUMULUS-BGPUN-MIB::bgpPeerIface
.1.3.6.1.4.1.40310.4.3.1.1.25

Container - LibreNMS

https://github.com/librenms/docker

Cumulus MIBs are located in:

/usr/share/snmp/mibs/

Downloaded SNMP MIBs are found in:

/var/lib/snmp/mibs
