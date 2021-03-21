source ~/.zplug/init.zsh

zplug "zsh-users/zsh-syntax-highlighting"
zplug "zsh-users/zsh-history-substring-search"
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-completions"
zplug "chrissicool/zsh-256color"
zplug 'dracula/zsh', as:theme
if ! zplug check --verbose; then
  printf "Install? [y/N]: "
  if read -q; then
    echo; zplug install
  fi
fi

HISTFILE=$HOME/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
zplug load

export PATH=~/.local/bin:/snap/bin:/usr/sandbox/:/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games:/usr/share/games:/usr/local/sbin:/usr/sbin:/sbin:$PATH
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin
# export FZF_DEFAULT_COMMAND = ag --hidden --ignore .git -l -g ""
export FZF_DEFAULT_COMMAND='ag -g""'
function select-history() {
  BUFFER=$(history -n -r 1 | fzf --no-sort +m --query "$LBUFFER" --prompt="History > ")
  CURSOR=$#BUFFER
}
zle -N select-history
bindkey '^r' select-history
