tmux new-session -A -s namegame #-d
# tmux send-keys -t namegame 'cd /home/ubuntu/src/namegame' C-m
# tmux send-keys -t namegame 'cp /home/ubuntu/src/namegame/scripts/b.py /home/ubuntu/src/b.py' C-m
# tmux send-keys -t namegame 'cp /home/ubuntu/src/namegame/scripts/a.py /home/ubuntu/src/a.py' C-m
# tmux send-keys -t namegame '/home/ubuntu/src/b.py' C-m
sudo cp /home/ubuntu/src/namegame/scripts/b.py /home/ubuntu/src/b.py
sudo cp /home/ubuntu/src/namegame/scripts/a.py /home/ubuntu/src/a.py
sudo bash /home/ubuntu/src/b.py