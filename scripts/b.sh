# tmux new-session -A -s namegame
# tmux send-keys -t namegame 'cd namegame' C-m
# tmux send-keys -t namegame 'git pull --ff' C-m
# tmux send-keys -t namegame 'espeak "0 0 0 Starting the NameGame and turning off the TV" 2>/dev/null' C-m
# tmux send-keys -t namegame 'echo "standby 0" | cec-client RPI -s -d 1' C-m
# tmux send-keys -t namegame 'echo 0 | sudo tee /sys/class/leds/led0/brightness' C-m
# tmux send-keys -t namegame 'echo 0 | sudo tee /sys/class/leds/led1/brightness' C-m
# tmux send-keys -t namegame 'python3.11 app.py' C-m

cd namegame
git pull --ff
espeak "0 0 0 Starting the NameGame and turning off the TV" 2>/dev/null
echo "standby 0" | cec-client RPI -s -d 1
/home/ubuntu/src/lan951x-led-ctl/lan951x-led-ctl --fdx=0 --lnk=0 --spd=0
echo 0 | sudo tee /sys/class/leds/led0/brightness
echo 0 | sudo tee /sys/class/leds/led1/brightness
python3.11 app.py
