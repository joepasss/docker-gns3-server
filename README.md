# forked from "jsimonetti/gns3-server"
# jsimonetti/gns3-server
[![](https://images.microbadger.com/badges/version/jsimonetti/gns3-server.svg)](https://microbadger.com/images/jsimonetti/gns3-server "Get your own version badge on microbadger.com")[![](https://images.microbadger.com/badges/image/jsimonetti/gns3-server.svg)](https://microbadger.com/images/jsimonetti/gns3-server "Get your own image badge on microbadger.com")[![](https://img.shields.io/docker/pulls/jsimonetti/gns3-server.svg)]()[![](https://img.shields.io/docker/stars/jsimonetti/gns3-server.svg)]()

[jsimonetti/gns3-server(github)](https://github.com/jsimonetti/docker-gns3-server)

[jsimonetti/gns3-server(dockerhub)](https://hub.docker.com/r/jsimonetti/gns3-server)

<br/>

---

<br/>

# joepasss/gns3-server

* Add IOU compatibility

## Usage

```
docker run \
    --rm -d \
    --name gns3 \
    --net=host --privileged \
    -e BRIDGE_ADDRESS="172.21.1.1/24" \
    -v <data path>:/data \
    joepasss/gns3-server:latest
```

## Parameters

* `-v /data` - Path to persistant data
* `-e BRIDGE_ADDRESS="172.21.1.1/24"` - Configure the internal NAT network bridge for GNS3

## enable IOURC
1. generate iourc
``` bash
# enter docker container
# docker exec -it <name> bash
# you can check container name with "docker ps" command
docker exec -it gns3 bash

# move to persistant data dir
cd /data
# get python script that generates IOURC
wget http://www.ipvanquish.com/download/CiscoIOUKeygen3f.py
# start python scripts
/opt/python3-11.9/bin/python3 ./CiscoIOUKeygen3f.py

# and you will get this output
*********************************************************************
Cisco IOU License Generator - Kal 2011, python port of 2006 C version
hostid=00000000, hostname=my_host, ioukey=000000

Add the following text to ~/.iourc:
[license]
my_host = 0000000000000000;

^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Already copy to the file iourc.txt
 
You can disable the phone home feature with something like:
 echo '127.0.0.127 xml.cisco.com' >> /etc/hosts
```

2. copy & paste iourc
* in `opt/python3-11.9/bin/python3 ./CiscoIOUKeygen3f.py` you will get iourc text. then copy and paste in your GNS3 client configuration
    <img width="993" alt="스크린샷 2025-05-23 09 15 51" src="https://github.com/user-attachments/assets/40458cda-7082-4eb6-8ea7-3c9eaf80ac5a" />
* or you can see with `cat /data/iourc.txt` command

## GNS3 gui
[GNS3/gns3-gui](https://github.com/GNS3/gns3-gui)

[GNS3/gns3-gui releases](https://github.com/GNS3/gns3-gui/releases)

<br/>

---

<br />

## TODO
* add iourc generator
* optimize docker image
