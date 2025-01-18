#!/bin/bash

########################################
# 1) Append to ~/.tmux.conf
########################################
cat << 'EOF' >> ~/.tmux.conf
set -g mouse on
set -g history-limit 10000
set -g default-command /bin/bash
bind c new-window -c ~
bind % split-window -h -c ~
bind "\"" split-window -v -c ~
EOF

########################################
# 2) Tmux Bash Completion
########################################
curl -fSsL \
  "https://raw.githubusercontent.com/imomaliev/tmux-bash-completion/master/completions/tmux" \
  > ~/.bash.tmux-bash-completion

echo 'source ~/.bash.tmux-bash-completion' >> ~/.bashrc

########################################
# 3) Install Alacritty and tree
########################################
sudo apt-get update && sudo apt-get install -y alacritty tree

########################################
# 4) Create Alacritty config
########################################
mkdir -p ~/.config/alacritty
cat << 'EOF' > ~/.config/alacritty/alacritty.yml
colors:
  primary:
    background: "#141D2B"
EOF

########################################
# 5) Add tmux and Alacritty to $TERM
#    in ~/.bashrc (this line finds
#    the next line after 'case $TERM in'
#    and replaces xterm*|rxvt* with
#    xterm*|rxvt*|tmux*|alacritty*
########################################
sed -i '/case \$TERM in/{n;s/xterm\*|rxvt\*/xterm\*|rxvt\*|tmux\*|alacritty\*/}' ~/.bashrc

########################################
# 6) Source ~/.bashrc
#    (affects only this subshell)
########################################
source ~/.bashrc

########################################
# 7) Create Alacritty Desktop shortcut
########################################
cat << 'EOF' > ~/Desktop/alacritty.desktop
#!/usr/bin/env xdg-open
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
Exec=alacritty --option window.startup_mode=Maximized
EOF

chmod +x ~/Desktop/alacritty.desktop

echo "All done!"
