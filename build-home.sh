#!/bin/sh

echo "building home..."

mkdir -p "/home/eloi/.config/alacritty"
cp "/etc/nixos/alacritty/alacritty.toml" "/home/eloi/.config/alacritty/"

mkdir -p "/home/eloi/.config/niri/"
cp "/etc/nixos/niri/config.kdl" "/home/eloi/.config/niri/"

cp "/etc/nixos/zsh/zshrc.bash" "/home/eloi/.zshrc"

mkdir -p .zsh/completion
cp "/etc/nixos/zsh/_edit-nixos" "/home/eloi/.zsh/completion/"
cp "/etc/nixos/zsh/_open" "/home/eloi/.zsh/completion/"

mkdir -p "/home/eloi/.config/micro/colorschemes"
cp "/etc/nixos/micro/bindings.json" "/home/eloi/.config/micro/"
cp "/etc/nixos/micro/settings.json" "/home/eloi/.config/micro/"
cp "/etc/nixos/micro/my.micro" "/home/eloi/.config/micro/colorschemes"

mkdir -p "/home/eloi/.local/bin/"
cp "/etc/nixos/custom-bin/edit-nixos.bash" "/home/eloi/.local/bin/edit-nixos"
cp "/etc/nixos/custom-bin/open.sh" "/home/eloi/.local/bin/open" 
chmod +x "/home/eloi/.local/bin/edit-nixos"
chmod +x "/home/eloi/.local/bin/open"

mkdir -p "/home/eloi/.emacs.d"
cp "/etc/nixos/emacs/init.el" "/home/eloi/.emacs.d/init.el"

mkdir -p "/home/eloi/.emacs.d/themes"
cp "/etc/nixos/emacs/noctilux-theme.el" "/home/eloi/.emacs.d/themes/noctilux-theme.el"

chown -R eloi:users /home/eloi

echo "OK"
