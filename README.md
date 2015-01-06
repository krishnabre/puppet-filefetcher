# `filefetcher` Puppet Module

#### Table of Contents

1. [Overview](#overview)
2. [Module Description](#module-description)
3. [Setup](#setup)
    * [What filefetcher affects](#what-filefetcher-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with filefetcher](#beginning-with-filefetcher)
4. [Usage](#usage)
5. [Reference](#reference)
5. [Limitations](#limitations)
6. [Development](#development)
7. [Release notes](#release-notes)
8. [To do](#to-do)
9. [Inspiration](#inspiration)

## Overview

This module aims to simplify the installation of
applications that consist of a single file.

## Genesis

I prepared it and tested having PHP Phars in mind, like:

* `composer.phar`
* `phpunit.phar`
* `box.phar`
* `php-cs-fixer.phar`
* `symfony.phar`

## Module Description

Currently, there are no binary distributions for
many php command line applications, like `composer`, `phpunit`, etc.
Thus, you cannot install them using package managers,
like APT, for example:

    # These won't work
    #
    sudo apt-get install composer
    sudo apt-get install phpunit

The `filefetcher` module aims to make installation of
one-file-applications easier.

In general:

* the module downloads a file to an arbitrary directory
* sets the owner
* sets the rights

It can be seen as a sequence of three:

* `wget`
* `chown`
* `chmod`

commands.

## Setup

### What `filefetcher` affects

Module:

* downloads a file using URL parameter (e.g. `https://getcomposer.org/composer.phar`)
* saves it under a given name (e.g. `composer`) in an arbitrary directory (e.g. `/usr/local/bin`)
* sets the owner (e.g. `root`)
* sets the rights (e.g. `a+x`)

### Setup Requirements

The module uses:

* `wget` to download files
* `maestrodev-wget` puppet module https://github.com/maestrodev/puppet-wget
* when missing, `wget` is automatically installed by `maestrodev-wget` module

### Beginning with `filefetcher`

#### System wide install with Puppet

To install the module in your system run:

    sudo puppet module install gajdaw-filefetcher

You may lock the version to avoid using the latest version:

    sudo puppet module install gajdaw-filefetcher --version 0.1.0

#### System wide install with Git

You may also use `git` to install the module:

    mkdir -p /etc/puppet/modules/box
    cd /etc/puppet/modules/box
    git clone --depth 1 https://github.com/pro-vagrant/puppet-filefetcher.git .

To lock the version, use:

    git clone --depth 1 --branch v0.1.0 https://github.com/pro-vagrant/puppet-filefetcher.git .

## Usage

The examples are stored under `examples/` directory.

### Composer

Here is `composer.pp` example:

    # Filename: examples/composer.pp
    filefetcher::fetch { 'composer':
        source => 'https://getcomposer.org/composer.phar',
    }

To run it use the following command:

    sudo puppet apply examples/composer.pp

Try to run the above command a number of times:

    sudo puppet apply examples/composer.pp
    sudo puppet apply examples/composer.pp
    sudo puppet apply examples/composer.pp

As you can see the file is not downloaded if it already exists.
You can change this behaviour with `redownload` parameter,
as described in `phpunit` example.

### Phpunit

Here is `phpunit.pp` example:

    # Filename: examples/phpunit.pp
    filefetcher::fetch { 'phpunit':
        source     => 'https://phar.phpunit.de/phpunit.phar',
        redownload => true,
    }

Thanks to `redownload => true` the file `phpunit` will be
redownloaded even if it exists.

To run it use the following command:

    sudo puppet apply examples/phpunit.pp

Now the file is downloaded every time you run the command:

    sudo puppet apply examples/phpunit.pp
    sudo puppet apply examples/phpunit.pp
    sudo puppet apply examples/phpunit.pp

### Php-cs-fixer

Here is `php-cs-fixer.pp` example:

    # Filename: examples/php-cs-fixer.pp
    filefetcher::fetch { 'php-cs-fixer':
        source => 'http://cs.sensiolabs.org/get/php-cs-fixer.phar',
    }

To run it use the following command:

    sudo puppet apply examples/php-cs-fixer.pp

### Box

Here is `box.pp` example:

    # Filename: examples/box.pp
    filefetcher::fetch { 'box':
        source => 'https://github.com/box-project/box2/releases/download/2.5.0/box-2.5.0.phar',
    }

To run it use the following command:

    sudo puppet apply examples/box.pp

### Symfony Installer

Here is `symfony-installer.pp` example:

    # Filename: examples/symfony-installer.pp
    filefetcher::fetch { 'symfony':
        url => 'http://symfony.com/installer',
    }

To run it use the following command:

    sudo puppet apply examples/symfony-installer.pp

### Symfony Standard - `composer.json` file

Here is `symfony-standard-composer-json.pp` example:

    # Filename: examples/symfony-standard-composer-json.pp
    filefetcher::fetch { 'Symfony Standard composer.json file':
        filename   => 'composer.json',
        target_dir => '/tmp',
        user       => 'vagrant',
        rights     => '755',
        url        => 'https://raw.githubusercontent.com/symfony/symfony-standard/2.7/composer.json',
    }

To run it use the following command:

    sudo puppet apply examples/symfony-standard-composer-json.pp

### Running phar binaries (`phpunit`, `composer`, etc.)

If php is missing, install it with:

    sudo apt-get install php5 -y

Now, you can use the binaries:

    phpunit --version
    composer --version
    php-cs-fixer --version
    box --version

### Uninstall

Currently, to uninstall files, you have to use `rm` command:

    sudo rm /usr/local/bin/composer
    sudo rm /usr/local/bin/phpunit
    sudo rm /usr/local/bin/php-cs-fixer
    sudo rm /usr/local/bin/box

## Reference

The complete list of parameters is available in
[`manifests/fetch.pp`](https://github.com/pro-vagrant/puppet-filefetcher/blob/master/manifests/fetch.pp)
file.

## Limitations

The box was tested on:

* Ubuntu 14.04 / Puppet 3.7

## Development

When I work on this module I find the following commands indispensable:

    cd some/dir/with/source/code/for/the/module

    sudo puppet module list
    puppet module build
    puppet-lint manifests --no-autoloader_layout-check
    sudo puppet module install pkg/gajdaw-filefetcher-0.1.0.tar.gz
    sudo puppet module uninstall gajdaw-filefetcher

    sudo puppet apply examples/phpunit.pp
    sudo puppet apply examples/composer.pp
    sudo puppet apply examples/php-cs-fixer.pp
    sudo puppet apply examples/box.pp
    sudo puppet apply examples/symfony-standard-composer-json.pp

    sudo puppet apply examples/php-common-phars.pp

Using them I don't have to upload the module to the Puppet Forge
just to verify if it is working or not.

## Release Notes

### 0.1.1

* documentation tweaks

### 0.1.0

* initial release
* works fine with attached examples

## To do

* `mkdir -p` if the destination dir does not exist
* using array of hashes as in `examples/php-common-phars.pp`
* tests
* use issues for todo

## Inspiration

The inspiration came from
[`willdurrand-composer`](https://forge.puppetlabs.com/willdurand/composer)
authored
[by William Durand](https://github.com/willdurand/puppet-composer).
