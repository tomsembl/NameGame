tmux new-session -A -s namegame #-d
tmux send-keys -t namegame 'cd ~/src/namegame' C-m
tmux send-keys -t namegame 'cp ~/src/namegame/scripts/b.py ~/src/b.py' C-m
tmux send-keys -t namegame 'cp ~/src/namegame/scripts/a.py ~/src/a.py' C-m
tmux send-keys -t namegame '~/src/b.py' C-m
