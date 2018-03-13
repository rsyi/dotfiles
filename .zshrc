# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=/csnzoo/ryi/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="theunraveler"

# Set list of themes to load
# Setting this variable when ZSH_THEME=random
# cause zsh load theme from this variable instead of
# looking in ~/.oh-my-zsh/themes/
# An empty array have no effect
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  vi-mode
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Artifactory repositories.
export PIP_INDEX_URL=https://artifactory.service.bo1.csnzoo.com/artifactory/api/pypi/pypi-centos71-all/simple
export PIP_EXTRA_INDEX_URL=https://artifactory.service.bo1.csnzoo.com/artifactory/api/pypi/pypi-mirror/simple

# User aliases.
# Navigation aliases.
# alias l="ls -lha"
alias cd0="cd /wayfair/home/${USER}/"
alias cdaf="cd /wayfair/home/${USER}/git-repos/airflow-dags/"
alias cdcb="cd /wayfair/mnt/crunch_buckets/local/data_science/ryi"
alias TOP="ssh ryi@bigdatatop01.dev.bo1.csnzoo.com"

# Project-specific.
## Activation.
alias cdp0="cd /wayfair/home/${USER}/git-repos/customer-scoring-and-bidding/customer-files/cf_activation_v2"
alias activate0="source /wayfair/home/${USER}/venvs/cf_activation/bin/activate"
alias cdaf0="cd /wayfair/home/${USER}/git-repos/airflow-dags/templates/data_science/marketing/customer_file_joint_activation"
alias cdaf1="cd /wayfair/home/${USER}/git-repos/airflow-dags/templates/data_science/marketing/customer_file_activebuyers_lifestyle"
# Active buyers.
alias cdp1="cd /wayfair/home/ryi/git-repos/customer-scoring-and-bidding/customer-files/cf_active_buyers_joss"
alias activate1="source /wayfair/home/${USER}/venvs/cf_active_buyers_joss/bin/activate"

# Environment aliases.
alias activate_default="source /wayfair/home/${USER}/venvs/default/bin/activate"
alias activate_airflow="source /wayfair/app/airflow/venv/airflow/bin/activate"


# Shortened commands.
# vsql connection.
alias vsql="/opt/vertica/bin/vsql -h vertica.csnzoo.com Wayfair ryi"

# Airflow.
export AIRFLOW_HOME=/wayfair/app/airflow

# Cookiecutter datascience.
alias wf-cookiecutter="cookiecutter git@git.csnzoo.com:rfay/cookiecutter-data-science.git"

# Non-project-related source activates.
# Activate reviewboard env.
alias activate_rbt="source /wayfair/home/$USERNAME/virtualenv/py27/rbtools/bin/activate"
# Activate python3 for wheelhaus.
alias activate_py3="source /wayfair/home/ryi/venvs/python3/bin/activate"

PATH=$HOME/.local/bin:$PATH:$HOME/bin
export PATH

# Use 256 colors (so terminal plays well with PuTTY).
export TERM=xterm-256color
