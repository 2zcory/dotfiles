function gcnp() {
  # Add all changes
  git add .

  # Get the current date time
  current_date=$(date +'%Y/%m/%d %H:%M')

  # Commit changes with the current date and time as the commit message
  git commit -m "$current_date"

  # Push changes to the remote repository
  git push
}

function git_push_force_trigger() {
  local branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)

  echo "🚨 WARNING: You are about to perform a FORCE PUSH!"
  echo "🔀 Current branch: $branch"
  echo "⚠️  Command: git push -f"

  # Skip confirmation in CI/CD or if explicitly allowed via env variable
  if [[ "$CI" == "true" || "$GIT_FORCE_ALLOW" == "1" ]]; then
    echo "✅ Force push allowed due to CI or GIT_FORCE_ALLOW=1"
    return 0
  fi

  read -k 1 "confirm?❓ Are you sure you want to continue? (y/N): "
  echo
  if [[ "$confirm" != "y" ]]; then
    echo "❌ Force push cancelled."
    return 1
  fi

  echo "✅ Force push confirmed."
  return 0
}

function git() {
  if [[ "$1" == "push" && ("$2" == "-f" || "$2" == "--force") ]]; then
    git_push_force_trigger || return 1
  fi
  command git "$@"
}

function gp() {
  if [[ "$1" == "-f" || "$1" == "--force" ]]; then
    git_push_force_trigger || return 1
    command git push "$@"
  else
    command git push "$@"
  fi
}
