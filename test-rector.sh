DIR="drupal-rector/"
if [ ! -d "$DIR" ]; then
  echo "drupal-rector not found."
else
  echo "ddev . vendor/bin/phpunit vendor/palantirnet/drupal-rector/tests"
  ddev . vendor/bin/phpunit vendor/palantirnet/drupal-rector/tests
  echo "ddev . vendor/bin/rector process drupal-rector/fixtures/d8/rector_examples --dry-run"
  ddev . vendor/bin/rector process drupal-rector/fixtures/d8/rector_examples --dry-run
  echo "ddev . vendor/bin/rector process vendor/palantirnet/drupal-rector/fixtures/d9/rector_examples --dry-run"
  ddev . vendor/bin/rector process vendor/palantirnet/drupal-rector/fixtures/d9/rector_examples --dry-run
fi
