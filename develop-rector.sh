# This script would run after 'composer install' and 'composer update' commands.
# It creates relative symlinks that (might seem confusing at first) connect
# between the new development directory (drupal-rector/) and the default
# directory for composer packages (vendor/palantirnet/drupal-rector)

DIR="drupal-rector/"
echo "Creating development environment under ${DIR} directory"

if [ ! -d "$DIR" ]; then
  git clone git@github.com:palantirnet/drupal-rector.git
fi

# (re)create symlinks for drupal-rector project and rector.yml file
rm -rf vendor/palantirnet/drupal-rector
ln -s ../../drupal-rector vendor/palantirnet/drupal-rector
rm rector.yml
ln -s drupal-rector/rector.yml rector.yml

# Create symlinks for rector_examples to be in drupal's default module directory
DIR="web/modules/custom/rector_examples/"
if [ ! -d "$DIR" ]; then
  echo "Creating a symlink for ${DIR}..."
  mkdir -p web/modules/custom
  ln -s ../../../drupal-rector/rector_examples web/modules/custom/rector_examples
fi
