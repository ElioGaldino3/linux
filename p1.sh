#!/bin/bash
say() {
    echo -e "\e[1m[ POST INSTALL ] - $@"
}
## DOWNLOADS
URL_CHROME="chrome link"

DIRETORIO_DOWNLOADS="$HOME/Downloads/programas"

PROGRAMAS_PARA_INSTALAR=(
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
mkdir"$DIRETORIO_DOWNLOADS"

wget -c "$URL_CHROME"             -P "$DIRETORIO_DOWNLOADS"


## Instalando pacotes .deb baixados na sessão anterior ##
say "Instalando os Pacotes Debian"
sudo dpkg -i $DIRETORIO_DOWNLOADS/*.deb



say "Fix Broken Install"
sudo apt --fix-broken install
# Instalar programas no apt

sudo apt --fix-broken install

## Configurar arquivos de scripts
chmod 700 ./scripts/docker.sh
chmod 700 ./scripts/android_studio.sh

## Rodando Scripts
say "Install Docker"
./scripts/docker.sh /dev/null 2>&1
say "Configurando Android Studio"
./scripts/android_studio.sh /dev/null 2>&1



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

