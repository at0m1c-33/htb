#!/bin/bash

gsettings set org.mate.terminal.profile:/org/mate/terminal/profiles/default/ palette '#2E2E34343636:#CCCC00000000:#4E4E9A9A0606:#C4C4A0A00000:#34346565A4A4:#757550507B7B:#060698209A9A:#D3D3D7D7CFCF:#555557575353:#EFEF29292929:#8FF0A4:#FCFCE9E94F4F:#72729F9FCFCF:#ADAD7F7FA8A8:#3434E2E2E2E2:#EEEEEEEEECEC'

dconf write /org/mate/terminal/profiles/default/background-type "'solid'"
gsettings set org.mate.terminal.profile:/org/mate/terminal/profiles/default/ foreground-color '#8FF0A4'
gsettings set org.mate.background picture-filename '/usr/share/backgrounds/hackthebox.jpg'

echo "set -g mouse on" > ~/.tmux.conf
