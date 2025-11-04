
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt inc_append_history
setopt share_history




fpath=(~/.zsh/completions $fpath)
autoload -U compinit && compinit

# syntaxe highlight
if ! test -d $HOME/.zsh/zsh-syntax-highlighting
then git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/zsh-syntax-highlighting
fi
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh


# command suggestion menu
if ! test -d $HOME/.zsh/fzf-tab
then git clone https://github.com/Aloxaf/fzf-tab ~/.zsh/fzf-tab
fi
source ~/.zsh/fzf-tab/fzf-tab.zsh
bindkey '^[[Z' fzf-tab-complete # bind Shift+Tab to "open sggestion menu"


# command preview suggestion
if ! test -d $HOME/.zsh/zsh-autosuggestions
then git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
fi
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

ZSH_AUTOSUGGEST_STRATEGY=(history completion)
bindkey '^I' forward-word # autosuggest-accept


# delete selection
fpath=(~/.zsh/completions ~/.zsh/plugins $fpath)
mkdir -p ~/.zsh/plugins/
if ! test -f ~/.zsh/plugins/delsel-mode
then curl https://raw.githubusercontent.com/knu/zsh-delsel-mode/refs/heads/main/delsel-mode -o ~/.zsh/plugins/delsel-mode
fi
autoload -Uz delsel-mode
delsel-mode




# Ctrl+G for a sticky selection
ZSH_CTRL_G_SELECT_ACTIVE=0
toggle-ctrl-g-selection() {
  if (( ZSH_CTRL_G_SELECT_ACTIVE == 0 )); then
    zle set-mark-command
    ZSH_CTRL_G_SELECT_ACTIVE=1
  else
    zle exchange-point-and-mark
    ZSH_CTRL_G_SELECT_ACTIVE=0
  fi
}

zle -N toggle-ctrl-g-selection
bindkey '^G' toggle-ctrl-g-selection



# Ctrl+A to select all current line
select-all-line() {
  zle beginning-of-line
  zle set-mark-command
  zle end-of-line
}
zle -N select-all-line
bindkey '^A' select-all-line





# move
bindkey -r '^Z'


bindkey '^O' beginning-of-line
bindkey '^P' end-of-line


# word jum/delete with Ctrl
bindkey '^[[1;5D' backward-word
bindkey '^[[1;5C' forward-word
# bindkey '^H' backward-kill-word 

# search in history regarding prefix
bindkey "^[OA" history-beginning-search-backward
bindkey "^[OB" history-beginning-search-forward 

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


# usualapps

alias firefox='o firefox $@'
alias discord='o discord'
alias zed='o zeditor $PWD'
alias signal='o signal-desktop'


# kube
alias k='kubectl $@'
source <(kubectl completion zsh) # auto complete kubectl
export KUBECONFIG='/etc/rancher/k3s/k3s.yaml' 


# utils
alias cat='bat -p --paging=never -- $@'
alias src="source ~/.zshrc"

# cd with preview of current dir
cd(){
    builtin cd "$@"
    total=$(ls . | wc -l)
    ls --color=always | head -n 10 | awk '{printf "%s   ", $0} END {print ""}'
    more_count=$(( total - 30 ))
    if (( more_count > 0 )); then
      echo -e "\033[0;90m${more_count} more ...\033[0;0m"
    fi
}


alias sudo=/run/wrappers/bin/sudo

