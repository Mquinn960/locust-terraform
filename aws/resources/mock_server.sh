#!/bin/bash
sudo yum install docker -y
sudo service docker start
sudo docker pull mockserver/mockserver
wget ${mockserver_init_web_link}
sudo mkdir /mnt/mockserver
sudo mv initializerJson.json /mnt/mockserver
sudo docker run -p 80:1080 -v /mnt/mockserver:/config -e MOCKSERVER_INITIALIZATION_JSON_PATH="/config/initializerJson.json" mockserver/mockserver