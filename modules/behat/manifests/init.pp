class behat {
    # 
    # Installation de behat via pear
    #
    package { [ "php-pear" ]:
    ensure => present,
    require => Package['php5'],
    }

    exec { "sudo pear upgrade-all" :
    path => "/usr/bin:/usr/sbin:/bin",
    require => Package['php-pear'],
    }

    exec { "sudo pear channel-discover pear.symfony.com" :
    path => "/usr/bin:/usr/sbin:/bin",
    require => Package['php-pear'],
    }
    exec { "sudo pear channel-discover pear.behat.org"  :
    path => "/usr/bin:/usr/sbin:/bin",
    require => Package['php-pear'],
    }
    exec { "sudo pear install behat/behat" :
    path => "/usr/bin:/usr/sbin:/bin",
    require => Package['php-pear'],
    }
    exec { "sudo pear install behat/mink-beta" :
    path => "/usr/bin:/usr/sbin:/bin",
    require => Package['php-pear'],
    }

    exec { "sudo pear channel-discover pear.phpunit.de" :
    path => "/usr/bin:/usr/sbin:/bin",
    require => Package['php-pear'],
    }

    exec { "sudo pear channel-discover components.ez.no" :
    path => "/usr/bin:/usr/sbin:/bin",
    require => Package['php-pear'],
    }

    exec { "sudo pear channel-discover pear.symfony-project.com" :
    path => "/usr/bin:/usr/sbin:/bin",
    require => Package['php-pear'],
    }

    exec { "sudo pear install phpunit/PHPUnit" :
    path => "/usr/bin:/usr/sbin:/bin",
    require => Package['php-pear'],
    }
}
