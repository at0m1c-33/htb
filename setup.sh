#!/bin/bash

echo -e "set -g mouse on\nset -g history-limit 10000\nset -g default-command /bin/bash" >> ~/.tmux.conf

sudo apt-get update && sudo apt-get install -y alacritty tree
mkdir -p ~/.config/alacritty && echo -e 'colors:\n  primary:\n    background: "#141D2B"' > ~/.config/alacritty/alacritty.yml

sed -i '/case "\$TERM" in/{n;s/xterm\*|rxvt\*/xterm*|rxvt*|tmux*|alacritty*/}' ~/.bashrc
source ~/.bashrc

echo -e '#!/usr/bin/env xdg-open\n[Desktop Entry]\nType=Application\nTryExec=alacritty\nExec=alacritty --option window.startup_mode=Maximized\nIcon=Alacritty\nTerminal=false\nCategories=System;TerminalEmulator;\nName=Alacritty\nGenericName=Terminal\nComment=A fast, cross-platform, OpenGL terminal emulator\nStartupWMClass=Alacritty\nActions=New;\n\n[Desktop Action New]\nName=New Terminal\nExec=alacritty --option window.startup_mode=Maximized' > ~/Desktop/alacritty.desktop && chmod +x ~/Desktop/alacritty.desktop
