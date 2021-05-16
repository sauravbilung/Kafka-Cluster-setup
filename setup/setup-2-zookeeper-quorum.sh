#!/bin/bash
# create data dictionary for zookeeper
sudo mkdir -p /data/zookeeper
sudo chown -R ubuntu:ubuntu /data/
# declare the server's identity
echo "1" > /data/zookeeper/myid # Replace 1,2,3 for each servers.
# edit the zookeeper settings
rm /home/ubuntu/kafka/config/zookeeper.properties
nano /home/ubuntu/kafka/config/zookeeper.properties
# restart the zookeeper service
sudo service zookeeper stop
sudo service zookeeper start
# observe the logs - need to do this on every machine
cat /home/ubuntu/kafka/logs/zookeeper.out | head -100
nc -vz localhost 2181
nc -vz localhost 2888
nc -vz localhost 3888
echo "ruok" | nc localhost 2181 ; echo
# run the below command from any instance to check if zookeeper is running successfully or not.
echo "ruok" | nc zookeeper1 2181 ; echo
echo "ruok" | nc zookeeper2 2181 ; echo
echo "ruok" | nc zookeeper3 2181 ; echo
echo "stat" | nc localhost 2181 ; echo
# run the below command to check the status of the instances in the quorom.
# We can get who is the leader information from here as well.
echo "stat" | nc zookeeper1 2181 ; echo
echo "stat" | nc zookeeper2 2181 ; echo
echo "stat" | nc zookeeper3 2181 ; echo
bin/zookeeper-shell.sh localhost:2181
# not happy
ls /
