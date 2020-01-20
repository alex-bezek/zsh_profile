# Setup
# git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

export LPASS_AGENT_TIMEOUT=0

# Path to your oh-my-zsh installation.
export ZSH=/Users/as027811/.oh-my-zsh

plugins=(
  jsontools
  last-working-dir
  node
  tmux
  zsh-autosuggestions
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh
export EDITOR='code'
export TERM="xterm-256color"

# Setup Go
export GOPATH="${HOME}/go"
export GOROOT="$(brew --prefix golang)/libexec"
export PATH="$PATH:${GOPATH}/bin:${GOROOT}/bin"

# Setup Node
# export NVM_DIR="/Users/as027811/.nvm"
# export NVM_DIR="/usr/local/opt/nvm/nvm.sh/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
export NVM_DIR="$HOME/.nvm"
NVM_HOMEBREW="/usr/local/opt/nvm/nvm.sh"
[ -s "$NVM_HOMEBREW" ] && \. "$NVM_HOMEBREW"

export PATH="$HOME/.yarn/bin:$PATH"
# place this after nvm initialization!
autoload -U add-zsh-hook
load-nvmrc() {
  if [[ -f .nvmrc && -r .nvmrc ]]; then
    nvm use
  fi
}
add-zsh-hook chpwd load-nvmrc
load-nvmrc
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

[ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh

# Setup Ruby
export PATH="$PATH:$HOME/.rvm/bin"
source ~/.rvm/scripts/rvm

# Load Nerd Fonts with Powerlevel9k theme for Zsh
POWERLEVEL9K_MODE='nerdfont-complete'
POWERLEVEL9K_SHORTEN_STRATEGY=”truncate_from_right”
source /usr/local/opt/powerlevel9k/powerlevel9k.zsh-theme

# zsh_docker_signal() {
# 	local color
# 	local symbol="\uf308"
# 	docker=$(docker ps)
# 	if [ $? = 0 ]; then
#     version=$(docker version --format '{{.Server.Version}}')
#     color="%F{blue}"
#     echo -n "%{$color%}$symbol $version"
#   fi
# }

# http://nerdfonts.com/#cheat-lssheet
POWERLEVEL9K_CUSTOM_FIRE="echo -n '\ue780'"
POWERLEVEL9K_CUSTOM_FIRE_BACKGROUND="black"
POWERLEVEL9K_CUSTOM_FIRE_FOREGROUND="red"

# Sets new icons on the power bar (triangle by default)
# Need to see if i can find a way to only apply this on the newline
# POWERLEVEL9K_LEFT_SEGMENT_SEPARATOR=$'\uE0B1'
# POWERLEVEL9K_RIGHT_SEGMENT_SEPARATOR=$'\uE0B3'
POWERLEVEL9K_VCS_BRANCH_ICON=$'\ue727 '
POWERLEVEL9K_LEFT_SUBSEGMENT_SEPARATOR=''

POWERLEVEL9K_COMMAND_EXECUTION_TIME_THRESHOLD='0'
POWERLEVEL9K_COMMAND_EXECUTION_TIME_BACKGROUND='black'
POWERLEVEL9K_COMMAND_EXECUTION_TIME_FOREGROUND='blue'

POWERLEVEL9K_NODE_ICON=$'\uf898'
POWERLEVEL9K_NVM_BACKGROUND='green'
POWERLEVEL9K_NVM_FOREGROUND='black'

POWERLEVEL9K_RUBY_ICON=$'\ue791'
POWERLEVEL9K_RVM_BACKGROUND='red'

# POWERLEVEL9K_CUSTOM_DOCKER="zsh_docker_signal"
# POWERLEVEL9K_CUSTOM_DOCKER_BACKGROUND='black'
# POWERLEVEL9K_CUSTOM_DOCKER_FOREGROUND='blue'

# Customise the Powerlevel9k prompts
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(
  custom_fire
  status
  dir
  vcs
  ssh
  # custom_docker
  nvm
  rvm
  # command_execution_time
  newline
)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(
  # context
  # command_execution_time
  # battery
)

function get_random_rgb_from_cwd () {
  local color=$1;
  printf $(python -c "import random; import os; random.seed('$color' + os.getcwd()); print((random.randint(0,255)+255)/2)")
}

function set_iterm_tab_color () {
  local color=$1;
  local color_rgb_value=$(get_random_rgb_from_cwd $color)
  printf "\033]6;1;bg;$color;brightness;$color_rgb_value\a"
}

function automatic_iterm_tab_color_cwd () {
  set_iterm_tab_color "red"
  set_iterm_tab_color "green"
  set_iterm_tab_color "blue"
}

function set_tab_color() {
  if [[ -f Gemfile.lock ]]; then
    echo -e "\033]6;1;bg;red;brightness;231\a"
    echo -e "\033]6;1;bg;green;brightness;68\a"
    echo -e "\033]6;1;bg;blue;brightness;68\a"
  elif [[ -f .nvmrc ]]; then
    echo -e "\033]6;1;bg;red;brightness;68\a"
    echo -e "\033]6;1;bg;green;brightness;231\a"
    echo -e "\033]6;1;bg;blue;brightness;68\a"
  else
    automatic_iterm_tab_color_cwd
  fi
}

set_tab_color
autoload -U add-zsh-hook
add-zsh-hook chpwd set_tab_color

function set_iterm_title() {
  if [ $# -eq 1 ]
  then
    echo -ne "\033]0;$1\007"
  fi
}

# Aliases
alias zshconfig="code ~/.zshrc"
alias ohmyzsh="code ~/.oh-my-zsh"
# alias ls="colorls --all"
alias ll="ls --long"
alias lt="ls --tree"
alias l="ls"
alias la="ls"

alias be="bundle exec"
alias bi="bundle install"
alias rs="bundle exec rails server -b 0.0.0.0"
alias rc="bundle exec rails console"

alias G=" | grep "
alias ..="cd .."
alias killit='kill -9 %%'

alias gs="git status"
alias current_branch="git symbolic-ref --short HEAD"
function gp() {
  git push origin $(git symbolic-ref --short HEAD)
}
function gfp() {
  git push my-fork $(git symbolic-ref --short HEAD)
}
function gc() {
  git add .;
  git commit -m "$@"
}
function ga() {
  gc "$1"
  gp
}

function psgrep() { ps aux | grep -v grep | grep "$@" -i --color=auto; }
function search() { find . -iname "*$@*" ; }

alias alert='terminal-notifier -group "terminal" -title "Terminal Task" -activate "com.googlecode.iterm2" -message "$([ $? = 0 ] && echo Finished || echo Error)"'

eval $(thefuck --alias)
alias f="fuck"

setopt hist_find_no_dups        # Dont display duplicates during searches.
setopt share_history            # Share history between multiple shells
setopt hist_ignore_all_dups     # Remember only one unique copy of the command.s

function jump () {
  if [ "$#" = 1 ]
  then
    # vpn
  fi
  $HOME/zsh_profile/jump "$1"
}

function vpn () {
  $HOME/zsh_profile/vpn
  /opt/cisco/anyconnect/bin/vpn -s connect cwxvpn
}

function awscli () {
  $HOME/zsh_profile/awscli
}

alias tls="tmux ls"
function ta() { tmux a -t "$@" }
alias ta="tmux a #"
function tn() { tmux new -s "$@" }

# tmux kill-session -t myname
function jumpall() {
  vpn
  tmux new-session -s jumpgates \; \
    split-window -v \; \
    send-keys 'jump stage pre-connected' C-m \; \
    split-window -h \; \
    send-keys 'jump stage-aws pre-connected' C-m \; \
    select-pane -t 0 \; \
    send-keys 'jump prod pre-connected' C-m \; \
    split-window -h\; \
    send-keys 'jump prod-aws pre-connected' C-m \; \
}
ZSH_THEME=powerlevel10k/powerlevel10k
