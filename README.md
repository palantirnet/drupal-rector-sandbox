# Drupal Rector Sandbox

This is the development repository for the Drupal Rector Sandbox. It contains the codebase and an environment to run the site for development.

## Table of Contents

* [Running Drupal Rector](#running-drupal-rector)
* [Developing with Drupal Rector](#developing-with-drupal-rector)
* [Development Environment](#development-environment)
* [Getting Started](#getting-started)
* [How do I work on this?](#how-do-i-work-on-this)
* [Drupal Development](#drupal-development)

## Running Drupal Rector

Initial setup: In Drupal root directory, Create or copy the initial rector.yml file -
`cp vendor/palantirnet/drupal-rector/rector.yml .`

You can view the Rector report by running
`vendor/bin/rector process web/modules/custom/my-module --dry-run`

Rector can update your code by running
`vendor/bin/rector process web/modules/custom/my-module`

## Developing with Drupal Rector

1. Run `composer install` or `composer update` (it will execute a script `develop-rector.sh` that prepares a development
environment under `drupal-project/` directory.
1. [Fork drupal-rector project](https://github.com/palantirnet/drupal-rector/fork)
1. Add your forked repo inside `drupal-project/` directory
    ```
    cd drupal-rector
    git remote add upstream git@github.com:<your_github_username>/drupal-rector.git
    ```

1. Open a branch for the deprecation you want to create a rule for.
1. Create code samples that will include deprecated code in `drupal-rector/rector_examples`
1. Create a new Rector Rule.
1. Run Rector against the examples
    ```
    vendor/bin/rector process web/modules/custom/rector_examples --dry-run
    ```
1. Submit a PR to https://github.com/palantirnet/drupal-rector.

### Using Xdebug with the Vagrant VM

The Vagrant VM includes Xdebug, but it has not been enabled for the command line. If you want to use Xdebug to develop rector files, you can use the included VM. The VM is not required to run the rectors or debug with Xdebug if your host machine has these installed.

```
# Log into the VM
vagrant up
vagrant ssh
# Enable cli debugging
sudo phpenmod -v 7.3 -s cli xdebug
```

You can then run rector with Xdebug with a command like

```
XDEBUG_CONFIG="remote_host=`netstat -rn | grep "^0.0.0.0 " | tr -s ' ' | cut -d " " -f2`" vendor/rector/rector-prefixed/rector process web/modules/custom/rector_examples --dry-run --xdebug
```

The first part will tell Xdebug how to connect to your IDE. It will probably set an environmental variable `XDEBUG_CONFIG` to include `remote_host=10.0.2.2` or a different IP.

The second part is whatever Rector command you want with the `--xdebug` flag which enables debugging.

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

1. Clone the project from github: `git clone git@github.com:palantirnet/drupal-rector-sandbox.git`
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

1. Clone the project from github: `git clone git@github.com:palantirnet/drupal-rector-sandbox.git`

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
Copyright 2017-2020 Palantir.net, Inc.
