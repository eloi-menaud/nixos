#!/bin/sh


mkdir -p "/home/elwaaaah/.config/alacritty"
cp "/etc/nixos/alacritty/alacritty.toml" "/home/elwaaaah/.config/alacritty/"

mkdir -p "/home/elwaaaah/.config/niri/"
cp "/etc/nixos/niri/config.kdl" "/home/elwaaaah/.config/niri/"

cp "/etc/nixos/zsh/zshrc.bash" "/home/elwaaaah/.zshrc"

mkdir -p "/home/elwaaaah/.config/micro/colorschemes"
cp "/etc/nixos/micro/bindings.json" "/home/elwaaaah/.config/micro/"
cp "/etc/nixos/micro/settings.json" "/home/elwaaaah/.config/micro/"
cp "/etc/nixos/micro/my.micro" "/home/elwaaaah/.config/micro/colorschemes"

mkdir -p "/home/elwaaaah/.local/bin/"
cp "/etc/nixos/custom-bin/edit-nixos.bash" "/home/elwaaaah/.local/bin/edit-nixos"
chmod +x "/home/elwaaaah/.local/bin/edit-nixos"
