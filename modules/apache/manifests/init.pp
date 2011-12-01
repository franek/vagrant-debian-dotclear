# 
# Installation de Apache et PHP5
#
class apache {
    package { 
        [ "apache2-mpm-prefork", "apache2-utils", "php5", "php5-curl", "libapache2-mod-php5", "php5-mysql" ]:
        ensure => present;
    }

    service { [ "apache2" ] :
        enable => true,
        ensure => running,
        require => Package["apache2-mpm-prefork"],
    }

    file { [ "/etc/apache2/sites-available/dotclear.local" ] :
        source => "puppet:///apache/dotclear.local",
        notify => Service["apache2"],
    }

    exec { [ "sudo a2ensite dotclear.local"] : 
      path => "/usr/bin:/usr/sbin:/bin",
      notify => Service["apache2"],
      require => File["/etc/apache2/sites-available/dotclear.local"]
    }
}
