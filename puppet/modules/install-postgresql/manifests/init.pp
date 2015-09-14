class install-postgresql {
    class { 'postgresql::server': }
    
    # create discourse user in postgres
    exec { 'create-psql-discourse-user':
        command  => 'sudo -u postgres createuser -s discourse',
        path     => '/usr/bin:/bin:/sbin',
    }
    
    postgresql::server::db { 'mydatabasename':
      user     => 'discourse',
      password => postgresql_password('discourse', 'discourse'),
    }
}