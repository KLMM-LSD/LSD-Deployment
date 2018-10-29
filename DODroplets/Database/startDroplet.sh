echo "Sourcing secrets from ~/.digitalocean.secret"
source ~/.digitalocean.secret

echo "Bringing up droplet without provisioning"
vagrant up

echo "Running setupScript to provision droplet"
vagrant ssh -c "echo 'Running setupScript.sh'
  cd /vagrant
  sudo chmod +x setupScript.sh
  bash setupScript.sh"