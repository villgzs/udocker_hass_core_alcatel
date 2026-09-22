#!/data/data/com.termux/files/usr/bin/bash
echo 'deleted' >> ./haconfig/home-assistant.log
rm ./haconfig/home-assistant.oldlog
cp ./haconfig/home-assistant.log ./haconfig/home-assistant.oldlog
echo '.' > ./haconfig/home-assistant.log