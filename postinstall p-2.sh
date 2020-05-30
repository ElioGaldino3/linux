#!/usr/bin/env bash
say() {
    echo -e "\e[1m[ POST INSTALL ] - $@"
}

asdf plugin-add flutter
asdf plugin-add dart https://github.com/patoconnor43/asdf-dart.git
asdf plugin-add nodejs https://github.com/asdf-vm/asdf-nodejs.git

bash ~/.asdf/plugins/nodejs/bin/import-release-team-keyring

asdf install flutter 1.17.2
asdf install dart 2.8.2
asdf install nodejs 12.17.0
asdf global dart 2.8.2
asdf global flutter 1.17.2
asdf global nodejs 12.17.0

sudo iptables -I INPUT -p tcp --dport 4565 -j ACCEPT
sudo iptables -I INPUT -p tcp --dport 5555 -j ACCEPT
sudo iptables -I INPUT -p tcp --dport 3000 -j ACCEPT
sudo iptables -I INPUT -p tcp --dport 5000 -j ACCEPT
sudo iptables -I INPUT -p tcp --dport 2525 -j ACCEPT