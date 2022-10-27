tmux new-session -s namegame -d
tmux send-keys -t namegame 'cd ~/src/namegame' C-m
tmux send-keys -t namegame 'git pull --ff' C-m
tmux send-keys -t namegame 'python3.11 app.py' C-m
tmux attach-session -t namegame
