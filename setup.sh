#!/bin/bash

# Tmux Setup: Mouse support, history limit, disable startup prompt, always start at home directory
echo -e 'set -g mouse on
set -g history-limit 10000
set -g default-command /bin/bash
bind c new-window -c ~
bind % split-window -h -c ~
bind "\"" split-window -v -c ~' >> ~/.tmux.conf

# Tmux Bash Completion
curl -fSsL "https://raw.githubusercontent.com/imomaliev/tmux-bash-completion/master/completions/tmux" \
  > ~/.bash.tmux-bash-completion
echo 'source ~/.bash.tmux-bash-completion' >> ~/.bashrc

# Install Alacritty and tree, set Alacritty background
sudo apt-get update && sudo apt-get install -y alacritty tree
mkdir -p ~/.config/alacritty
echo -e 'colors:\n  primary:\n    background: "#141D2B"' > ~/.config/alacritty/alacritty.yml

# Modify $TERM for tmux and Alacritty
sed -i '/case "\$TERM" in/{n;s/xterm\*|rxvt\*/xterm\*|rxvt\*|tmux\*|alacritty\*/}' ~/.bashrc

# Reload bashrc (affects only *this* shell while script runs)
source ~/.bashrc

# Create Alacritty Desktop shortcut
echo -e '#!/usr/bin/env xdg-open
[Desktop Entry]
Type=Application
TryExec=alacritty
Exec=alacritty --option window.startup_mode=Maximized
Icon=Alacritty
Terminal=false
Categories=System;TerminalEmulator;
Name=Alacritty
GenericName=Terminal
Comment=A fast, cross-platform, OpenGL terminal emulator
StartupWMClass=Alacritty
Actions=New;

[Desktop Action New]
Name=New Terminal
Exec=alacritty --option window.startup_mode=Maximized' \
> ~/Desktop/alacritty.desktop

chmod +x ~/Desktop/alacritty.desktop
