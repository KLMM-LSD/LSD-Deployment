# LSD-Deployment
Diagrams, configuration and utilities to ease deployment of HackerNews.

## Credential Downloader
run: credential-download/copy-ssh-keys.sh
A simple utility that goes through a predefined list of github usernames and adds their public keys to the current machine's ~/.ssh/authorized_keys.


## Droplets **_TODO:_ Write authentication guide. (DOToken etc.)**
A collection of scripts used to spin up the various nodes that make up Hackernews.
All require ssh and digitalocean authentication to be set up.

### Database
Run startDroplet.sh to start a digitalocean droplet

### SSH keys
SSH public keys for all maintainers are automatically added to the droplet by our deploy script, so should be registered with your github account:

#### This goes in ~/.bashrc
eval "$(ssh-agent)";
ssh-add ~/.ssh/id_rsa;

#### Run this:
ssh-keygen -t rsa -b 4096 -C "your_email@example.com"

#### Add output of this to your github account as ssh public key (give your machine a recognizable name)
cat ~/.ssh/id_rsa.pub

#### Test if setup correctly:
ssh -T git@github.com

=======

