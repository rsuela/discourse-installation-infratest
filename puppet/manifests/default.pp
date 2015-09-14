class{ 'install-ruby':}
class{ 'install-redis':
    require => Class['install-ruby'],
}
class{ 'install-nginx':
    require => Class['install-redis'],
}
class{ 'install-postgresql':
    require => Class['install-nginx'],
}
class{ 'install-discourse':
    require => Class['install-postgresql'],
}

info("discourse installation is successful.")