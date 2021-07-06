# Drupal Rector Sandbox

This is the development repository for the Drupal Rector Sandbox. It contains the codebase and an environment to run the site for development.

## php8 branch

This is the php8 branch, suitable for use developing upgrade rules for Drupal 9 to Drupal 10.

### Switching branches

If you need to switch from php8 to php7 (the `main` [PHP 7.4 branch](https://github.com/palantirnet/drupal-rector-sandbox/tree/main)), follow these steps.

- Checkout the branch you want (e.g. `git checkout main` or `git checkout php8`)
- `rm -rf vendor`
- `ddev restart`
- `ddev . composer install`

## Development Note

In preparation for Drupal 10, we will start supporting PHP 7.4 and PHP 8 for development. To do so requires configuring DDEV, and as a result, we encourage you to run all `composer` and `rector` commands via `ddev exec` (alias `ddev .`).

## Table of Contents

- [Drupal Rector Sandbox](#drupal-rector-sandbox)
  - [Table of Contents](#table-of-contents)
  - [Running Drupal Rector](#running-drupal-rector)
    - [Running Drupal Rector against a test module](#running-drupal-rector-against-a-test-module)
  - [Developing with Drupal Rector](#developing-with-drupal-rector)
  - [Development Environment](#development-environment)
  - [Getting Started](#getting-started)
  - [How do I work on this](#how-do-i-work-on-this)
    - [DDEV](#ddev)
    - [Using XDebug](#using-xdebug)
  - [Troubleshooting](#troubleshooting)
    - [NFS error](#nfs-error)
  - [How this repository was built](#how-this-repository-was-built)

## Running Drupal Rector

Run `ddev . composer install`

You can view the Rector report by running:

`ddev . vendor/bin/rector process web/modules/custom/my-module --dry-run`

Rector can update your code by running:

`ddev . vendor/bin/rector process web/modules/custom/my-module`

### Running Drupal Rector against a test module

Drupal Rector comes with a test module that you can use to confirm rules are working:

`ddev . vendor/bin/rector process drupal-rector/rector_examples --dry-run`

This command is aliased in the `test-rector.sh` script in project root, so you can run this from project root instead:

`./test-rector.sh`

You can also run the PHPUnit tests with:

`ddev . vendor/bin/phpunit vendor/palantirnet/drupal-rector/tests`

This command is aliased in `./phpunit.sh`.

## Developing with Drupal Rector

1. Run `ddev . composer install` or `ddev . composer update` (it will execute a script `develop-rector.sh` that prepares a development
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
    ddev . vendor/bin/rector process drupal-rector/rector_examples --dry-run
    ```

1. Submit a PR to https://github.com/palantirnet/drupal-rector.
2. Reference the PR in a Drupal.org issue: https://www.drupal.org/project/issues/rector

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
    ddev . composer install
    ddev . drush si demo_umami -y
    ```

1. In your web browser, visit [https://drupal-rector-sandbox.ddev.site](https://drupal-rector-sandbox.ddev.site)

## How do I work on this

You can edit code, update documentation, and run git commands by opening files directly from your host machine.

### DDEV

* Log into docker image (`ddev ssh`)
* Run `ddev` to see the available commands.

### Using XDebug

- Start DDEV, `ddev start`
- Enable XDebug on DDEV, `ddev xdebug on`
- SSH into DDEV, `ddev ssh`
- Put a breakpoint in your IDE like PhpStorm, for example in `drupal-rector/src/Rector/Deprecation/Base/DBBase.php`.
- Turn on the listener in your IDE
- Run a command with the `--xdebug` flag such as `vendor/rector/rector-prefixed/rector process web/modules/custom/rector_examples/db_delete.php --dry-run --xdebug`
- Configure your servers in your IDE so it knows where the files are, see below for PhpStorm.

#### PhpStorm server mapping

Go to: `Preferences` > `Languages & Frameworks` > `PHP` > `Servers`
Add a server:
- `Name`: `drupal-rector-sandbox.ddev.site`
- `Host`: `drupal-rector-sandbox.ddev.site`
- `Port`: `22`

Under the directories, map `Project Files` > `[local path to where you have this repository]` to `/var/www/html`

You may need to cancel the Rector process and start another one for these to stick.

## Troubleshooting

### NFS error

Because both Vagrant and DDEV are using NFS, if your project was running with Vagrant before:

* Edit `/etc/exports` file
* Comment out the Vagrant line
* Add `/System/Volumes/Data/Users/<username> -alldirs -mapall=501:20 localhost`
* Restart NFS service `sudo nfsd restart`
* Test that DDEV can mount NFS `ddev debug nfsmount`
* Run `ddev restart`

## How this repository was built

This project was built more or less using these steps.

- Create a standard Drupal install with `composer create-project drupal/recommended-project:~8 ../drupal --no-progress` and then move the files into the root.
- Create a standard DDEV setup, `ddev config`.
- Add `develop-rector.sh` script to side-load Drupal Rector for local development.
- Update `composer.json` to use the version side-loaded.
- Add `PhpUnit` since it doesn't get installed by default and is needed for some rules.
- Add a `docker-compose.env.yaml` file for DDEV to support XDebug
- Add `test-rector.sh` script for testing shortcuts.

----
Copyright 2017-2021 Palantir.net, Inc.
