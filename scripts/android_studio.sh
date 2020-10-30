#!/bin/bash

#Enviroment
echo 'export JAVA_HOME="/home/eliogaldino/Development/android-studio/jre"' >> ~/.profile
export JAVA_HOME="/home/eliogaldino/Development/android-studio/jre"
echo 'export PATH="$PATH:/home/eliogaldino/Android/Sdk/platform-tools"' >> ~/.profile
echo 'export PATH="$PATH:/home/eliogaldino/Android/Sdk/tools"' >> ~/.profile
echo 'export PATH="$PATH:/home/eliogaldino/Android/Sdk/tools/bin"' >> ~/.profile
export PATH="$PATH:/home/eliogaldino/Android/Sdk/tools/bin"

#Aceitar as licenças do SDK
yes | sdkmanager