#!/bin/sh
# Shell script to provision the vagrant box

# update ubuntu
apt-get update
apt-get upgrade -y

# Install git
apt-get install -y git

if [ ! -f /tmp/isSwapAdded ]
  then
    echo "/var/log/messages exists."
    Add swapfile to increase 2GB memory of discourse
    install -o root -g root -m 0600 /dev/null /swapfile
    dd if=/dev/zero of=/swapfile bs=1k count=2048k
    mkswap /swapfile
    swapon /swapfile
    echo "/swapfile       swap    swap    auto      0       0" | sudo tee -a /etc/fstab
    sysctl -w vm.swappiness=10
    echo vm.swappiness = 10 | sudo tee -a /etc/sysctl.conf
    echo "swap added" | sudo tee -a /tmp/isSwapAdded
fi

# required package in ubuntu
apt-get -y install build-essential libssl-dev libyaml-dev libtool libxslt-dev 
apt-get -y install libxml2-dev libpq-dev gawk curl pngcrush imagemagick software-properties-common
apt-get -y install libreadline6-dev libsqlite3-dev sqlite3 autoconf libgdbm-dev libncurses5-dev 
apt-get -y install bison libffi-dev pkg-config

# Add common puppet modules
puppet module install puppetlabs/stdlib
puppet module install puppetlabs/apt
puppet module install puppetlabs/concat
puppet module install stahnma/epel
puppet module install puppetlabs-ruby
puppet module install dwerder-redis
puppet module install jfryman-nginx
puppet module install puppetlabs-postgresql
puppet module install puppetlabs-vcsrepo
puppet module install garethr-docker

# Install the gpg key manually
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 573BFD6B3D8FBC641079A6ABABF5BD827BD9BF62