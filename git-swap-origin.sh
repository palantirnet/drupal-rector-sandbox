# If running composer from inside ddev, we may not be able to install the repo
# via ssh. This script fixes that issue and must be run from the host machine.
rm -rf drupal-rector
echo "Replace http checkout with ssh."
git clone git@github.com:palantirnet/drupal-rector.git
