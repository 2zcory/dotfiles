sshconfig=$HOME/.ssh/config

if [ ! -d $zwp ]; then
  echo 'Created workspace folder with path ' $zwp
  mkdir $zwp
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
