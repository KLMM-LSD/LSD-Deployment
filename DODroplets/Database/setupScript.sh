#Description: This script installs docker and starts a mariadb instance.
#Author: Kristjan Reinert Gásadal (Huldumadurin)

#This is how DigitalOcean recommends Docker be installed.
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

sudo apt-get update

apt-cache policy docker-ce

Output of apt-cache policy docker-ce

sudo apt-get install -y docker-ce

#check that docker service is running
sudo systemctl status docker

#Fetch credentials from github private repository
git clone git@github.com:huldumadurin/KLMMDeployCredentials.git
chmod +x KLMMDeployCredentials/db-credentials.sh
source db-credentials.sh

#Start mariadb docker 
docker run --name my-mariadb -e MYSQL_ROOT_PASSWORD=$DBPASSWORD -d mariadb:latest > mariadb.log 2>&1

#Viev output of running docker.
tail -f mariadb.log