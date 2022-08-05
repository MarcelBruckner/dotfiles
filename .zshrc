#################
### OH-MY-ZSH ###
#################
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"
# ZSH_THEME="powerlevel10k/powerlevel10k"
HYPHEN_INSENSITIVE="true"
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

plugins=(
  git
  aliases
  zsh-autosuggestions
  zsh-syntax-highlighting
  colored-man-pages
  virtualenv
  taskwarrior
)

source $ZSH/oh-my-zsh.sh

################
### Personal ###
################
source $HOME/.zsh_aliases
# source $HOME/.config/zsh/.zshrc_ruby_gems 
[[ ! -f $HOME/.cqse_aliases ]] || source $HOME/.cqse_aliases
[[ ! -f /usr/share/nvm/init-nvm.sh ]] || source /usr/share/nvm/init-nvm.sh
[[ ! -f $HOME/.cargo/bin/rustc ]] || export PATH="$PATH:$HOME/.cargo/bin"

export BROWSER=/usr/bin/google-chrome-stable
export EDITOR=/usr/bin/nvim

xset r rate 250 80

# Node version manager
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Install Ruby Gems to ~/gems
[ -s "~/.rvm/scripts/rvm" ] && source ~/.rvm/scripts/rvm

export GEM_HOME="$HOME/gems"
export PATH="$HOME/gems/bin:$PATH"

eval "$(starship init zsh)"

