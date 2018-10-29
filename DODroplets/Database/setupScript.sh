#!/usr/bin/env bash
#Description: This script installs docker and starts a mariadb instance.
#Author: Kristjan Reinert Gásadal (Huldumadurin)

#Importing public keys from github, Developers
sudo ssh-import-id gh:KongBoje gh:LasseHansenCPH gh:MartinH5 gh:Huldumadurin
ssh-import-id gh:KongBoje gh:LasseHansenCPH gh:MartinH5 gh:Huldumadurin

#Resetting ssh folder permissions according to openssh manual
#chmod 700 /root/.ssh
#chmod 600 /root/.ssh/authorized_keys
#restorecon -R -v /root/.ssh

#Importing public keys from github, Operators (TODO: ADD USERNAMES!!!)
sudo ssh-import-id gh:pwestdk gh:Kvetter gh:LalaDK gh:philliphb

#This is how DigitalOcean recommends Docker be installed.
# curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

# sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

#sudo apt-get update

# apt-cache policy docker-ce

#Output of apt-cache policy docker-ce

# sudo apt-get install -y docker-ce

#check that docker service is running
# sudo systemctl status docker

#Fetch public keys for organization
#git clone git@github.com:KLMM-LSD/LSD-Deployment.git
#chmod +xLSD-Deployment/credential-download/copy-ssh-keys.sh 
#LSD-Deployment/credential-download/copy-ssh-keys.sh
#rm -r LSD-Deployment

#Fetch DB credentials from github private repository
ssh-keyscan github.com >> ~/.ssh/known_hosts
git clone git@github.com:huldumadurin/KLMMDeployCredentials.git
chmod +x KLMMDeployCredentials/db-credentials.sh
. db-credentials.sh

#Start mariadb docker 
#docker run --name my-mariadb -e MYSQL_ROOT_PASSWORD=$DBPASSWORD -d mariadb:latest > mariadb.log 2>&1
#docker run --name my-mariadb -e MYSQL_ROOT_PASSWORD=$DBPASSWORD --detach mariadb:latest

#Installing MariaDB
sudo apt-get install software-properties-common 
sudo apt-key adv --recv-keys -keyserver hkp://keyserver.ubuntu.com:80 0xcbcb082a1bb943db 
sudo add-apt-repository 'deb http://mirror.jmu.edu/pub/mariadb/repo/10.1/ubuntu xenial main'

sudo apt-get update
sudo apt-get -y upgrade

sudo apt-get install -y mariadb-server

echo "Changing MariaDB root password."
sudo mysql -u root -p"" -e "UPDATE mysql.user SET Password = PASSWORD('$DBPASSWORD') WHERE User = 'root'"
echo "Flushing MariaDB privileges"
sudo mysql -u root -p"$DBPASSWORD" -e "FLUSH PRIVILEGES"

#Installing JDK
sudo apt-get install -y default-jre

#Installing jq for querying JSON
sudo apt-get install --yes jq


#Deploying backend .war file:
mkdir /vagrant/deployments
cd /vagrant/deployments/
#Download .war from LSD-Backend:latest
curl -O $(curl -sL https://api.github.com/repos/KLMM-LSD/LSD-Backend/releases/latest | jq -r '.assets[].browser_download_url')

#Start Wildfly docker
#docker run -p 8080:8080 -p 9990:9990 -v /vagrant/deployments:/opt/jboss/wildfly/standalone/deployments/ -d /bin/bash -c "/opt/jboss/wildfly/bin/add-user.sh $WILDFLYUSERNAME $WILDFLYPASSWORD --silent; jboss/wildfly /opt/jboss/wildfly/bin/standalone.sh -bmanagement 0.0.0.0;"

#Installing wildfly directly to ubuntu
cd /opt
wget http://download.jboss.org/wildfly/10.0.0.Final/wildfly-10.0.0.Final.tar.gz
tar -xvzf wildfly-10.0.0.Final.tar.gz
mv wildfly-10.0.0.Final wildfly
chmod -R 755 wildfly
cd wildfly/bin

echo "Adding user named $WILDFLYUSERNAME"
./add-user.sh "$WILDFLYUSERNAME" "$WILDFLYPASSWORD"
nohup ./standalone.sh -b 0.0.0.0 > /vagrant/wildfly.log 2>&1 &





