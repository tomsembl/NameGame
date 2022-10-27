#create systemd startup service
#or copy from repo
sudo cp ~/src/namegame/scripts/namegame.service /etc/systemd/system/namegame.service

#enable the service
sudo /bin/systemctl enable namegame.service
sudo /bin/systemctl start namegame.service
sudo /bin/systemctl status namegame.service

#to stop the service
#sudo systemctl stop namegame.service
