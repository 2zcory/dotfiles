export zwp_p10k=$zwp/dotfiles/p10k

# Custom Zsh common
export zwp_zsh_custom_common=$zwp_zsh_custom/common

# Google appscript
izgas=$zwp/lib/@izgas

izutils=$zwp/lib/@izutils

iztypes=$zwp/lib/@iztypes

# 💻 Detect and load OS-specific configuration
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
  source $zwp_zsh_custom/.os.linux.zsh
elif [[ "$OSTYPE" == "darwin"* ]]; then
  source $zwp_zsh_custom/.os.darwin.zsh
elif [[ "$OSTYPE" == "linux-android"* ]]; then
  source $zwp_zsh_custom/.os.android.zsh
fi
