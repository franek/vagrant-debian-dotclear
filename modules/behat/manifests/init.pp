class behat {
    # 
    # Installation de behat via pear
    #
    package { [ "php-pear" ]:
        ensure => present,
        require => [ Exec["apt-get update"], Package['php5'], Package["php5-curl"] ],
    }
    
    package { [ "git" ]:
        ensure => present,
        require => [ Exec["apt-get update"] ],
    }
    
        
    file { "/home/vagrant/composer.json":
        owner => "vagrant", 
        group => "vagrant",
        source => "puppet:///modules/behat/composer.json",
    }
    
    exec { "composer.phar" :
        command => "curl http://getcomposer.org/installer | php && rm -f composer.lock && export COMPOSER_HOME=/home/vagrant && php composer.phar install",
        cwd => "/home/vagrant",
        path    => ["/bin", "/usr/bin", "/usr/sbin"],
        require => [ Package["php5"], File["/home/vagrant/composer.json"], Package["git"] ],
    }
    
    augeas { "php.ini":
      context => "/files/etc/php5/cli/php.ini/PHP",
      changes => [
        "set include_path .:/usr/share/php:/home/vagrant/vendor"
#        "set upload_max_filesize 10M",
      ],
      require => [Package["php5"], Package["libaugeas-ruby"] ];
    }
}
