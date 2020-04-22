# This script would run before 'composer install' and 'composer update' commands.
# It clones palantirnet/drupal-rector repo to under the drupal-rector/ directory.
# Composer is set to use the cloned repo instead of getting drupal-rector from packagist
# (This is done through 'type: path' under repositories section in composer.json)

# Clone palantirnet/drupal-rector if the drupal-rector/ directory does not exist.
DIR="drupal-rector/"
if [ ! -d "$DIR" ]; then
  echo "Creating development environment under ${DIR} directory"
  git clone git@github.com:palantirnet/drupal-rector.git
fi

# Create symlink for settings file
if [ ! -L "rector.yml" ]; then
  echo "Creating a symlink for rector.yml..."
  ln -s drupal-rector/rector.yml rector.yml
fi

# Create symlink for rector_examples to be in drupal's default module directory
if [ ! -L "web/modules/custom/rector_examples" ]; then
  echo "Creating a symlink for web/modules/custom/rector_examples..."
  mkdir -p web/modules/custom
  ln -s ../../../drupal-rector/rector_examples web/modules/custom/rector_examples
fi
