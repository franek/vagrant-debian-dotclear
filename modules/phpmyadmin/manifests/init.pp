# 
# Installation de phpmyadmin
#
class phpmyadmin {   
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
        require => Package [ "apache2-mpm-prefork" ]
    }
}
