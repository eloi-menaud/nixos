
# =======================
#    ZSH configuration 
# =======================


fpath=(~/.zsh/completions $fpath)
autoload -U compinit && compinit # some stuff for clipboard



# syntaxe highlight
if ! test -d $HOME/.zsh/zsh-syntax-highlighting
then git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/zsh-syntax-highlighting
fi
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh



# command suggestion menu (display all available nex command words)
#
# example :
# > git ▉
#   ────────────────────────────────────────────────────
#   add    -- add file contents to index
#   am     -- apply patches from a mailbox
#   apply  -- apply patch to files and/or to index
#
if ! test -d $HOME/.zsh/fzf-tab
then git clone https://github.com/Aloxaf/fzf-tab ~/.zsh/fzf-tab
fi
source ~/.zsh/fzf-tab/fzf-tab.zsh
bindkey '^[[1;5I' fzf-tab-complete # bind Shift+Tab to "open sggestion menu"



# History
HISTFILE=~/.zsh_history # storage file
HISTSIZE=10000 # RAM
SAVEHIST=10000 # Disk
setopt inc_append_history # write to starge file after each command
setopt share_history # share history between terms



# command preview suggestion
if ! test -d $HOME/.zsh/zsh-autosuggestions
then git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
fi
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

ZSH_AUTOSUGGEST_STRATEGY=(history completion) # autosuggestions based on the zsh history
bindkey '^I' autosuggest-accept # Tab accept the previewed suggestion
bindkey '^[[Z' forward-word # Shift-Tab partially accept the suggestion (~1 word by Shift-Tab)



# delete selection (delete all the selected text, normaly you can juste delete char by char)
fpath=(~/.zsh/completions ~/.zsh/plugins $fpath)
mkdir -p ~/.zsh/plugins/
if ! test -f ~/.zsh/plugins/delsel-mode
then curl https://raw.githubusercontent.com/knu/zsh-delsel-mode/refs/heads/main/delsel-mode -o ~/.zsh/plugins/delsel-mode
fi
autoload -Uz delsel-mode
delsel-mode



# Search in history by keeping prefix
# if command startt by "git add"
# up arrow will search in the history for the latest command starting by "git add"
# not juste the previous command regardless of what have already been writte
bindkey "^[OA" history-beginning-search-backward # ↑ : go back through the history
bindkey "^[OB" history-beginning-search-forward  # ↓ : go forward through the history



# chars used to split words
WORDCHARS='"_-\\'



# pre prompt
# 
# actual/path git-branch
# > ▉
#
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






# =================
#    keybindings 
# =================

# Ctrl o : go to end of line
bindkey '^O' beginning-of-line

# Ctrl p : go to start of line
bindkey '^P' end-of-line


# Ctrl ← : jump 1 word left
bindkey '^[[1;5D' backward-word

# Ctrl → : jump 1 word right
bindkey '^[[1;5C' forward-word

# Ctrl ⌫ : delete word
bindkey '^H' backward-kill-word 


# Ctrl+A to select all current line
select-all-line() {
  zle beginning-of-line
  zle set-mark-command
  zle end-of-line
}
zle -N select-all-line
bindkey '^A' select-all-line






# ==============
#      envs 
# ==============

export PATH="$PATH:/home/eloi/.cargo/bin"
export KUBECONFIG='/etc/rancher/k3s/k3s.yaml'  





# ===========================
#    funcitons and aliases 
# ===========================

# run niri to bve ables to have all dbus stuffs working for screen sharing
alias n='dbus-run-session niri --session'


# kube
alias k='kubectl $@'
source <(kubectl completion zsh) # auto complete kubectl


# utils
alias cat='bat -p --paging=never -- $@' # '\cat' to use the bultin 'cat' cmd 


# firefox alias to force my custom profiles with firefox-dev
alias firefox='firefox-devedition -p Default-custom'


# open an app
alias o='niri msg action spawn -- $@'


# cd with a preview of current dir
# example:
#
# /home
# > cd test/
# dir1 dir2 file1
#
# /homne/test
# > ▉
#
cd(){
    builtin cd "$@"
    total=$(ls . | wc -l)
    ls --color=always | head -n 10 | awk '{printf "%s   ", $0} END {print ""}'
    more_count=$(( total - 30 ))
    if (( more_count > 0 )); then
      echo -e "\033[0;90m${more_count} more ...\033[0;0m"
    fi
}


# 'dtrx' seams not to work properly with zip
# so need a little edge-case management
dtrx(){
  if test "$1" == *".zip"
  then
    echo ">> unzip $1"
    unzip "$1"
  else
    echo ">> dtrx $1"
    \dtrx "$1"
  fi
}

