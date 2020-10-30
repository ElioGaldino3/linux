#!/usr/bin/env bash
say() {
    echo -e "\e[1m[ POST INSTALL ] - $@"
}
cd

git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.7.8

. $HOME/.asdf/asdf.sh

asdf install flutter 1.12.13+hotfix.7-stable
asdf install dart 2.7.2
asdf global dart 2.7.2
asdf global flutter 1.12.13+hotfix.7-stable

mkdir ~/Development/pg-admin && mv docker-compose.yml ~/Development/pg-admin && cd ~/Development/pg-admin

sudo docker-compose up -d 

sudo iptables -I INPUT -p tcp --dport 4565 -j ACCEPT
sudo iptables -I INPUT -p tcp --dport 5555 -j ACCEPT