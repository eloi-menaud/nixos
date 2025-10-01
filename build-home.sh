#!/bin/sh


mkdir -p "/home/eloi/.config/alacritty"
cp "/etc/nixos/alacritty/alacritty.toml" "/home/eloi/.config/alacritty/"

mkdir -p "/home/eloi/.config/niri/"
cp "/etc/nixos/niri/config.kdl" "/home/eloi/.config/niri/"

cp "/etc/nixos/zsh/zshrc.bash" "/home/eloi/.zshrc"

mkdir -p "/home/eloi/.config/micro/colorschemes"
cp "/etc/nixos/micro/bindings.json" "/home/eloi/.config/micro/"
cp "/etc/nixos/micro/settings.json" "/home/eloi/.config/micro/"
cp "/etc/nixos/micro/my.micro" "/home/eloi/.config/micro/colorschemes"

mkdir -p "/home/eloi/.local/bin/"
cp "/etc/nixos/custom-bin/edit-nixos.bash" "/home/eloi/.local/bin/edit-nixos"
chmod +x "/home/eloi/.local/bin/edit-nixos"
