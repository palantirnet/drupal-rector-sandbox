DIR="drupal-rector/"
if [ ! -d "$DIR" ]; then
  echo "drupal-rector not found."
else
  echo "ddev . vendor/bin/rector process drupal-rector/rector_examples --dry-run"
  ddev . vendor/bin/rector process drupal-rector/rector_examples --dry-run
fi
