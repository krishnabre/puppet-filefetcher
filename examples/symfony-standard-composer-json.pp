filefetcher::fetch { 'Symfony Standard composer.json file':
    filename   => 'composer.json',
    target_dir => '/tmp',
    user       => 'vagrant',
    rights     => '755',
    url        => 'https://raw.githubusercontent.com/symfony/symfony-standard/2.7/composer.json',
}
