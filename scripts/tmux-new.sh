# Script to create a default Tmux session; layout is a vertical 32:68 split
tmux new -t $1 \; split-pane -h -p 68
