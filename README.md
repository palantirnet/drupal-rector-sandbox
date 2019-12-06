# Drupal Skeleton

This is a template for starting Drupal 8 projects using the `composer create-project` command.

## Quick start

This "quick start" section will show you how to set up a local server accessible at `https://d8rector-sandbox.ddev.site` with Drupal ready to install.

### Preface

You should have the development dependencies installed on your Mac before you begin. These dependencies are not project-specific, and you may have some or all of them already installed. If you don't, find a location with good internet and set aside at least an hour to complete this step.

The development dependencies are:

* PHP 7
  * Check your PHP version from the command line using `php --version`
* [XCode](https://itunes.apple.com/us/app/xcode/id497799835?mt=12)
* [Composer](https://getcomposer.org/download/)

### **DDEV**

* [Docker](https://ddev.readthedocs.io/en/stable/users/docker_installation/)
  * We recommend installing with [homebrew](https://brew.sh/): `brew cask install docker`
* [DDEV](https://ddev.readthedocs.io/en/stable/#installation)
  * We recommend installing with [homebrew](https://brew.sh/): `brew tap drud/ddev && brew install ddev`
* [NFS](https://ddev.readthedocs.io/en/stable/users/performance/#macos-nfs-setup)
  * [Download & run this script](https://raw.githubusercontent.com/drud/ddev/master/scripts/macos_ddev_nfs_setup.sh)

Once you have your dependencies installed, setting up this skeleton will take at least another hour, depending on your internet connection.

Some of the commands below will prompt you for a response, with the default answer in brackets. For this quick start, hit return to accept each default answer:

```
Enter a short name for your project [example] :
```

### Steps

1. Make sure your computer already have the software needed (see DDEV section above)
    - Docker
    - DDEV
    - NFS

2. Run the following commands:

  ```
  ddev restart
  ```

3. In your web browser, visit [https://d8rector-sandbox.ddev.site](https://d8rector-sandbox.ddev.site)

4. _Optional:_ You can run Drush commands, like `ddev . drush status`.

### Troubleshooting

#### NFS error
Because both Vagrant and DDEV are using NFS, if your project was running with Vagrant before:
* Edit `/etc/exports` file
* Comment out the Vagrant line
* Add `/Users/<username> -alldirs -mapall=501:20 localhost`
* Restart NFS service `sudo nfsd restart`
* Test that DDEV can mount NFS `ddev debug nfsmount`
* Run `ddev restart`

### Extra Credit

* Running drush commands (`ddev . drush status`)
* Importing a new database (`ddev import-db --src=<database_file.tar.gz>`)
* Log into docker image (`ddev ssh`) and export the Drupal configuration (`drush config-export`)
* Backup your database locally (`ddev snapshot`)
* Run `ddev` to see the available commands.
* Access your database via phpMyAdmin at [http://d8rector-sandbox.ddev.site:8036](http://d8rector-sandbox.ddev.site:8036) using the username `drupal` and the password `drupal`
* View email sent by your development site at [http://d8rector-sandbox.ddev.site:8025](http://d8rector-sandbox.ddev.site:8025)
* Additional questions:
  * `#ddev` channel on [Drupal Slack](https://drupal.slack.com) (a new account can be created through http://drupalslack.herokuapp.com/)

----
Copyright 2016, 2017, 2018, 2019 Palantir.net, Inc.
