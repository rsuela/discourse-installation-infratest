class install-nginx {
    class { 'nginx': }
    
    exec { 'add-nginx-key':
        command  => 'curl http://nginx.org/keys/nginx_signing.key | sudo apt-key add -',
        path     => '/usr/bin:/bin:/sbin',
    }
}