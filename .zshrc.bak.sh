# Setup
# git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
# Get list of brew installed things
# brew install terminal-notifier

# Aliases
alias zshconfig="code ~/.zshrc"
alias ohmyzsh="code ~/.oh-my-zsh"
alias ls="colorls --all"
alias lt="ls --tree"
alias l="ls"
alias la="ls"

alias be="bundle exec"
alias bi="bundle install"
alias rs="bundle exec rails server -b 0.0.0.0"
alias rc="bundle exec rails console"

alias G="| grep"
alias ..="cd .."
alias killit='kill -9 %%'

function psgrep() { ps aux | grep -v grep | grep "$@" -i --color=auto; }
function search() { find . -iname "*$@*" ; }

alias alert='terminal-notifier -group "terminal" -title "Terminal Task" -activate "com.googlecode.iterm2" -message "$([ $? = 0 ] && echo Finished || echo Error)"'

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
export EDITOR='vim'

# Setup Go
export GOPATH=$HOME/go

# Setup Node
export NVM_DIR="/Users/as027811/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
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
source ~/powerlevel9k/powerlevel9k.zsh-theme

zsh_docker_signal() {
	local color
	local symbol="\uf308"
	docker=$(docker ps)
	if [ $? = 0 ]; then
    version=$(docker version --format '{{.Server.Version}}')
    color="%F{blue}"
    echo -n "%{$color%}$symbol $version"
  fi
}

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

POWERLEVEL9K_CUSTOM_DOCKER="zsh_docker_signal"
POWERLEVEL9K_CUSTOM_DOCKER_BACKGROUND='black'
POWERLEVEL9K_CUSTOM_DOCKER_FOREGROUND='blue'

# Customise the Powerlevel9k prompts
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(
  custom_fire
  status
  dir
  vcs
  ssh
  custom_docker
  nvm
  rvm
  newline
)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(
  context
  command_execution_time
  battery
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
  if [[ -f Gemfile.lock ]] || ls ./*.gemspec 1> /dev/null 2>&1; then
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
