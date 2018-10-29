#Description: This script installs docker and starts a mariadb instance.
#Author: Kristjan Reinert Gásadal (Huldumadurin)

#Importing public keys from github, Developers
sudo ssh-import-id gh:KongBoje gh:LasseHansenCPH gh:MartinH5 gh:Huldumadurin
ssh-import-id gh:KongBoje gh:LasseHansenCPH gh:MartinH5 gh:Huldumadurin

#Resetting ssh folder permissions according to openssh manual
chmod 700 /root/.ssh
chmod 600 /root/.ssh/authorized_keys
restorecon -R -v /root/.ssh

#Importing public keys from github, Operators (TODO: ADD USERNAMES!!!)
#sudo ssh-import-id

#Installing jq for querying JSON
sudo apt-get install --yes jq

#This is how DigitalOcean recommends Docker be installed.
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

sudo apt-get update

apt-cache policy docker-ce

Output of apt-cache policy docker-ce

sudo apt-get install -y docker-ce

#check that docker service is running
sudo systemctl status docker

#Fetch public keys for organization
#git clone git@github.com:KLMM-LSD/LSD-Deployment.git
#chmod +xLSD-Deployment/credential-download/copy-ssh-keys.sh 
#LSD-Deployment/credential-download/copy-ssh-keys.sh
#rm -r LSD-Deployment

#Fetch DB credentials from github private repository
git clone git@github.com:huldumadurin/KLMMDeployCredentials.git
chmod +x KLMMDeployCredentials/db-credentials.sh
source db-credentials.sh

#Start mariadb docker 
#docker run --name my-mariadb -e MYSQL_ROOT_PASSWORD=$DBPASSWORD -d mariadb:latest > mariadb.log 2>&1
docker run --name my-mariadb -e MYSQL_ROOT_PASSWORD=$DBPASSWORD --detach mariadb:latest


#Go to deployments folder:
mkdir /vagrant/deployments
cd /vagrant/deployments/
#Download .war from LSD-Backend:latest
curl -O $(curl -sL https://api.github.com/repos/KLMM-LSD/LSD-Backend/releases/latest | jq -r '.assets[].browser_download_url')

#Start Wildfly docker
docker run -p 8080:8080 -p 9990:9990 -v /vagrant/deployments:/opt/jboss/wildfly/standalone/deployments/ -d /bin/bash -c "/opt/jboss/wildfly/bin/add-user.sh $WILDFLYUSERNAME $WILDFLYPASSWORD --silent; jboss/wildfly /opt/jboss/wildfly/bin/standalone.sh -bmanagement 0.0.0.0;"








