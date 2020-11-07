#!/bin/bash

#Enviroment
echo 'export JAVA_HOME="/home/eliogaldino/.development/android-studio/jre"' >> ~/.zshrc
export JAVA_HOME="/home/eliogaldino/.development/android-studio/jre"
echo 'export PATH="$PATH:/home/eliogaldino/Android/Sdk/platform-tools"' >> ~/.zshrc
echo 'export PATH="$PATH:/home/eliogaldino/Android/Sdk/tools"' >> ~/.zshrc
echo 'export PATH="$PATH:/home/eliogaldino/Android/Sdk/tools/bin"' >> ~/.zshrc
export PATH="$PATH:/home/eliogaldino/Android/Sdk/tools/bin"

#Aceitar as licenças do SDK
yes | sdkmanager