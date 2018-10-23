# LSD-Deployment
Diagrams, configuration and utilities to ease deployment of HackerNews.

## Credential Downloader
run: credential-download/copy-ssh-keys.sh
A simple utility that goes through a predefined list of github usernames and adds their public keys to the current machine's ~/.ssh/authorized_keys.

## Droplets **_TODO:_ Write authentication guide. (DOToken etc.)**
A collection of scripts used to spin up the various nodes that make up Hackernews.
All require ssh and digitalocean authentication to be set up.

### Database
Run startDroplet.sh to start a digitalocean 

### 