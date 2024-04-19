#!/bin/bash

gsettings set org.mate.terminal.profile:/org/mate/terminal/profiles/default/ palette '#2E2E34343636:#6262A0A0EAEA:#FFFFFFFFFFFF:#C4C4A0A00000:#34346565A4A4:#757550507B7B:#060698209A9A:#D3D3D7D7CFCF:#555557575353:#EFEF29292929:#8F8FF0F0A4A4:#FCFCE9E94F4F:#72729F9FCFCF:#ADAD7F7FA8A8:#3434E2E2E2E2:#EEEEEEEEECEC'

dconf write /org/mate/terminal/profiles/default/background-type "'solid'"
gsettings set org.mate.terminal.profile:/org/mate/terminal/profiles/default/ foreground-color '#8F8FF0F0A4A4'
gsettings set org.mate.background picture-filename '/usr/share/backgrounds/hackthebox.jpg'

echo -e '\nPROMPT_COMMAND='\''PS1_CMD1=$(ip route get 10.10.14.1 | awk -F"src " '"'"'"'"'"'"'"'NR == 1{ split($2, a," ");print a[1]}'"'"'"'"'"'"'"')'\''; PS1='\''\n\[\e[38;5;32m\]┌─\[\e[38;5;33m\][\[\e[38;5;75m\]\u\[\e[38;5;221m\]@\[\e[38;5;77m\]${PS1_CMD1}\[\e[38;5;33m\]]\[\e[38;5;32m\]-\[\e[38;5;33m\][\[\e[0m\]\w\[\e[38;5;33m\]]\n\[\e[38;5;32m\]└──╼ \[\e[38;5;215m\]\$\[\e[0m\] '\'' >> ~/.bashrc && source ~/.bashrc

echo "set -g mouse on" > ~/.tmux.conf
