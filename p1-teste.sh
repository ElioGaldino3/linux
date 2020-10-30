#!/bin/bash
say() {
    echo -e "\e[1m[ POST INSTALL ] - $@"
}
chmod 700 ./scripts/android_studio.sh
say "Configurando Android Studio"
./scripts/android_studio.sh /dev/null 2>&1