#create systemd startup service
#or copy from repo
sudo cp ~/src/namegame/scripts/namegame.service /etc/systemd/system/namegame.service

#enable the service
sudo systemctl enable namegame.service
sudo systemctl start namegame.service
sudo systemctl status namegame.service

#to stop the service
#sudo systemctl stop namegame.service