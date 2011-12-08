class behat {
    # 
    # Installation de behat via pear
    #
    package { [ "php-pear" ]:
        ensure => present,
        require => [ Exec["apt-get update"], Package['php5'], Package["php5-curl"] ],
    }

    exec { "sudo pear upgrade-all" :
    path => "/usr/bin:/usr/sbin:/bin",
    require => Package['php-pear'],
    }

    exec { "sudo pear channel-discover pear.symfony.com" :
        path => "/usr/bin:/usr/sbin:/bin",
        unless => "sudo pear list-channels | grep symfony2",
        require => Package['php-pear'],
    }

    exec { "sudo pear channel-discover pear.behat.org"  :
        path => "/usr/bin:/usr/sbin:/bin",
        unless => "sudo pear list-channels | grep behat",
        require => Package['php-pear']
    }

    exec { "sudo pear channel-discover pear.phpunit.de" :
        path => "/usr/bin:/usr/sbin:/bin",
        unless => "sudo pear list-channels | grep phpunit",
        logoutput => "true",
        require => Package['php-pear'],
    }

    exec { "sudo pear channel-discover components.ez.no" :
        path => "/usr/bin:/usr/sbin:/bin",
        unless => "sudo pear list-channels | grep 'components.ez.no'",
        logoutput => "true",
        require => Package['php-pear'],
    }

    exec { "sudo pear channel-discover pear.symfony-project.com" :
        path => "/usr/bin:/usr/sbin:/bin",
        unless => "sudo pear list-channels | grep 'pear.symfony-project.com'",
        logoutput => "true",
        require => Package['php-pear'],
    }

    exec { "sudo pear install behat/behat" :
        path => "/usr/bin:/usr/sbin:/bin",
        logoutput => "true",
        unless => "sudo pear list -a | grep 'behat'",
        require => [ Package['php-pear'], Exec["sudo pear channel-discover pear.behat.org"] ]
    }

    exec { "sudo pear install behat/mink-beta" :
        path => "/usr/bin:/usr/sbin:/bin",
        logoutput => "true",
        unless => "sudo pear list -a | grep -i 'mink'",
        require => [Package['php-pear'], Exec["sudo pear install behat/behat"]]
    }

    exec { "sudo pear install --alldeps phpunit/PHP_CodeCoverage" :
        path => "/usr/bin:/usr/sbin:/bin",
        logoutput => "true",
        unless => "sudo pear list -a | grep 'PHP_CodeCoverage '",
        timeout => "0",
        require => [ Package['php-pear'], Exec["sudo pear channel-discover pear.phpunit.de"] ]
    }

    exec { "sudo pear install --alldeps phpunit/PHPUnit_MockObject" :
        path => "/usr/bin:/usr/sbin:/bin",
        logoutput => "true",
        unless => "sudo pear list -a | grep 'PHPUnit_MockObject '",
        require => [ Package['php-pear'], Exec["sudo pear channel-discover pear.phpunit.de"] ]
    }

    exec { "sudo pear install --alldeps phpunit/phpunit" :
        path => "/usr/bin:/usr/sbin:/bin",
        logoutput => "true",
        unless => "sudo pear list -a | grep 'PHPUnit '",
        tries => "3",
        timeout => "120",
        require => [ Package['php-pear'], Exec["sudo pear channel-discover pear.phpunit.de"] ]
    }
}
