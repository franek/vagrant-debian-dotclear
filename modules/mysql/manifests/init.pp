#
# Installation de mysql
# Largement inspiré de http://bitfieldconsulting.com/puppet-and-mysql-create-databases-and-users
#
class mysql::server {
  
  package { ["mysql-server"] : 
    ensure => installed 
  }

  service { "mysql":
    enable => true,
    ensure => running,
    require => Package["mysql-server"],
  }

  file { "/var/lib/mysql/my.cnf":
    owner => "mysql", group => "mysql",
    source => "puppet:///mysql/my.cnf",
    notify => Service["mysql"],
    require => Package["mysql-server"],
  }
 
  file { "/etc/my.cnf":
    require => File["/var/lib/mysql/my.cnf"],
    ensure => "/var/lib/mysql/my.cnf",
  }

  exec { "set-mysql-password":
    unless => "mysqladmin -uroot -p$mysql_root_password status",
    path => ["/bin", "/usr/bin"],
    command => "mysqladmin -uroot password $mysql_root_password",
    require => Service["mysql"],
  }

}

define mysql::db( $user, $password ) {
    # 
    # On supprime la base de donnée si elle existe
    # 
    exec { "drop-${name}-db":
        command => "/usr/bin/mysql -uroot -p${mysql_root_password} -e \"drop database ${name};\"",
        require => [Service["mysql"], Package["mysql-server"] ],
        onlyif  => "/usr/bin/mysql -uroot -p${mysql_root_password} --execute=\"SHOW DATABASES;\" | grep -x '${name}'",
    }

    exec { "create-${name}-db":
        command => "/usr/bin/mysql -uroot -p${mysql_root_password} -e \"create database ${name};\"",
        unless  => "/usr/bin/mysql -uroot -p${mysql_root_password} --execute=\"SHOW DATABASES;\" | grep -x '${name}'",
        logoutput => "true",
        require => [ Service["mysql"], Package["mysql-server"], Exec["set-mysql-password"] ]
    }

    exec { "grant-${name}-db":
        unless => "/usr/bin/mysql -u${user} -p${password} ${name}",
        command => "/usr/bin/mysql -uroot -p${mysql_root_password} -e \"grant all on ${name}.* to ${user}@localhost identified by '$password';\"",
        require => [Service["mysql"], Exec["create-${name}-db"]]
    }

}

