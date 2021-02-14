#!/bin/bash
sudo yum install docker -y
sudo service docker start
sudo docker pull locustio/locust:1.4.3
sudo amazon-linux-extras install python3 -y
sudo pip3 install --upgrade pip
wget ${locustfile_web_link}
sudo mkdir /mnt/locust
sudo mv locustfile.py /mnt/locust
sudo docker run -p 5557:5557 -p 8089:8089 -v /mnt/locust:/mnt/locust locustio/locust:1.4.3 -f /mnt/locust/locustfile.py --master -H "http://${mock_hostname}:80" --logfile=/tmp/locustfile.log