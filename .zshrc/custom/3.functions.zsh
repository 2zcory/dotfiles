function load_git_helpers_if_inside_repo() {
  # Load custom Git helpers only when inside a Git repository
  if command -v git &>/dev/null && git rev-parse --is-inside-work-tree &>/dev/null; then
    source "$zwp_zsh_custom_common/git.zsh"
  fi
}

load_git_helpers_if_inside_repo

function chpwd() {
  load_git_helpers_if_inside_repo
}
