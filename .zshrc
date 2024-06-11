# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"


plugins=(
  jsontools
  sudo
  kubectl
  last-working-dir
  tmux
  zsh-autosuggestions
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh


# Customizations
ngrok_environment() {
  echo -n "NGROK $NGROK_ENV"
}

POWERLEVEL9K_INSTANT_PROMPT=quiet
POWERLEVEL9K_CUSTOM_FIRE="echo -n '\ue780'"
POWERLEVEL9K_CUSTOM_FIRE_FOREGROUND="red"
POWERLEVEL9K_VCS_BRANCH_ICON=$'\ue727 '
POWERLEVEL9K_LEFT_SUBSEGMENT_SEPARATOR=''
POWERLEVEL9K_COMMAND_EXECUTION_TIME_THRESHOLD='0'
POWERLEVEL9K_CUSTOM_NGROK="ngrok_environment"
POWERLEVEL9K_GO_VERSION_BACKGROUND='021'

# # Customise the Powerlevel9k prompts
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(
  custom_fire
  status
  dir
  vcs
  kubecontext
  custom_ngrok
  go_version
  terraform
  newline
)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(
  command_execution_time
  time
  battery
)

function gc() {
  git add .;
  git commit -m "$@"
}

function gp() {
  git push origin $(git symbolic-ref --short HEAD)
}

function ga() {
  gc "$1"
  gp
}

function nds() {
  export NGROK_ENV="$1"
}

alias k="kubectl"
alias kctx="kubectl ctx"
alias kns="kubectl ns"
alias b='nd go install nd'
alias gs='git status'
alias gd='git diff'
export GIT_SSH_COMMAND="ssh -i ~/.ssh/ngrok_github_key"
export PATH=$PATH:/usr/local/go/bin
export NGROK_EMAIL="alex@ngrok.com"
export NGROK_DISABLE_ND_AUTO_RECOMPILATION=true
export ND_AUTO_SSO_LOGIN=true
export NGROK_DISABLE_ND_INTERACTIVE_HELP=true
