sudo apt install software-properties-common
sudo add-apt-repository ppa:deadsnakes/ppa
sudo apt install python3.11
sudo apt install python3-pip
sudo apt-get install python3-dev
sudo apt install libffi-dev

python3.11 -m pip install Flask
python3.11 -m pip install flask-socketio
python3.11 -m pip install gevent-websocket

mkdir src
cd src
git clone https://github.com/tomsembl/namegame
cd namegame
