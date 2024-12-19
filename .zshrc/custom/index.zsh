sshconfig=$HOME/.ssh/config

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
  source $zwp_zsh_custom/.os.linux.zsh
elif [[ "$OSTYPE" == "darwin"* ]]; then
  source $zwp_zsh_custom/.os.darwin.zsh
elif [[ "$OSTYPE" == "linux-android"* ]]; then
  source $zwp_zsh_custom/.os.android.zsh
fi

# Custom git command
if git rev-parse --is-inside-work-tree &>/dev/null; then
  source $zwp_zsh_custom_common/git.zsh
fi

if [ ! -d $zwp ]; then
  echo 'Created workspace folder with path ' $zwp
  mkdir $zwp
fi

if [ ! -d $izgas ]; then
  echo 'Created workspace folder with path ' $izgas
  mkdir -p $izgas
fi

if [ ! -d $izutils ]; then
  echo 'Created workspace folder with path ' $izutils
  mkdir -p $izutils
fi

if [ ! -d $iztypes ]; then
  echo 'Created workspace folder with path ' $iztypes
  mkdir -p $iztypes
fi

# if [ ! -z "$(ls -A $zwp)" ]; then
#   for d in $zwp/*/; do
#     dname=$(basename $d)
#     declare zwp_$dname=$zwp/$dname
#   done
# fi

zwp() {
  if [[ -d $zwp/$1 && ! -z $1 ]]; then
    cd $zwp/$1
    vim
  else
    echo "Invalid argument passed!"
  fi

}

compctl -W $zwp -/ zwp

izgas() {
  if [[ -d $izgas/$1 && ! -z $1 ]]; then
    cd $izgas/$1
    vim
  else
    echo "Invalid argument passed!"
  fi
}

compctl -W $izgas -/ izgas

izutils() {
  if [[ -d $izutils/$1 && ! -z $1 ]]; then
    cd $izutils/$1
    vim
  else
    echo "Invalid argument passed!"
  fi
}

compctl -W $izutils -/ izutils

iztypes() {
  if [[ -d $iztypes/$1 && ! -z $1 ]]; then
    cd $iztypes/$1
    vim
  else
    echo "Invalid argument passed!"
  fi
}

compctl -W $iztypes -/ iztypes
