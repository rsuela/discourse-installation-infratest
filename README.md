# Discourse Installation Repository

discourse-installationvm-infratest is a repository for vagrant and puppet scripts. The scripts will install dependencies for discourse.
Then, Install discourse application on Linux ubuntu trusty.

* Rey Angelo Suela(<rsuela@gmail.com>)

# Installation
Unfortunately, The module has been tested using Windows Platform only.
* VirtualBox 4.3.20
* Vagrant 1.7.2

# Dependencies 
Already taken care-of via vagrant_provision.sh
* puppetlabs/stdlib
* puppetlabs/apt
* puppetlabs/concat
* stahnma/epel
* puppetlabs-ruby
* dwerder-redis
* jfryman-nginx
* puppetlabs-postgresql
* puppetlabs-vcsrepo
* garethr-docker

# How to run
```commandline
vagrant up
```

# Troubleshooting
- One of the issues that i keep getting is when there is a problem while downloading dependencies from Ubuntu.
  solution: if the machine is already created: you can run by using 'vagrant provision'

