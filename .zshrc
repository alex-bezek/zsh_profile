# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/users/alex/.oh-my-zsh"

export EDITOR='code'
export TERM="xterm-256color"

# export PATH=$PATH:/usr/local/go/bin
# export GOPATH="$HOME/go_projects"
# export GOBIN="$GOPATH/bin"
# export GOROOT=$HOME/go
# export PATH=$PATH:$GOROOT/bin

# export DOCKER_CONFIG=/users/alex/code/ngrok/home/.docker
# export DOCKER_HOST=unix:///var/run/ngrok/docker.sock

export NGROK_EMAIL="alex@ngrok.com"
export NGROK_LOGS_PAGER=lnav
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
# export PATH="$PATH:/nix/store/q44nkx68xzmwn4plxdi812zps22rbd49-ngrok-dev-shell/bin"

export KUBECONFIG=$HOME/.kube/config
# export KUBECONFIG=$HOME/code/ngrok/.cache/home/.kube/config
export KUBE_EDITOR='code --wait'

# export PATH=$PATH:/usr/local/go/bin


[ -f $HOME/fubectl.source ] && source $HOME/fubectl.source

export AWS_PAGER=''
export AWS_PROFILE='ngrok'

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(
  jsontools
  sudo
  autojump
  kubectl
  last-working-dir
  tmux
  zsh-autosuggestions
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh
# source <(kubectl completion zsh)
export EDITOR='code'
export TERM="xterm-256color"

ngrok_environment() {
  echo -n "NGROK $NGROK_ENV"
}

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

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

POWERLEVEL9K_INSTANT_PROMPT=quiet

# http://nerdfonts.com/#cheat-lssheet
POWERLEVEL9K_CUSTOM_FIRE="echo -n '\ue780'"
# POWERLEVEL9K_CUSTOM_FIRE_BACKGROUND="blue"
POWERLEVEL9K_CUSTOM_FIRE_FOREGROUND="red"

# Sets new icons on the power bar (triangle by default)
# Need to see if i can find a way to only apply this on the newline
# POWERLEVEL9K_LEFT_SEGMENT_SEPARATOR=$'\uE0B1'
# POWERLEVEL9K_RIGHT_SEGMENT_SEPARATOR=$'\uE0B3'
POWERLEVEL9K_VCS_BRANCH_ICON=$'\ue727 '
POWERLEVEL9K_LEFT_SUBSEGMENT_SEPARATOR=''

POWERLEVEL9K_COMMAND_EXECUTION_TIME_THRESHOLD='0'
# POWERLEVEL9K_COMMAND_EXECUTION_TIME_BACKGROUND='black'
# POWERLEVEL9K_COMMAND_EXECUTION_TIME_FOREGROUND='blue'

# POWERLEVEL9K_KUBECONTEXT_BACKGROUND='005'
# POWERLEVEL9K_KUBECONTEXT_FOREGROUND='000'


# POWERLEVEL9K_STATUS_ERROR_BACKGROUND='blue'
# POWERLEVEL9K_STATUS_OK_BACKGROUND='blue'
# POWERLEVEL9K_STATUS_ERROR_FOREGROUND='red'
# POWERLEVEL9K_STATUS_OK_FOREGROUND='green3'


POWERLEVEL9K_CUSTOM_DOCKER="zsh_docker_signal"
# POWERLEVEL9K_CUSTOM_DOCKER_BACKGROUND='black'
# POWERLEVEL9K_CUSTOM_DOCKER_FOREGROUND='blue'

POWERLEVEL9K_CUSTOM_NGROK="ngrok_environment"
# POWERLEVEL9K_CUSTOM_NGROK_BACKGROUND='blue'
# POWERLEVEL9K_CUSTOM_NGROK_FOREGROUND='darkgreen'


POWERLEVEL9K_GO_VERSION_BACKGROUND='021'
# POWERLEVEL9K_GO_VERSION_FOREGROUND='white'

# POWERLEVEL9K_VCS_CLEAN_FOREGROUND='green'
# POWERLEVEL9K_VCS_CLEAN_BACKGROUND='blue'
# POWERLEVEL9K_VCS_UNTRACKED_FOREGROUND='green3'
# POWERLEVEL9K_VCS_UNTRACKED_BACKGROUND='blue'
# POWERLEVEL9K_VCS_MODIFIED_FOREGROUND='orangered1'
# POWERLEVEL9K_VCS_MODIFIED_BACKGROUND='blue'

# POWERLEVEL9K_COMMAND_EXECUTION_TIME_BACKGROUND='blue'
# POWERLEVEL9K_COMMAND_EXECUTION_TIME_FOREGROUND='white'

# POWERLEVEL9K_BATTERY_CHARGING_BACKGROUND='lightgreen'
# POWERLEVEL9K_BATTERY_CHARGING_FOREGROUND='black'
# POWERLEVEL9K_BATTERY_CHARGED_BACKGROUND='green'
# POWERLEVEL9K_BATTERY_CHARGED_FOREGROUND='black'
# POWERLEVEL9K_BATTERY_DISCONNECTED_BACKGROUND='orangered1'
# POWERLEVEL9K_BATTERY_DISCONNECTED_FOREGROUND='green3'
# POWERLEVEL9K_BATTERY_LOW_BACKGROUND='lightred'
# POWERLEVEL9K_BATTERY_LOW_FOREGROUND='green3'

# POWERLEVEL9K_TIME_BACKGROUND='orangered1'



unset POWERLEVEL9K_TERRAFORM_VERSION_SHOW_ON_COMMAND
unset POWERLEVEL9K_KUBECONTEXT_SHOW_ON_COMMAND

# # Customise the Powerlevel9k prompts
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(
  custom_fire
  status
  # aws
  dir
  vcs
  kubecontext
  custom_ngrok
  # custom_docker
  go_version
  newline

  terraform
  # custom_docker?
  ssh
  newline
)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(
  command_execution_time
  time

  # kubecontext
  # custom_docker


  # os_icon
  # load
  # disk_usage
  # ram
  # kubecontext
  battery
#   # context
#   # command_execution_time
#   # battery
)

function api {
  sudo apt-get install -y "$0"
}
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

function nds() {
  export NGROK_ENV="$1"
}

alias vim='nvim'

alias k="kubecolor"
compdef kubecolor=kubectl
alias kctx="kubectl ctx"
alias kns="kubectl ns"
alias kaa="kubectl get all -A"
alias kdr='kubectl --dry-run=client -o yaml'
alias kap='kubectl apply'
alias kd='kubectl delete'
alias kda='kubectl get deployments -A'
alias kbb='kubectl run busybox-test --image=busybox -it --rm --restart=Never --'
alias kdb='kubectl describe'
alias kl='kubectl logs'
alias ke='kubectl exec -it'
alias mk='/Users/alex/code/minikube/out/minikube'

# alias ls='logo-ls -al'
alias la='logo-ls -A'
alias ll='logo-ls -Al'
# # equivalents with Git Status on by Default
# alias lsg='logo-ls -D'
# alias lag='logo-ls -AD'
# alias llg='logo-ls -alD'
# alias l='exa'
# alias la='exa -a'
# alias ll='exa -lah'
alias ls='exa --color=auto --icons -la'

alias t="tree --du -h -L"

alias gs='git status'
complete -F __start_kubectl k
alias gd='git diff | bat'
alias gdt='GIT_EXTERNAL_DIFF=difft git diff'
alias cat='bat'
alias rg='batgrep'
alias watch='watch '
alias vi='nvim'

$(thefuck --alias)
alias f='fuck'

alias b='nd go install nd'
alias ndcf='nd config run | fx'
alias h='history | fzf'

# TODO: Loop over inputs and run it without commiting to history
function f(){
  history | grep $1 | tail -n 10
}

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh" || true

neofetch

source <(kubectl completion zsh)
# source "/ngrok-host-shellhook"
# source "/Users/alex/code/ngrok/.cache/ngrok-host-shellhook"
export GIT_SSH_COMMAND="ssh -i /Users/alex/.ssh/ngrok_github_key"
# eval "$(direnv hook zsh)"


source /Users/alex/.config/broot/launcher/bash/br

eval $(thefuck --alias)




# Nix
# if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
#   . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
# fi
# End Nix
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
# __conda_setup="$('/Users/alex/miniforge3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
# if [ $? -eq 0 ]; then
#     eval "$__conda_setup"
# else
#     if [ -f "/Users/alex/miniforge3/etc/profile.d/conda.sh" ]; then
#         . "/Users/alex/miniforge3/etc/profile.d/conda.sh"
#     else
#         export PATH="/Users/alex/miniforge3/bin:$PATH"
#     fi
# fi
# unset __conda_setup
# <<< conda initialize <<<

# source "/Users/alex/code/ngrok/.cache/ngrok-host-shellhook"
