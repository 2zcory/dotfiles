sshconfig=$HOME/.ssh/config

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

# -n = non-empty
zwp() {
  local dir="$zwp/$1"
  if [[ -n $1 && -d $dir ]]; then
    cd $zwp/$1 || return
    command -v vim >/dev/null && vim || echo "🧩 vim not found"
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
