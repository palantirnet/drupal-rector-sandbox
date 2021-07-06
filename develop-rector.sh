# This script would run before 'composer install' and 'composer update' commands.
# It clones palantirnet/drupal-rector repo to under the drupal-rector/ directory.
# Composer is set to use the cloned repo instead of getting drupal-rector from packagist
# (This is done through 'type: path' under repositories section in composer.json)

# Clone palantirnet/drupal-rector if the drupal-rector/ directory does not exist.
DIR="drupal-rector/"
if [ ! -d "$DIR" ]; then
  echo "Creating development environment under ${DIR} directory"
  # If a public SSH key found clone with SSH, otherwise clone with HTTPS
  FILE="$HOME/.ssh/id_rsa.pub"
  if [ -e "$FILE" ]; then
    echo "Clone with SSH"
    git clone git@github.com:palantirnet/drupal-rector.git
  else
    echo "Clone with HTTPS"
    git clone https://github.com/palantirnet/drupal-rector.git
  fi
fi

# Create a copy of rector.php file
if [ ! -e "rector.php" ]; then
  echo "Copying rector.php into the document root directory"
  cp drupal-rector/rector.php .
fi
