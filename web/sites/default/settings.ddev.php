<?php

/**
 * @file
 * #ddev-generated: Automatically generated Drupal settings file.
 * ddev manages this file and may delete or overwrite the file unless this
 * comment is removed.
 */

$host = "db";
$port = 3306;

// If DDEV_PHP_VERSION is not set, it means we're running on the host,
// so use the host-side bind port on docker IP
if (empty(getenv('DDEV_PHP_VERSION'))) {
  $host = "127.0.0.1";
  $port = 32787;
}

$databases['default']['default'] = array(
  'database' => "db",
  'username' => "db",
  'password' => "db",
  'host' => $host,
  'driver' => "mysql",
  'port' => $port,
  'prefix' => "",
);

ini_set('session.gc_probability', 1);
ini_set('session.gc_divisor', 100);
ini_set('session.gc_maxlifetime', 200000);
ini_set('session.cookie_lifetime', 2000000);

$settings['hash_salt'] = 'kZwUmVCfFrtOUJgsvVOPHxZfDuQdoptKiRkKkbMMESjQvUqYzuZvsOqimrcVqBrr';

$settings['file_scan_ignore_directories'] = [
  'node_modules',
  'bower_components',
];

// This will prevent Drupal from setting read-only permissions on sites/default.
$settings['skip_permissions_hardening'] = TRUE;

// This will ensure the site can only be accessed through the intended host
// names. Additional host patterns can be added for custom configurations.
$settings['trusted_host_patterns'] = ['.*'];

// Don't use Symfony's APCLoader. ddev includes APCu; Composer's APCu loader has
// better performance.
$settings['class_loader_auto_detect'] = FALSE;

// This specifies the default configuration sync directory.
if (empty($settings['config_sync_directory'])) {
  $settings['config_sync_directory'] = 'config';
}
