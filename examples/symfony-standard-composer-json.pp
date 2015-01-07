filefetcher::fetch { 'Symfony Standard composer.json file':
    filename   => 'composer.json',
    target_dir => '/tmp',
    user       => 'vagrant',
    rights     => '644',
    url        => 'https://raw.githubusercontent.com/symfony/symfony-standard/2.7/composer.json',
}
