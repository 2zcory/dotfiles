function notefetch() {
  current_path=$PWD

  cd ~/storage/documents/learning-japanese/

  git reset --hard HEAD
  gpr

  cd $current_path
}
