filefetcher::fetch { 'phpunit':
    url => 'https://phar.phpunit.de/phpunit.phar',
}

filefetcher::fetch { 'composer':
    url => 'https://getcomposer.org/composer.phar',
}

filefetcher::fetch { 'php-cs-fixer':
    url => 'http://cs.sensiolabs.org/get/php-cs-fixer.phar',
}

filefetcher::fetch { 'box':
    url => 'https://github.com/box-project/box2/releases/download/2.5.0/box-2.5.0.phar',
}

filefetcher::fetch { 'symfony':
    url => 'http://symfony.com/installer',
}

# to be done
#
#$phars = [
#    {
#        name => 'box',
#        url => 'https://github.com/box-project/box2/releases/download/2.5.0/box-2.5.0.phar'
#    },
#    {
#        name => 'phpunit',
#        url => 'https://phar.phpunit.de/phpunit.phar'
#    }
#]
#
#filefetcher::fetch { $phars: }
