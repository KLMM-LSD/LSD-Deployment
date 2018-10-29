#Description: This script installs docker and starts a mariadb instance.
#Author: Kristjan Reinert Gásadal (Huldumadurin)

#Pointless comment

#Importing public keys from github, Developers
sudo ssh-import-id gh:KongBoje gh:LasseHansenCPH gh:MartinH5 gh:Huldumadurin
#Importing public keys from github, Operators (TODO: ADD USERNAMES!!!)
#sudo ssh-import-id

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
docker run --name my-mariadb -e MYSQL_ROOT_PASSWORD=$DBPASSWORD -d mariadb:latest