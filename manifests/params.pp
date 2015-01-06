# = Class: filefetcher::params
#
# This class defines default parameters used by the main module
# class `filefetcher`.
#
# == Variables:
#
# Refer to `filefetcher` class for the variables defined here.
#
# == Usage:
#
# This class is not intended to be used directly.
# It may be imported or inherited by other classes.
#
class filefetcher::params {
  $target_dir = '/usr/local/bin'
  $user       = 'root'
  $rights     = 'a+x'
  $redownload = false
}
