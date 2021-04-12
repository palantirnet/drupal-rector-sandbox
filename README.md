# Drupal Rector Sandbox

This is the development repository for the Drupal Rector Sandbox. It contains the codebase and an environment to run the site for development.

## Table of Contents

- [Drupal Rector Sandbox](#drupal-rector-sandbox)
  - [Table of Contents](#table-of-contents)
  - [Running Drupal Rector](#running-drupal-rector)
  - [Developing with Drupal Rector](#developing-with-drupal-rector)
  - [Development Environment](#development-environment)
  - [Getting Started](#getting-started)
  - [How do I work on this](#how-do-i-work-on-this)
    - [DDEV](#ddev)
  - [Troubleshooting](#troubleshooting)
    - [NFS error](#nfs-error)

## Running Drupal Rector

Run `composer install`

You can view the Rector report by running
`vendor/bin/rector process web/modules/custom/my-module --dry-run`

Rector can update your code by running
`vendor/bin/rector process web/modules/custom/my-module`

## Developing with Drupal Rector

TODO: look at the develop-rector.sh script. Include in composer.json?

1. Run `composer install` or `composer update` (it will execute a script `develop-rector.sh` that prepares a development
environment under `drupal-project/` directory.
1. [Fork drupal-rector project](https://github.com/palantirnet/drupal-rector/fork)
1. Add your forked repo inside `drupal-project/` directory

    ```console
    cd drupal-rector
    git remote add upstream git@github.com:<your_github_username>/drupal-rector.git
    ```

1. Open a branch for the deprecation you want to create a rule for.
1. Create code samples that will include deprecated code in `drupal-rector/rector_examples`
1. Create a new Rector Rule.
1. Run Rector against the examples

    ```console
    vendor/bin/rector process web/modules/custom/rector_examples --dry-run
    ```

1. Submit a PR to https://github.com/palantirnet/drupal-rector.

## Development Environment

* [Docker](https://ddev.readthedocs.io/en/stable/users/docker_installation/)
  * We recommend installing with [homebrew](https://brew.sh/): `brew cask install docker`
* [DDEV](https://ddev.readthedocs.io/en/stable/#installation)
  * We recommend installing with [homebrew](https://brew.sh/): `brew tap drud/ddev && brew install ddev`
* [NFS](https://ddev.readthedocs.io/en/stable/users/performance/#macos-nfs-setup)
  * [Download & run this script](https://raw.githubusercontent.com/drud/ddev/master/scripts/macos_ddev_nfs_setup.sh)

## Getting Started

1. Clone the project from github: `git clone git@github.com:palantirnet/drupal-rector-sandbox.git`

1. Run the following commands:

    ```console
    ddev restart
    composer install
    ddev . drush si demo_umami -y
    ```

1. In your web browser, visit [https://drupal-rector-sandbox.ddev.site](https://drupal-rector-sandbox.ddev.site)

## How do I work on this

You can edit code, update documentation, and run git commands by opening files directly from your host machine.

### DDEV

* Running drush commands (`ddev . drush status`)
* Importing a new database (`ddev import-db --src=<database_file.tar.gz>`)
* Log into docker image (`ddev ssh`) and export the Drupal configuration (`drush config-export`)
* Backup your database locally (`ddev snapshot`)
* Run `ddev` to see the available commands.
* Access your database via phpMyAdmin at [http://drupal-rector-sandbox.ddev.site:8036](http://drupal-rector-sandbox.ddev.site:8036) using the username `drupal` and the password `drupal`
* View email sent by your development site at [http://drupal-rector-sandbox.ddev.site:8025](http://drupal-rector-sandbox.ddev.site:8025)
* Additional questions:
  * `#ddev` channel on [Drupal Slack](https://drupal.slack.com) (a new account can be created through http://drupalslack.herokuapp.com/)

## Troubleshooting

### NFS error

Because both Vagrant and DDEV are using NFS, if your project was running with Vagrant before:

* Edit `/etc/exports` file
* Comment out the Vagrant line
* Add `/System/Volumes/Data/Users/<username> -alldirs -mapall=501:20 localhost`
* Restart NFS service `sudo nfsd restart`
* Test that DDEV can mount NFS `ddev debug nfsmount`
* Run `ddev restart`

----
Copyright 2017-2021 Palantir.net, Inc.
