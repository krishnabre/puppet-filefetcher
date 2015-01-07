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
6. [Limitations](#limitations)
7. [Development](#development)
8. [Inspiration](#inspiration)

## Overview

This module aims to simplify the three actions `wget + chown + chmod`.
It helps you to download the files from the net and set
appropriate the owner and access rights.

## Genesis

I prepared it for PHP Phars, like:

* `composer.phar`
* `phpunit.phar`
* `box.phar`
* `php-cs-fixer.phar`
* `symfony.phar`

But `filefetcher` is a general tool to perform `wget/chown/chmod`.

If you are interested in PHARS, please refer to
a more specialized
[puppet-php_phars module](https://forge.puppetlabs.com/gajdaw/php_phars).

## Module Description

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

    mkdir -p /etc/puppet/modules/filefetcher
    cd /etc/puppet/modules/filefetcher
    git clone --depth 1 https://github.com/pro-vagrant/puppet-filefetcher.git .

To lock the version, use:

    git clone --depth 1 --branch v0.1.0 https://github.com/pro-vagrant/puppet-filefetcher.git .

## Usage

The examples are stored under `examples/` directory.

### Symfony Standard - `composer.json` file

Here is `symfony-standard-composer-json.pp` example:

    # Filename: examples/symfony-standard-composer-json.pp
    filefetcher::fetch { 'Symfony Standard composer.json file':
        filename   => 'composer.json',
        target_dir => '/tmp',
        user       => 'vagrant',
        rights     => '744',
        url        => 'https://raw.githubusercontent.com/symfony/symfony-standard/2.7/composer.json',
    }

To run it use the following command:

    sudo puppet apply examples/symfony-standard-composer-json.pp

## Reference

The complete list of parameters is available in
[`manifests/fetch.pp`](https://github.com/pro-vagrant/puppet-filefetcher/blob/master/manifests/fetch.pp)
file.

## Limitations

The module was tested on:

* Ubuntu 12.04 / Puppet 3.7
* Ubuntu 14.04 / Puppet 3.7

## Development

The best method I have found so far to work on Puppet modules is:

* keep all modules in a single directory of your host (`host/some/dir`)
* create a Vagrant env in the dir that contains all the modules


```
    .
    ├── puppet-filefetcher
    │   ├── examples
    │   ├── Gemfile
    │   ├── LICENSE
    │   ├── manifests
    │   ├── metadata.json
    │   ├── pkg
    │   ├── Rakefile
    │   ├── README.md
    │   ├── spec
    │   ├── tests
    │   └── tmp
    ├── puppet-php_phars
    │   ├── examples
    │   ├── Gemfile
    │   ├── LICENSE
    │   ├── manifests
    │   ├── metadata.json
    │   ├── Rakefile
    │   ├── README.md
    │   ├── spec
    │   └── tests
    └── Vagrantfile
```

Then create symbolic links to modules:

    sudo ln -s /vagrant/puppet-filefetcher /etc/puppet/modules/filefetcher

Working this way you can test the module without:

* building
* installing
* uploading to the Puppet Forge

The command to check CS:

    puppet-lint manifests --no-autoloader_layout-check

The commands to build a module:

    rm -rf pkg/
    puppet module build

    sudo puppet module list
    sudo puppet module install gajdaw-filefetcher
    sudo puppet module install pkg/gajdaw-filefetcher-0.1.2.tar.gz
    sudo puppet module uninstall gajdaw-filefetcher

All the examples:

    sudo puppet apply examples/symfony-standard-composer-json.pp

## Inspiration

The inspiration came from
[`willdurrand-composer`](https://forge.puppetlabs.com/willdurand/composer)
authored
[by William Durand](https://github.com/willdurand/puppet-composer).
