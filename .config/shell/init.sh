sshconfig=$HOME/.ssh/config

znvim=$HOME/.config/nvim
zsc=$HOME/.zscripts
zwp=$HOME/wp

if [ ! -d $zwp ]; then
  echo 'Created workspace folder with path ' $zwp
  mkdir $zwp
fi

if [ ! -z "$( ls -A $zwp)" ]; then
  for d in $zwp/*/; do 
    dname=$(basename $d)
    declare zwp_$dname=$zwp/$dname
  done
fi
