#!/bin/bash

DIRETORIO_DOWNLOADS="$HOME/Downloads/programas"

mkdir ~/Projetos
mkdir ~/.development

unzip ~/Downloads/*.tar.gz -d /home/eliogaldino/.development
unzip ~/Downloads/*.tar.xz -d /home/eliogaldino/.development

## DOWNLOADS
URL_CHROME="https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb"
URL_HYPER="https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb"
URL_CODE="https://az764295.vo.msecnd.net/stable/ea3859d4ba2f3e577a159bc91e3074c5d85c0523/code_1.52.1-1608136922_amd64.deb"
URL_DISCORD="https://dl.discordapp.net/apps/linux/0.0.13/discord-0.0.13.deb"

PROGRAMAS_PARA_INSTALAR=(
  git
  fonts-firacode
  zsh
  scrcpy
  flatpak
)

PROGRAMAS_PARA_INSTALAR_FLATPAK=(
  com.spotify.Client
  org.videolan.VLC
  com.obsproject.Studio
  org.qbittorrent.qBittorrent
  com.getpostman.Postman
)

## Removendo travas eventuais do apt ##
sudo rm /var/lib/dpkg/lock-frontend
sudo rm /var/cache/apt/archives/lock

## Atualizando o repositório ##
say "Atualizando Repositório"
sudo apt update -y

## Download e instalaçao de programas externos ##
mkdir"$DIRETORIO_DOWNLOADS"

wget -c "$URL_CHROME"             -P "$DIRETORIO_DOWNLOADS"
wget -c "$URL_DISCORD"             -P "$DIRETORIO_DOWNLOADS"
wget -c "$URL_HYPER"             -P "$DIRETORIO_DOWNLOADS"
wget -c "$URL_CODE"             -P "$DIRETORIO_DOWNLOADS"

sudo dpkg -i $DIRETORIO_DOWNLOADS/*.deb

sudo apt --fix-broken install
sudo apt --fix-broken install

for nome_do_programa in ${PROGRAMAS_PARA_INSTALAR[@]}; do
  if ! dpkg -l | grep -q $nome_do_programa; then # Só instala se já não estiver instalado
    sudo apt install "$nome_do_programa" -y
    say "[ INSTALANDO VIA APT ] - $nome_do_programa"
  else
    say "[ INSTALANDO VIA APT ] - [ JÁ INSTALADO ] - $nome_do_programa"
  fi
done

flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

for nome_do_programa in ${PROGRAMAS_PARA_INSTALAR_FLATPAK[@]}; do
  sudo flatpak install flathub "$nome_do_programa" -y
  say "[ INSTALANDO VIA FLATPAK ] - $nome_do_programa"
done

sudo apt update && sudo apt dist-upgrade -y
flatpak update -y
sudo apt autoclean -y
sudo apt autoremove -y

sudo apt-get remove docker docker-engine docker.io containerd runc -y
sudo apt-get install apt-transport-https ca-certificates curl gnupg-agent software-properties-common -y
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io
sudo groupadd docker
sudo usermod -aG docker $USER

update-alternatives --install /usr/bin/editor editor /usr/bin/code 0
sudo update-alternatives --install /usr/bin/x-terminal-emulator x-terminal-emulator /opt/Hyper/hyper 50

chsh -s $(which zsh)

sudo iptables -I INPUT -p tcp --dport 4565 -j ACCEPT
sudo iptables -I INPUT -p tcp --dport 5555 -j ACCEPT
sudo iptables -I INPUT -p tcp --dport 8080 -j ACCEPT
sudo iptables -I INPUT -p tcp --dport 8081 -j ACCEPT
sudo iptables -I INPUT -p tcp --dport 8082 -j ACCEPT
sudo iptables -I INPUT -p tcp --dport 8083 -j ACCEPT
sudo iptables -I INPUT -p tcp --dport 80 -j ACCEPT
sudo iptables -I INPUT -p tcp --dport 3333 -j ACCEPT
sudo iptables -I INPUT -p tcp --dport 3000 -j sACCEPT

git clone https://github.com/denysdovhan/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt" --depth=1
ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme" 