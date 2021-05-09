#!/bin/bash
# Packages
sudo apt-get update && \
      sudo apt-get -y install wget ca-certificates zip net-tools vim nano tar netcat

# Java Open JDK 8
sudo apt-get -y install openjdk-8-jdk
java -version

# Disable RAM Swap - can set to 0 on certain Linux distro
sudo sysctl vm.swappiness=1
echo 'vm.swappiness=1' | sudo tee --append /etc/sysctl.conf

# Add hosts entries (mocking DNS) - put relevant IPs here
echo "172.31.9.1 kafka1
172.31.9.1 zookeeper1
172.31.19.230 kafka2
172.31.19.230 zookeeper2
172.31.35.20 kafka3
172.31.35.20 zookeeper3" | sudo tee --append /etc/hosts

# download Zookeeper and Kafka. Recommended is latest Kafka (0.10.2.1) and Scala 2.12
wget https://archive.apache.org/dist/kafka/0.10.2.1/kafka_2.12-0.10.2.1.tgz
tar -xvzf kafka_2.12-0.10.2.1.tgz
rm kafka_2.12-0.10.2.1.tgz
mv kafka_2.12-0.10.2.1 kafka
cd kafka/
# Zookeeper quickstart
cat config/zookeeper.properties
bin/zookeeper-server-start.sh config/zookeeper.properties
# binding to port 2181 -> you're good. Ctrl+C to exit

# Testing Zookeeper install
# Start Zookeeper in the background
# Below command will start zookeeper but it is not yet configured properly. It is just for testing.
bin/zookeeper-server-start.sh -daemon config/zookeeper.properties 
bin/zookeeper-shell.sh localhost:2181 # Starting zookeper. It will open if zookeeper has started successfully.
ls / # type in zookeeper. If output is [zookeeper] then is has started sucessfully.
# demonstrate the use of a 4 letter word
echo "ruok" | nc localhost 2181 ; echo # ctrl+c then run it, if output is "imok" the zookeeper running successfully.

# Till now we have run zookeeper in a different way.
# Below configurations will help to start,stop, etc the zookeeper in a more intuitive way.
# Install Zookeeper boot scripts. Go to zookeeper folder in the code repo and copy the zookeeper file
# in the /etc/init.d/ directory and then proceed as mentioned.
sudo nano /etc/init.d/zookeeper
sudo chmod +x /etc/init.d/zookeeper
sudo chown root:root /etc/init.d/zookeeper
# you can safely ignore the warning
sudo update-rc.d zookeeper defaults
# stop zookeeper
sudo service zookeeper stop
# verify it's stopped
nc -vz localhost 2181
# start zookeeper
sudo service zookeeper start
# verify it's started
nc -vz localhost 2181
echo "ruok" | nc localhost 2181 ; echo
# check the logs
cat logs/zookeeper.out
