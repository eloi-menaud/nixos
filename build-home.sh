#!/bin/sh

echo "building home..."

# niri
mkdir -p "/home/eloi/.config/niri/"
cp "/etc/nixos/niri/config.kdl" "/home/eloi/.config/niri/"


# zsh
cp "/etc/nixos/zsh/zshrc.bash" "/home/eloi/.zshrc"

# micro
sh /etc/nixos/zsh/micro/setup_micro.sh

# rofi
mkdir -p "/home/eloi/.config/rofi/"
cp "/etc/nixos/rofi/config.rasi" "/home/eloi/.config/rofi/"

# bin
mkdir -p "/home/eloi/.local/bin/"
cp "/etc/nixos/custom-bin/edit-nixos.bash" "/home/eloi/.local/bin/edit-nixos"
cp "/etc/nixos/rofi/open.sh" "/home/eloi/.local/bin/open" 
chmod +x "/home/eloi/.local/bin/edit-nixos"
chmod +x "/home/eloi/.local/bin/open"

#firefox
mkdir -p "/home/eloi/.mozilla/firefox/custom/chrome"
cp "/etc/nixos/firefox/userChrome.css" "/home/eloi/.mozilla/firefox/custom/chrome/"
grep -q "toolkit.legacyUserProfileCustomizations.stylesheets" /home/eloi/.mozilla/firefox/custom/chrome/prefs.js \
&& sed -i 's/user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", false)/user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true)/' $PROFILE_PATH/prefs.js \
|| echo 'user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);' >> /home/eloi/.mozilla/firefox/custom/chrome/prefs.js


chown -R eloi:users /home/eloi

echo "OK"
