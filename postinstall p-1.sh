#!/usr/bin/env bash
say() {
    echo -e "\e[1m[ POST INSTALL ] - $@"
}

cd

# ----------------------------- VARIÁVEIS ----------------------------- #
URL_4K_VIDEO_DOWNLOADER="https://dl.4kdownload.com/app/4kvideodownloader_4.9.2-1_amd64.deb"
URL_DOCKER1="https://download.docker.com/linux/ubuntu/dists/xenial/pool/stable/amd64/containerd.io_1.2.6-3_amd64.deb"
URL_DOCKER2="https://download.docker.com/linux/ubuntu/dists/bionic/pool/stable/amd64/docker-ce-cli_19.03.8~3-0~ubuntu-bionic_amd64.deb"
URL_DOCKER3="https://download.docker.com/linux/ubuntu/dists/bionic/pool/stable/amd64/docker-ce_19.03.8~3-0~ubuntu-bionic_amd64.deb"

DIRETORIO_DOWNLOADS="$HOME/Downloads/programas"

PROGRAMAS_PARA_INSTALAR=(
  git
  fonts-hack-ttf
  fonts-firacode
  zsh
)

PROGRAMAS_PARA_INSTALAR_FLATPAK=(
  com.discordapp.Discord
  com.spotify.Client
  org.videolan.VLC
  com.obsproject.Studio
  org.qbittorrent.qBittorrent
  com.getpostman.Postman
)

# ---------------------------------------------------------------------- #

# ----------------------------- REQUISITOS ----------------------------- #
say "Removendo travas eventuais do APT"
## Removendo travas eventuais do apt ##
sudo rm /var/lib/dpkg/lock-frontend
sudo rm /var/cache/apt/archives/lock

## Atualizando o repositório ##
say "Atualizando Repositório"
sudo apt update -y

# ---------------------------------------------------------------------- #

# ----------------------------- EXECUÇÃO ----------------------------- #
## Atualizando o repositório depois da adição de novos repositórios ##

## Download e instalaçao de programas externos ##
mkdir   "$DIRETORIO_DOWNLOADS"

say "Baixando 4K Video Downloader"
wget -c "$URL_4K_VIDEO_DOWNLOADER" -P "$DIRETORIO_DOWNLOADS"

say "Baixando DOCKER"
wget -c "$URL_DOCKER1"             -P "$DIRETORIO_DOWNLOADS"
wget -c "$URL_DOCKER2"             -P "$DIRETORIO_DOWNLOADS"
wget -c "$URL_DOCKER3"             -P "$DIRETORIO_DOWNLOADS"


## Instalando pacotes .deb baixados na sessão anterior ##
say "Instalando os Pacotes Debian"
sudo dpkg -i $DIRETORIO_DOWNLOADS/*.deb

say "Fix Broken Install"
sudo apt --fix-broken install
# Instalar programas no apt

sudo apt --fix-broken install

for nome_do_programa in ${PROGRAMAS_PARA_INSTALAR[@]}; do
  if ! dpkg -l | grep -q $nome_do_programa; then # Só instala se já não estiver instalado
    sudo apt install "$nome_do_programa" -y
    say "[ INSTALANDO VIA APT ] - $nome_do_programa"
  else
    say "[ INSTALANDO VIA APT ] - [ JÁ INSTALADO ] - $nome_do_programa"
  fi
done

say "ADICIONANDO FLATHUB NO FLATPAK"
sudo apt install flatpak
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# Instalar programas no flatpak
for nome_do_programa in ${PROGRAMAS_PARA_INSTALAR_FLATPAK[@]}; do
  sudo flatpak install flathub "$nome_do_programa" -y
  say "[ INSTALANDO VIA FLATPAK ] - $nome_do_programa"
done

# ---------------------------------------------------------------------- #
# -------------------------- INSTALAR O FLUTTER e PACOTES NPM -----#

# ---------------------------------------------------------------------- #
# ----------------------------- PÓS-INSTALAÇÃO ----------------------------- #
say "Pós Instalação"
## Finalização, atualização e limpeza##
sudo apt update && sudo apt dist-upgrade -y
flatpak update -y
sudo apt autoclean -y
sudo apt autoremove -y
# ----------------------------- CONFIGURAR O ZSH ----------------------------- #

