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

     printf ${GREEN}"[+] directory-list-2.3-medium.txt\n"
     curl https://raw.githubusercontent.com/daviddias/node-dirbuster/master/lists/directory-list-2.3-medium.txt > $TARGET/wordlist/directory-list-2.3-medium.txt 2>&1

     printf ${GREEN}"[+] password.lst\n"
     curl https://raw.githubusercontent.com/piyushcse29/john-the-ripper/master/run/password.lst > $TARGET/wordlist/password.lst 2>&1

     printf ${GREEN}"[+] nmap.lst\n"
     curl https://raw.githubusercontent.com/drtychai/wordlists/master/nmap.lst > $TARGET/wordlist/nmap.lst 2>&1
}

software() {
     printf "\n${YELLOW}[*]${BLUE} Software ---------------------------------\n"

     printf ${GREEN}"[+] Sublime-text\n"
     wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add - >/dev/null 2>&1
     echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list >/dev/null 2>&1
     sudo apt update >/dev/null 2>&1
     sudo apt -y install sublime-text >/dev/null 2>&1

     printf ${GREEN}"[+] Obsidian\n"
     wget https://github.com/obsidianmd/obsidian-releases/releases/download/v1.1.9/obsidian_1.1.9_amd64.deb >/dev/null 2>&1
     sudo apt install ./obsidian_1.1.9_amd64.deb >/dev/null 2>&1
     rm obsidian_1.1.9_amd64.deb

     printf ${GREEN}"[+] Chrome\n"
     wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb >/dev/null 2>&1
     sudo apt -y install ./google-chrome-stable_current_amd64.deb >/dev/null 2>&1
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

     printf ${GREEN}"[+] Chrome Extension: Bitwarden\n"
     sudo touch /opt/google/chrome/extensions/nngceckbapebfimnlniiiahkandclblb.json
     sudo chmod 646 /opt/google/chrome/extensions/nngceckbapebfimnlniiiahkandclblb.json
     sudo echo '{
  "external_update_url": "https://clients2.google.com/service/update2/crx"
}' > /opt/google/chrome/extensions/nngceckbapebfimnlniiiahkandclblb.json

     printf ${GREEN}"[+] terminator\n"
     sudo apt install terminator -y >/dev/null 2>&1

     printf ${GREEN}"[+] sshuttle\n"
     sudo apt install sshuttle -y >/dev/null 2>&1
     
     printf ${GREEN}"[+] nuclei\n"
     sudo apt install nuclei -y >/dev/null 2>&1

     if ! command -v go &> /dev/null; then
          printf ${RED}"[x] Missing Go, skipping install of Fuff, Chisel and Nuclei...\n"
     else
          if ! command -v ffuf &> /dev/null; then
               printf ${GREEN}"[+] ffuf\n"
               go install github.com/ffuf/ffuf@latest >/dev/null 2>&1
          else
               printf ${ITALIC_LIGHT_CYAN}"[~] ffuf is already installed, skipping...\n"
          fi

          if ! command -v chisel &> /dev/null; then
               printf ${GREEN}"[+] chisel\n"
               go install github.com/jpillora/chisel@latest >/dev/null 2>&1
          else
               printf ${ITALIC_LIGHT_CYAN}"[~] chisel is already installed, skipping...\n"
          fi
     fi

     if ! command -v pip &> /dev/null; then
          printf ${RED}"[x] Missing Pip, skipping install of PwnCat...\n"
     else
          if ! command -v pwncat-cs &> /dev/null; then
               printf ${GREEN}"[+] pwncat-cs\n"
               sudo pip install pwncat-cs >/dev/null 2>&1
          else
               printf ${ITALIC_LIGHT_CYAN}"[~] pwncat-cs is already installed, skipping...\n"
          fi
     fi
}

tools() {
     printf "\n${YELLOW}[*]${BLUE} Tools ------------------------------------\n"
     mkdir tools >/dev/null 2>&1

     printf ${GREEN}"[+] linPeas.sh\n"
     wget -q -O - https://github.com/carlospolop/PEASS-ng/releases/download/20230129/linpeas.sh > $TARGET/tools/linPeas.sh 2>&1
     chmod +x $TARGET/tools/linPeas.sh

     printf ${GREEN}"[+] winPeas.bat\n"
     wget -q -O - https://github.com/carlospolop/PEASS-ng/releases/download/20230129/winPEAS.bat > $TARGET/tools/winPeas.bat 2>&1

     printf ${GREEN}"[+] LinEnum.sh\n"
     curl https://raw.githubusercontent.com/rebootuser/LinEnum/master/LinEnum.sh > $TARGET/tools/LinEnum.sh 2>&1
     chmod +x $TARGET/tools/LinEnum.sh

     printf ${GREEN}"[+] linux-exploit-suggester.sh\n"
     curl https://raw.githubusercontent.com/The-Z-Labs/linux-exploit-suggester/master/linux-exploit-suggester.sh > $TARGET/tools/linux-exploit-suggester.sh 2>&1
     chmod +x $TARGET/tools/linux-exploit-suggester.sh

     printf ${GREEN}"[+] mimikatz.exe\n"
     wget -q -O - https://github.com/ParrotSec/mimikatz/blob/master/Win32/mimikatz.exe > $TARGET/tools/mimikatz.exe 2>&1
}

binary() {
     printf "\n${YELLOW}[*]${BLUE} Binary -----------------------------------\n"
     mkdir binary >/dev/null 2>&1

     printf ${GREEN}"[+] nmap\n"
     wget -q -O - https://github.com/andrew-d/static-binaries/raw/master/binaries/linux/x86_64/nmap > $TARGET/binary/nmap
     chmod +x $TARGET/binary/nmap
}

aliascmd() {
     printf "\n${YELLOW}[*]${BLUE} Alias ------------------------------------\n"

     FILE=~/.bash_aliases
     if [ -f "$FILE" ]; then
          sed -i '/# Alias created by PenTools/,/# https:\/\/github.com\/d3vyce\/pentools/d' ~/.bash_aliases
     fi

     echo "
# Alias created by PenTools" >> ~/.bash_aliases

     printf ${GREEN}"[+] sudo filesrv\n"
     echo "alias filesrv='sudo python3 -m http.server 80 --directory ${TARGET}'" >> ~/.bash_aliases

     printf ${GREEN}"[+] sublime\n"
     echo "alias sublime='/opt/sublime_text/sublime_text'" >> ~/.bash_aliases

     printf ${GREEN}"[+] pwncat [port]\n"
     echo "alias sublime='sudo pwncat-cs --listen --port '" >> ~/.bash_aliases

     printf ${GREEN}"[+] openvpn [file.ovpn]\n"
     echo "alias sublime='sudo openvpn '" >> ~/.bash_aliases

     echo "# https://github.com/d3vyce/pentools" >> ~/.bash_aliases
     source ~/.bash_aliases 
}

printf "${YELLOW}
 ---------------------------------------------
      ____           ______            __    
     / __ \___  ____/_  __/___  ____  / /____
    / /_/ / _ \/ __ \/ / / __ \/ __ \/ / ___/
   / ____/  __/ / / / / / /_/ / /_/ / (__  ) 
  /_/    \___/_/ /_/_/  \____/\____/_/____/  
                                            
 ---------------------------------------------
 v1.1 - ${ITALIC}https://github.com/d3vyce/pentools \n
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

read -p "${BLUE}Do you want to generate SSH key? (y/n) [${YELLOW}y${BLUE}]: ${YELLOW}" SSH_GEN
SSH_GEN=${SSH_GEN:-y}

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

if [ SSH_GEN -eq 'y' ]; then
     printf ${GREEN}"[+] Creation of your ssh key pair...\n"
     ssh-keygen -q -t rsa -N '' -f ~/.ssh/id_rsa >/dev/null 2>&1
     printf "${ITALIC_LIGHT_CYAN}"
     cat ~/.ssh/id_rsa.pub
fi