
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt inc_append_history
setopt share_history

if ! test -d $HOME/.zsh/zsh-syntax-highlighting
then git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/zsh-syntax-highlighting
fi

if ! test -d $HOME/.zsh/zsh-autosuggestions
then git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
fi

if ! test -d $HOME/.zsh/zsh-history-substring-search
then git clone https://github.com/zsh-users/zsh-history-substring-search ~/.zsh/zsh-history-substring-search
fi

source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.zsh/zsh-history-substring-search

# move
bindkey '\e[1;5C' forward-word
bindkey '\e[1;5D' backward-word
bindkey '^H' backward-kill-word

# auto-suggestions
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
bindkey '^I' forward-word #autosuggest-accept
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
WORDCHARS='"_-\\'


# pre prompt
precmd() {
    echo
    if test "$name" = ""
    then
    	echo "\033[90m$PWD\033[0m"
    else
    	echo "\033[90m$PWD \033[35m$name\033[0m"
    fi
}

PROMPT="%F{blue}>%f "

# export XDG_SESSION_TYPE=wayland
# export DISPLAY=":0"

alias l="ls --color=auto"

alias k='kubectl $@'

alias o='niri msg action spawn -- $@'


cd(){
	builtin cd "$@"
	total=$(ls . | wc -l)
	ls --color=always | head -n 10 | awk '{printf "%s   ", $0} END {print ""}'
	more_count=$(( total - 10 ))
	if (( more_count > 0 )); then
	  echo -e "\033[0;90m${more_count} more ...\033[0;0m"
	fi
}

alias sudo=/run/wrappers/bin/sudo

source <(kubectl completion zsh)
