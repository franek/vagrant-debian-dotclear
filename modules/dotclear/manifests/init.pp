class dotclear {
    #
    # Installation de dotclear
    #
    file { "/var/www/dotclear.local" :
        ensure => "directory",
        mode => "0777",
        require => Service['apache2']
    }

    file { "/var/www/dotclear.local/public" :
        ensure => "directory",
        mode => "0777",
        require => File['/var/www/dotclear.local']
    }

    exec { "get dotclear" :
        cwd => "/var/www/dotclear.local/public",
        command => "wget http://download.dotclear.net/loader/dotclear2-loader.php",
        path => "/usr/bin:/usr/sbin:/bin",
        require => File['/var/www/dotclear.local/public'],
        logoutput => 'true'
    }

    #
    # Création d'une bdd
    #
    mysql::db { $dotclear_db_name:
        user => $dotclear_db_user,
        password => $dotclear_db_password,
    }
}
