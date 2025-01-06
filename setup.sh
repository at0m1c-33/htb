#!/bin/bash

echo -e "set -g mouse on\nset -g history-limit 10000\nset -g default-command /bin/bash" >> ~/.tmux.conf

sudo apt-get update && sudo apt-get install -y alacritty tree
mkdir -p ~/.config/alacritty && echo -e 'colors:\n  primary:\n    background: "#141D2B"' > ~/.config/alacritty/alacritty.yml

sed -i '/case "\$TERM" in/{n;s/xterm\*|rxvt\*/xterm*|rxvt*|tmux*|alacritty*/}' ~/.bashrc
source ~/.bashrc
