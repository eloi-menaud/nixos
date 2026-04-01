apps="firefox:firefox-devedition -p Default-custom
signal:signal-desktop
discord
kitty
steam
ranger:kitty ranger
poweroff"

selection=$(echo -e "$apps" | sed 's|:.*||' | rofi -dmenu -matching prefix -auto-select)
if test -n "$selection"
then
  cmd=$(echo "$apps" | grep -o "^$selection.*$" | sed 's|^.*:||')
  if test "$cmd" = "poweroff"
  then
    validation=$(echo "Poweroff confirmation" | rofi -dmenu)
    if test -z "$validation"
    then
      exit 0
    fi
  fi
  $cmd
fi
