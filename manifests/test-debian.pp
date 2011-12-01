group { "puppet":
    ensure => "present",
}

File { owner => 0, group => 0, mode => 0644 }
file { '/etc/motd':
        content => "Welcome to your Vagrant-built virtual machine!
                Managed by Puppet.\n"
}

#
# Génère les certificats
# uniquement s'ils ne sont pas d�j� pr�sent
# --
exec { "generate certificate":
  path => "/usr/bin:/usr/sbin:/bin",
  command => "puppetca --generate `hostname`",
  creates => "/var/lib/puppet/ssl/certs/localhost.localdomain.pem"
}

# 
# Installation de Apache et PHP5
#
package { [ "apache2-mpm-prefork", "php5", "php5-curl", "libapache2-mod-php5", "php5-mysql" ]:
    ensure => present;
}

# 
# Installation de Mysql
#


# 
# Installation de phpmyadmin
#
package { [ "phpmyadmin" ]:
    ensure => present;
}

file { [ "/etc/apache2/sites-enabled/001-phpmyadmin" ] :
    ensure => link,
    target => "/etc/phpmyadmin/apache.conf",
    require => Package['phpmyadmin'],
}

exec { "sudo apache2ctl graceful" :
    path => "/usr/bin:/usr/sbin:/bin",
}


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
