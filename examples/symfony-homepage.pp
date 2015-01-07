filefetcher::fetch { 'Symfony Homepage':
    filename   => 'symfony-homepage',
    target_dir => '/tmp',
    user       => 'vagrant',
    rights     => '644',
    url        => 'http://symfony.com',
    redownload => true,
}
