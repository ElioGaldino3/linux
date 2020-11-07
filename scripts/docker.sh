#!/bin/bash
say() {
    echo -e "\e[1m[ POST INSTALL ] - $@"
}
#Remove docker anterior
sudo apt-get remove docker docker-engine docker.io containerd runc -y

#Instalar pacotes
sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common

#Add Docker’s GPG Key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88

#Adiciona o docker no repositório
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"

#Instala o docker
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io

#Docker group
sudo groupadd docker
sudo usermod -aG docker $USER