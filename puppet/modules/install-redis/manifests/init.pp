class install-redis {
    class { 'redis::install':
      redis_version     => '2.6.17',
      redis_build_dir   => '/opt',
      redis_install_dir => '/usr/bin',
    }
}