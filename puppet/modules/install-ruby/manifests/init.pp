class install-ruby{
    include apt
    apt::ppa{'ppa:brightbox/ruby-ng-experimental':}
    class{'ruby':
        version         => '2.0.0',
        switch          => true,
        latest_release  => true,
        #require         => Apt:Ppa['ppa:brightbox/ruby-ng-experimental'],
    }
}