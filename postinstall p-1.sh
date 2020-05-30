#!/usr/bin/env bash
say() {
    echo -e "\e[1m[ POST INSTALL ] - $@"
}

DIRETORIO_DOWNLOADS="$HOME/Downloads/programas"

PROGRAMAS_PARA_INSTALAR=(
  git
  zsh
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
sudo apt install curl -y
# ---------------------------------------------------------------------- #

# ----------------------------- EXECUÇÃO ----------------------------- #
## Atualizando o repositório depois da adição de novos repositórios ##

## Download e instalaçao de programas externos ##
mkdir   "$DIRETORIO_DOWNLOADS"
cd "$DIRETORIO_DOWNLOADS"
sudo curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
sudo curl -L "https://github.com/docker/compose/releases/download/1.25.5/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
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

