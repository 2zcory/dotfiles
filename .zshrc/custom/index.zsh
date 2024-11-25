sshconfig=$HOME/.ssh/config

zlibgas=$zwp/lib/@izgas

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
  source $zwp_zsh_custom/.os.linux.zsh
elif [[ "$OSTYPE" == "darwin"* ]]; then
  source $zwp_zsh_custom/.os.darwin.zsh
elif [[ "$OSTYPE" == "linux-android"* ]]; then
  source $zwp_zsh_custom/.os.android.zsh
fi

if [ ! -d $zwp ]; then
  echo 'Created workspace folder with path ' $zwp
  mkdir $zwp
fi

if [ ! -d $zlibgas ]; then
  echo 'Created workspace folder with path ' $zlibgas
  mkdir -p $zlibgas
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

zlibgas() {
  if [[ -d $zlibgas/$1 && ! -z $1 ]]; then
    cd $zlibgas/$1
    vim
  else
    echo "Invalid argument passed!"
  fi
}

compctl -W $zlibgas -/ zlibgas

# Custom git command
if git rev-parse --is-inside-work-tree &>/dev/null; then
  source $zwp_zsh_custom_common/git.zsh
fi
