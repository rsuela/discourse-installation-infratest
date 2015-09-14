class install-discourse{

    $sysPackages = [ "lxc", "wget", "bsdtar"]
    package { $sysPackages:
        ensure  => "installed",
    }
    
    $linuximage = "linux-image-extra-${kernelrelease}"
    package { $linuximage:
        ensure  => "installed",
    }
  
    exec { 'modprobe auf':
        command     => 'modprobe aufs',
        path        => '/usr/bin:/bin:/sbin;/sbin/bin:/sbin:/usr/sbin',
        require     => Package[ $linuximage ],
    }
    
    # install-docker
    exec { 'install-docker':
        command     => 'wget -qO- https://get.docker.io/ | sh',
        path        => '/usr/bin:/bin:/sbin;/sbin/bin:/sbin:/usr/sbin',
        require     => Exec[ 'modprobe auf' ],
        timeout     => 1200,
    }
    
    file { '/etc/default/docker':
      ensure => present,
      require => Exec['install-docker']
    }->
    file_line { 'google dns':
      path => '/etc/default/docker',
      line => 'DOCKER_OPTS="--dns 8.8.8.8 --dns 8.8.4.4"',
      match   => "#DOCKER_OPTS=",
    }
    
    # create folder /opt/discourse
    exec { 'discourse-home-dir':
        command     => 'mkdir /opt/discourse',
        path        => '/usr/bin:/bin:/sbin',
        require     => File['/etc/default/docker'],
    }
    
    # git clone discourse repo
    vcsrepo { '/opt/discourse':
      ensure   => present,
      provider => git,
      source   => 'https://github.com/discourse/discourse_docker.git',
      require  => Exec[ 'discourse-home-dir' ],
    }

    exec { 'copy-standalone-yml':
        command     => 'cp -f /tmp/vagrant-puppet/module**/install-discourse/templates/app.yml /opt/discourse/containers/app.yml',
        path        => '/usr/bin:/bin:/sbin;/sbin/bin:/sbin:/usr/sbin',
        require     => Vcsrepo[ '/opt/discourse' ],
    }
    
    
    exec { 'launch bootstrap':
        command     => 'sudo /opt/discourse/launcher bootstrap app',
        path        => '/usr/bin:/bin:/sbin;/sbin/bin:/sbin:/usr/sbin',
        require     => Exec[ 'copy-standalone-yml' ],
        timeout     => 0, # estimated time to complete
    }
    
    exec { 'launch start':
        command     => 'sudo /opt/discourse/launcher start app',
        path        => '/usr/bin:/bin:/sbin;/sbin/bin:/sbin:/usr/sbin',
        require     => Exec[ 'launch bootstrap' ],
        timeout     => 0, # estimated time to complete
    }

}