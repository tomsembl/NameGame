cd namegame
git pull --ff
espeak "0 0 0 Starting the NameGame and turning off the TV" 2>/dev/null
echo "standby 0" | cec-client RPI -s -d 1
echo 0 | sudo tee /sys/class/leds/led0/brightness
echo 0 | sudo tee /sys/class/leds/led1/brightness
python3.11 app.py