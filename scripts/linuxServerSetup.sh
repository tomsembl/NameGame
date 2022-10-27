timedatectl set-timezone Australia/West

sudo apt update
sudo apt upgrade -y

cd /usr/local/bin
sudo git clone https://github.com/tomsembl/namegame
cd namegame/scripts/
sudo chmod +x ./a.sh ./b.sh
sudo cp ./a.sh ../../a.sh
sudo cp ./b.sh ../../b.sh
cd ../..
sudo apt install python3.11
sudo python3.11 -m pip install Flask --upgrade pip
sudo python3.11 -m pip install flask-socketio
sudo python3.11 -m pip install gevent-websocket
sudo python3.11 -m pip install eventlet
sudo ./b.sh

#OLD
# sudo apt update
# sudo apt upgrade -y
# # sudo apt install software-properties-common
# # sudo add-apt-repository ppa:deadsnakes/ppa
# # sudo apt install libffi-dev
# sudo apt install python3.11
# sudo apt-get install python3.11-dev
# sudo apt install python3-pip

# python3.11 -m pip install Flask --upgrade pip
# python3.11 -m pip install flask-socketio
# python3.11 -m pip install gevent-websocket
# python3.11 -m pip install eventlet

#optionals

#HDMI CEC!
sudo apt install cec-utils
#Turn tv off:
    echo "standby 0" | cec-client RPI -s -d 1
#Turn tv on:
    echo "on 0" | cec-client RPI -s -d 1
#Make the RPI inactive source:
    echo "is" | cec-client RPI -s -d 1
#Make the RPI active source:
    echo "as" | cec-client RPI -s -d 1

#turn off leds
echo 0 | sudo tee /sys/class/leds/led0/brightness
echo 0 | sudo tee /sys/class/leds/led1/brightness

#turn off ethernet LEDs
#sudo ethtool -s eth0 led off

#general config
sudo raspi-config







