

alias sudo="/run/wrappers/bin/sudo"

set -euo pipefail

path=$1

test -z $path && echo "Error : missing arg" && exit 1


if test $path = "-l"
then
	tree -C /etc/nixos/ | sed '/director/d' | sed 's|/etc/nixos/||' | sed '/store/d'
	exit 0
fi

if ! test -f /etc/nixos/$path
then
	echo -ne "No \e[0;34m$1\e[0;0m config file. Create it (\e[0;31mn\e[0;0m/\e[0;32m*\e[0;0m) ? "
	read resp
	test "$resp" = 'n' && exit 0
	/run/wrappers/bin/sudo mkdir -p $(dirname /etc/nixos/$path)
	/run/wrappers/bin/sudo touch /etc/nixos/$path
fi

ls /etc/nixos/$path || exit 1

cp /etc/nixos/$path /tmp/$(basename $path)
micro /tmp/$(basename $path) &&

echo -ne "switch(\x1b[35m*\x1b[0m) save(\x1b[32ms\x1b[0m) abort(\x1b[31ma\x1b[0m) ? "
read switch

save(){
  /run/wrappers/bin/sudo cp /tmp/$(basename $path) /etc/nixos/$path
  echo -e "\x1b[32mSaved\x1b[0m"
}

case $switch in
a)
  echo -e "\x1b[31mabort\x1b[0m"
	exit 0
	;;
s)
  save
  exit 0
  ;;
*)
	save
	profile=$(/run/wrappers/bin/sudo bootctl status | grep -o "NixOS \[.*\]" | sed "s|NixOS \[||" | sed "s|\]||")
	echo -e "\e[0;35mswitch\e[0;0m (profile: $profile)\n\n"
	/run/wrappers/bin/sudo nixos-rebuild switch --profile-name "$profile"
	;;
esac
