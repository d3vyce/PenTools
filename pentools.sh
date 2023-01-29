#!/bin/bash

C=$(printf '\033')
RED="${C}[1;31m"
YELLOW="${C}[1;33m"
BLUE="${C}[1;34m"
GREEN="${C}[1;32m"
ITALIC_LIGHT_CYAN="${C}[1;96m${C}[3m"
ITALIC="${C}[3m"

wordlist() {
     printf "\n${YELLOW}[*]${BLUE} Wordlist ---------------------------------\n"
     mkdir $TARGET/wordlist >/dev/null 2>&1

     printf ${GREEN}"[+] rockyou.txt\n"
     curl https://github.com/brannondorsey/naive-hashcat/releases/download/data/rockyou.txt > $TARGET/wordlist/rockyou.txt 2>&1

     printf ${GREEN}"[+] common.txt\n"
     curl http://ffuf.me/wordlist/common.txt > $TARGET/wordlist/common.txt 2>&1

     printf ${GREEN}"[+] subdomains.txt\n"
     curl http://ffuf.me/wordlist/subdomains.txt > $TARGET/wordlist/subdomains.txt 2>&1
}

software() {
     printf "\n${YELLOW}[*]${BLUE} Software ---------------------------------\n"

     printf ${GREEN}"[+] Sublime-text\n"
     wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add - >/dev/null 2>&1
     echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list >/dev/null 2>&1
     sudo apt -y install sublime-text >/dev/null 2>&1

     printf ${GREEN}"[+] Chrome\n"
     wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
     sudo apt -y install ./google-chrome-stable_current_amd64.deb
     rm google-chrome-stable_current_amd64.deb

     sudo mkdir /opt/google/chrome/extensions >/dev/null 2>&1
     printf ${GREEN}"[+] Chrome Extension: FoxyProxy\n"
     sudo touch /opt/google/chrome/extensions/gcknhkkoolaabfmlnjonogaaifnjlfnp.json
     sudo chmod 646 /opt/google/chrome/extensions/gcknhkkoolaabfmlnjonogaaifnjlfnp.json
     sudo echo '{
  "external_update_url": "https://clients2.google.com/service/update2/crx"
}' > /opt/google/chrome/extensions/gcknhkkoolaabfmlnjonogaaifnjlfnp.json

     printf ${GREEN}"[+] Chrome Extension: Dark Reader\n"
     sudo touch /opt/google/chrome/extensions/eimadpbcbfnmbkopoojfekhnkhdbieeh.json
     sudo chmod 646 /opt/google/chrome/extensions/eimadpbcbfnmbkopoojfekhnkhdbieeh.json
     sudo echo '{
  "external_update_url": "https://clients2.google.com/service/update2/crx"
}' > /opt/google/chrome/extensions/eimadpbcbfnmbkopoojfekhnkhdbieeh.json

     printf ${GREEN}"[+] Chrome Extension: WappAnalyser\n"
     sudo touch /opt/google/chrome/extensions/gppongmhjkpfnbhagpmjfkannfbllamg.json
     sudo chmod 646 /opt/google/chrome/extensions/gppongmhjkpfnbhagpmjfkannfbllamg.json
     sudo echo '{
  "external_update_url": "https://clients2.google.com/service/update2/crx"
}' > /opt/google/chrome/extensions/gppongmhjkpfnbhagpmjfkannfbllamg.json

     printf ${GREEN}"[+] Chrome Extension: Hack-Tools\n"
     sudo touch /opt/google/chrome/extensions/cmbndhnoonmghfofefkcccljbkdpamhi.json
     sudo chmod 646 /opt/google/chrome/extensions/cmbndhnoonmghfofefkcccljbkdpamhi.json
     sudo echo '{
  "external_update_url": "https://clients2.google.com/service/update2/crx"
}' > /opt/google/chrome/extensions/cmbndhnoonmghfofefkcccljbkdpamhi.json

     if ! command -v go &> /dev/null
     then
          printf ${RED}"[x] Missing Go, skiping install of Fuff...\n"
     else
          printf ${GREEN}"[+] ffuf\n"
          go install github.com/ffuf/ffuf@latest  
     fi

     if ! command -v pip &> /dev/null
     then
          printf ${RED}"[x] Missing Pip, skiping install of PwnCat...\n"
     else
          printf ${GREEN}"[+] pwncat-cs\n"
          pip install pwncat-cs
     fi
}

tools() {
     printf "\n${YELLOW}[*]${BLUE} Tools ------------------------------------\n"
     mkdir tools >/dev/null 2>&1
}

binary() {
     printf "\n${YELLOW}[*]${BLUE} Binary -----------------------------------\n"
     mkdir binary >/dev/null 2>&1
{
  "external_update_url": "https://clients2.google.com/service/update2/crx"
}
     printf ${GREEN}"[+] nmap\n"
     wget -q -O - https://github.com/andrew-d/static-binaries/raw/master/binaries/linux/x86_64/nmap > $TARGET/binary/nmap
     chmod +x $TARGET/binary/nmap
}

aliascmd() {
     printf "\n${YELLOW}[*]${BLUE} Alias ------------------------------------\n"

     echo "
# Alias created by PenTools
# https://github.com/d3vyce/pentools
" >> ~/.bashrc
     
     printf ${GREEN}"[+] sudo filesrv\n"
     echo "alias filesrv='sudo python3 -m http.server 80 --directory ${TARGET}'" >> ~/.bashrc

     printf ${GREEN}"[+] sublime\n"
     echo "alias sublime='sublime .'" >> ~/.bashrc

}

printf "${YELLOW}
 ---------------------------------------------
      ____           ______            __    
     / __ \___  ____/_  __/___  ____  / /____
    / /_/ / _ \/ __ \/ / / __ \/ __ \/ / ___/
   / ____/  __/ / / / / / /_/ / /_/ / (__  ) 
  /_/    \___/_/ /_/_/  \____/\____/_/____/  
                                            
 ---------------------------------------------
 v1.0 - ${ITALIC}https://github.com/d3vyce/pentools \n
"

printf ${YELLOW}"[*]${BLUE} What do you want to install?\n"
printf "${ITALIC_LIGHT_CYAN} 1: All\n"
printf "${ITALIC_LIGHT_CYAN} 2: Wordlist\n"
printf "${ITALIC_LIGHT_CYAN} 3: Software\n"
printf "${ITALIC_LIGHT_CYAN} 4: Tools\n"
printf "${ITALIC_LIGHT_CYAN} 5: Binary\n"
printf "${ITALIC_LIGHT_CYAN} 6: Alias\n"

read -p "${BLUE}Choice [${YELLOW}1${BLUE}]: ${YELLOW}" CHOICE
CHOICE=${CHOICE:-1}

PWD=$(pwd)
read -p "${BLUE}Target [${YELLOW}$PWD${BLUE}]: ${YELLOW}" TARGET
TARGET=${TARGET:-$PWD}

case $CHOICE in
     1)
          wordlist
          software
          tools
          binary
          aliascmd
          ;;
     2)
          wordlist
          ;;
     3)
          software
          ;;
     4)
          tools
          ;;
     5)
          binary
          ;;
     6)
          aliascmd
          ;;
     *)
          printf "${RED}[x] Select an option between 1 and 6"
          ;;
esac