timedatectl set-timezone Australia/West
sudo apt update
sudo apt upgrade -y
#sudo apt install software-properties-common
#sudo add-apt-repository ppa:deadsnakes/ppa
sudo apt install python3.11
sudo apt-get install python3.11-dev
sudo apt install python3-pip
#sudo apt install libffi-dev

python3.11 -m pip install Flask --upgrade pip
python3.11 -m pip install flask-socketio
python3.11 -m pip install gevent-websocket
python3.11 -m pip install eventlet


mkdir src
cd src
git clone https://github.com/tomsembl/namegame
cd namegame
