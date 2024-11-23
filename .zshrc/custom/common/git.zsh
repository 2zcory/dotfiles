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
