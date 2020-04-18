# This script would run after 'composer install' and 'composer update' commands.
# It creates relative symlinks that (might seem confusing at first) connect
# between the new development directory (drupal-rector/) and the default
# directory for composer packages (vendor/palantirnet/drupal-rector)

DIR="drupal-rector/"
echo "Creating development environment under ${DIR} directory"

if [ ! -d "$DIR" ]; then
  git clone git@github.com:palantirnet/drupal-rector.git
fi

echo "(re)create symlinks for drupal-rector, rector.yml"

rm -rf vendor/palantirnet/drupal-rector
ln -s ../../drupal-rector vendor/palantirnet/drupal-rector

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
