# 🚀 Powerlevel10k Instant Prompt
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
zwp=$HOME/wp
zwp_zsh_custom=$zwp/dotfiles/.zshrc/custom

source $zwp_zsh_custom/1.variables.zsh


# 🎨 Install Powerlevel10k theme if needed
if [[ ! -e ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k ]]; then
  echo "Installing Powerlevek10k"
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
fi

export ZSH_THEME="powerlevel10k/powerlevel10k"

# To customize prompt, run `p10k configure` or edit ~/wp/dotfiles/p10k/.p10k.zsh.
[[ ! -f ~/wp/dotfiles/p10k/.p10k.zsh ]] || source ~/wp/dotfiles/p10k/.p10k.zsh

# 🧩 Plugins
plugins=(
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
  fast-syntax-highlighting
  zsh-autocomplete
  zsh-npm-scripts-autocomplete
)

# pnpm
export PNPM_HOME="/Users/trinkdiprovn/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

source $zwp_zsh_custom/2.alias.zsh
source $zwp_zsh_custom/3.functions.zsh
source $zwp_zsh_custom/4.wp.zsh

source $ZSH/oh-my-zsh.sh

export TERM="xterm-256color"
export PATH="$HOME/.composer/vendor/bin:$PATH"

. "$HOME/.local/bin/env"
