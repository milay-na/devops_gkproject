#!/bin/bash

echo "Intstalling docker"
sudo apt update && sudo apt install -y docker.io


echo "cloning your site project" 
git clone git@github.com:wiverson/maven-site-docs-example.git

#---Begining of part to comment if not testing node change--------------------------------
echo "Making the node change visible in front end"
#mkdir volume_workers copy index.html search and replace line 85
mkdir volume_worker1
mkdir volume_worker2
cp /maven-site-docs-example/target/site/index.html volume_worker1
cp /maven-site-docs-example/target/site/index.html volume_worker2
sed -i "s|<h2>maven-site-docs-example</h2>|<h2>maven-site-node1</h2>|g" "volume_worker1/index.html"
sed -i "s|<h2>maven-site-docs-example</h2>|<h2>maven-site-node2</h2>|g" "volume_worker2/index.html"
#---End of part to comment if not testing node change----------------------------------


#echo "Building the master"
#docker build -t master master 

#echo "Building the workers"



