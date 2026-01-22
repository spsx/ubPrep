#! /bin/bash
cd ~
echo "getting table stakes..."
sudo apt install nala -y

echo "updating..."
sudo nala update && sudo nala upgrade -y

echo "get the first stuffs"
sudo nala install curl git perl ssh net-tools -y

echo "add some repos"
#webmin repo
sudo curl -o setup-repos.sh https://raw.githubusercontent.com/webmin/webmin/master/setup-repos.sh
sudo sh setup-repos.sh
#fastfetch repo
sudo add-apt-repository ppa:zhangsongcui3371/fastfetch
#nodejs repo
if [ ! -f "/etc/apt/keyrings/nodesource.gpg" ]; then
    curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg
fi
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -

echo "get the other stuff"
sudo nala install gcc make bzip2 btop g++ python3-pip python3-opencv python3-websockets python3-paho-mqtt cmake nodejs webmin mosquitto -y

#setup some dirs
#echo "setup patrol and cyclops dirs"
#sudo mkdir -p /var/nfs/cyclops
#sudo mkdir -m 777 -p /home/synergy/Documents/{PatrolPics,PatrolVids,Panos}

#npm pm2
echo "it's pm2 time"
sudo npm install -g pm2
pm2 startup
sudo env PATH=$PATH:/usr/bin /usr/lib/node_modules/pm2/bin/pm2 startup systemd -u synergy --hp /home/synergy
pm2 status