#!/bin/bash

read -p "Please enter the IP address of this machine : " ip_address
sed -i "s/IP_ADDRESS_TO_REPLACE/$ip_address/g" master/load-balancer.conf

echo "-------------------------Intstalling docker-------------------------"
sudo apt update && sudo apt install -y docker.io docker-compose

echo "-----------------------cloning your site project------------------" 
git clone https://github.com/wiverson/maven-site-docs-example.git

echo "-------------------------Installing maven-----------------------"
apt install -y openjdk-17* maven

echo "------------------------Building maven project------------------"
cd maven-site-docs-example
mvn clean verify site
cd ..


#---Part for testing --------------------------------------------------------------
echo "Making the node change visible in front end"
#mkdir volume_workers copy index.html search and replace line 85
mkdir volume_worker1
mkdir volume_worker2
#---End of part to comment if not testing node change----------------------------------


echo "-------------------Building the master------------------------------"
docker build -t master master 

echo "---------------------Building the workers------------------------------"
docker build -t web -f web/dockerfile .

echo "--------------------docker composing---------------------------------"
docker-compose up -d


#---Part for testing --------------------------------------------------------------
cp -r  maven-site-docs-example/target/site/* volume_worker1/
cp -r  maven-site-docs-example/target/site/* volume_worker2/
sed -i "s|<h2>maven-site-docs-example</h2>|<h2>maven-site-node1</h2>|g" "volume_worker1/index.html"
sed -i "s|<h2>maven-site-docs-example</h2>|<h2>maven-site-node2</h2>|g" "volume_worker2/index.html"
