# Drupal 8 Rector Sandbox

This is the development repository for the Drupal 8 Rector Sandbox. It contains the codebase and an environment to run the site for development.

## Table of Contents

* [Development Environment](#development-environment)
* [Getting Started](#getting-started)
* [How do I work on this?](#how-do-i-work-on-this)
* [Running Drupal Rector](#running-drupal-rector)
* [Drupal Development](#drupal-development)

## Development Environment

The development environment is based on [palantirnet/the-vagrant](https://github.com/palantirnet/the-vagrant).

You can also use DDEV and Docker to run this site.

To run the environment, you will need:

* Mac OS X >= 10.13. _This stack may run under other host operating systems, but is not regularly tested. For details on installing these dependencies on your Mac, see our [Mac setup doc [internal]](https://github.com/palantirnet/documentation/wiki/Mac-Setup)._
* PHP 7.3
  * Check your PHP version from the command line using `php --version`
* [XCode](https://itunes.apple.com/us/app/xcode/id497799835?mt=12)
* [Composer](https://getcomposer.org)

To use Vagrant, you will need:

* [virtualBox](https://www.virtualbox.org/wiki/Downloads) >= 5.0
* [ansible](https://github.com/ansible/ansible) `brew install ansible`
* [vagrant](https://www.vagrantup.com/) >= 2.1.0
* Vagrant plugins:
  * [vagrant-hostmanager](https://github.com/smdahlen/vagrant-hostmanager) `vagrant plugin install vagrant-hostmanager`
  * [vagrant-auto_network](https://github.com/oscar-stack/vagrant-auto_network) `vagrant plugin install vagrant-auto_network`

If you update Vagrant, you may need to update your vagrant plugins with `vagrant plugin update`.

To use DDEV, you will need:

* [Docker](https://ddev.readthedocs.io/en/stable/users/docker_installation/)
  * We recommend installing with [homebrew](https://brew.sh/): `brew cask install docker`
* [DDEV](https://ddev.readthedocs.io/en/stable/#installation)
  * We recommend installing with [homebrew](https://brew.sh/): `brew tap drud/ddev && brew install ddev`
* [NFS](https://ddev.readthedocs.io/en/stable/users/performance/#macos-nfs-setup)
  * [Download & run this script](https://raw.githubusercontent.com/drud/ddev/master/scripts/macos_ddev_nfs_setup.sh)

## Getting Started with Vagrant

1. Clone the project from github: `git clone https://github.com/palantirnet/d8rector-sandbox.git`
2. From inside the project root, run:

  ```
    composer install
    vagrant up
  ```
3. You will be prompted for the administration password on your host machine
4. Log in to the virtual machine (the VM): `vagrant ssh`
5. From within the VM, build and install the Drupal site: `phing install`
6. Visit your site at [d8rector-sandbox.local](http://d8rector-sandbox)

## Getting Started with DDEV

1. Clone the project from github: `git clone https://github.com/palantirnet/d8rector-sandbox.git`

2. Run the following commands:

  ```
  ddev restart
  composer install
  ddev . drush si demo_umami -y
  ```

3. In your web browser, visit [https://d8rector-sandbox.ddev.site](https://d8rector-sandbox.ddev.site)

## How do I work on this?

You can edit code, update documentation, and run git commands by opening files directly from your host machine.

### Vagrant

To run project-related commands other than `vagrant up` and `vagrant ssh`:

* SSH into the VM with `vagrant ssh`
* You'll be in your project root, at the path `/var/www/your-project.local/`
* You can run `composer`, `drush`, and `phing` commands from here

### DDEV

* Running drush commands (`ddev . drush status`)
* Importing a new database (`ddev import-db --src=<database_file.tar.gz>`)
* Log into docker image (`ddev ssh`) and export the Drupal configuration (`drush config-export`)
* Backup your database locally (`ddev snapshot`)
* Run `ddev` to see the available commands.
* Access your database via phpMyAdmin at [http://d8rector-sandbox.ddev.site:8036](http://d8rector-sandbox.ddev.site:8036) using the username `drupal` and the password `drupal`
* View email sent by your development site at [http://d8rector-sandbox.ddev.site:8025](http://d8rector-sandbox.ddev.site:8025)
* Additional questions:
  * `#ddev` channel on [Drupal Slack](https://drupal.slack.com) (a new account can be created through http://drupalslack.herokuapp.com/)

## Running Drupal Rector

You can view the report for Rector by running
`vendor/bin/rector process web/modules/custom/my-module --dry-run --config vendor/drupal8-rector/drupal8-rector/rector.yml`

If you run this without the `--dry-run` flag, Rector will update your code.

## Drupal Development

You can refresh/reset your local Drupal site at any time. SSH into your VM and then:

1. Download the most current dependencies: `composer install`
2. Rebuild your local CSS and Drupal settings file: `phing build`
3. Reinstall Drupal: `phing install` (this will run `build` implicitly)
4. ... OR run all three phing targets at once: `phing install` (again, `install` runs `build` for you)

Additional information on developing for Drupal within this environment is in [docs/general/drupal_development.md](docs/general/drupal_development.md).

## Troubleshooting

### NFS error
Because both Vagrant and DDEV are using NFS, if your project was running with Vagrant before:
* Edit `/etc/exports` file
* Comment out the Vagrant line
* Add `/Users/<username> -alldirs -mapall=501:20 localhost`
* Restart NFS service `sudo nfsd restart`
* Test that DDEV can mount NFS `ddev debug nfsmount`
* Run `ddev restart`

----
Copyright 2017, 2019 Palantir.net, Inc.
