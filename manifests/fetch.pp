# == Define: filefetcher
#
# The defined resource to download files and set ownership/rights.
#
# === Parameters
#
# [*url*]
#   URL of the file to be downloaded.
#   Required: no default value.
#
# [*target_dir*]
#   The directory in which the downloaded file will be stored.
#   Defaults to: '/usr/local/bin'
#
# [*user*]
#   The owner of the box executable.
#   Defaults to: 'root'
#
# [*rights*]
#   The rights for the newly created file.
#   Defaults to: 'a+x'
#
# [*filename*]
#   The name of the newly created file.
#   Defaults to: the name of the resource.
#
# [*redownload*]
#   Boolean flag to force redownload if the file already exists.
#   Defaults to: false
#
#
# == Example:
#
# Installing phpunit with default settings:
#
#     filefetcher::fetch { 'phpunit':
#         url => 'https://phar.phpunit.de/phpunit.phar',
#     }
#
# Copying Symfony Standard composer.json file:
#
#  filefetcher::fetch { 'Symfony Standard composer.json file':
#      filename   => 'composer.json',
#      target_dir => '/tmp',
#      owner      => 'vagrant',
#      rights     => '644'
#      url        => 'https://raw.githubusercontent.com/symfony/symfony-standard/2.7/composer.json',
#  }
#
# === Authors
#
# Włodzimierz Gajda <gajdaw@gajdaw.pl>
#
# === Copyright
#
# Copyright 2015 Włodzimierz Gajda
#

define filefetcher::fetch (
  $url,
  $target_dir = undef,
  $user       = undef,
  $rights     = undef,
  $filename   = undef,
  $redownload = undef
) {

  include filefetcher::params

  $filefetcher_target_dir = $target_dir ? {
    undef   => $::filefetcher::params::target_dir,
    default => $target_dir
  }

  $filefetcher_user = $user ? {
    undef   => $::filefetcher::params::user,
    default => $user
  }

  $filefetcher_rights = $rights ? {
    undef   => $::filefetcher::params::rights,
    default => $rights
  }

  $filefetcher_filename = $filename ? {
    undef   => $name,
    default => $filename
  }

  $filefetcher_redownload = $redownload ? {
    undef   => $::filefetcher::params::redownload,
    default => $redownload
  }

  wget::fetch { "wget::fetch ${name}":
    source      => $url,
    destination => "${filefetcher_target_dir}/${filefetcher_filename}",
    execuser    => $filefetcher_user,
    redownload  => $filefetcher_redownload,
  }

  exec { "fix permissions ${name}":
    command => "chmod ${$filefetcher_rights} ${filefetcher_filename}",
    path    => '/usr/bin:/bin:/usr/sbin:/sbin',
    cwd     => $filefetcher_target_dir,
    user    => $filefetcher_user,
    require => Wget::Fetch["wget::fetch ${name}"],
  }

}