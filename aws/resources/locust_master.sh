#!/bin/bash
sudo yum install docker -y
sudo service docker start
sudo docker pull locustio/locust
sudo amazon-linux-extras install python3 -y
sudo pip3 install --upgrade pip
wget ${locustfile_web_link}
sudo mkdir /mnt/locust
sudo mv locustfile.py /mnt/locust
sudo docker run -d -p 8089:8089 -v /mnt/locust:/mnt/locust locustio/locust -f /mnt/locust/locustfile.py --master -H "http://$(hostname).com:8089"