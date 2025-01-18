#!/bin/bash

# Tmux Setup Mouse Support, History Limit, Disable Startup Prompt, Always start at home directory
echo -e "set -g mouse on\nset -g history-limit 10000\nset -g default-command /bin/bash\nbind c new-window -c ~\nbind % split-window -h -c ~\nbind '"' split-window -v -c ~" >> ~/.tmux.conf

# Tmux Bash Completition
curl -fSsL "https://raw.githubusercontent.com/imomaliev/tmux-bash-completion/master/completions/tmux" > ~/.bash.tmux-bash-completion
echo 'source ~/.bash.tmux-bash-completion' >> ~/.bashrc

# Install Alacritty and Change Background Color
sudo apt-get update && sudo apt-get install -y alacritty tree
mkdir -p ~/.config/alacritty && echo -e 'colors:\n  primary:\n    background: "#141D2B"' > ~/.config/alacritty/alacritty.yml

# Add tmux and Alacritty to $TERM variable for persistent prompt
sed -i '/case "\$TERM" in/{n;s/xterm\*|rxvt\*/xterm*|rxvt*|tmux*|alacritty*/}' ~/.bashrc
source ~/.bashrc

# Create Alacritty Shortcut on the Desktop with Always Maximized Window mode
echo -e '#!/usr/bin/env xdg-open\n[Desktop Entry]\nType=Application\nTryExec=alacritty\nExec=alacritty --option window.startup_mode=Maximized\nIcon=Alacritty\nTerminal=false\nCategories=System;TerminalEmulator;\nName=Alacritty\nGenericName=Terminal\nComment=A fast, cross-platform, OpenGL terminal emulator\nStartupWMClass=Alacritty\nActions=New;\n\n[Desktop Action New]\nName=New Terminal\nExec=alacritty --option window.startup_mode=Maximized' > ~/Desktop/alacritty.desktop && chmod +x ~/Desktop/alacritty.desktop'
