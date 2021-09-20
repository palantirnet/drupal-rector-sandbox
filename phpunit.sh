DIR="drupal-rector/"
if [ ! -d "$DIR" ]; then
  echo "drupal-rector not found."
else
  echo "ddev . vendor/bin/phpunit vendor/palantirnet/drupal-rector/tests"
  ddev . vendor/bin/phpunit vendor/palantirnet/drupal-rector/tests
fi
