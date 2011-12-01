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
    exec { "create-${name}-db":
        unless => "/usr/bin/mysql -uroot ${name}",
        command => "/usr/bin/mysql -uroot -e \"create database ${name};\"",
        require => Service["mysql"],
    }

    exec { "grant-${name}-db":
        unless => "/usr/bin/mysql -u${user} -p${password} ${name}",
        command => "/usr/bin/mysql -uroot -e \"grant all on ${name}.* to ${user}@localhost identified by '$password';\"",
        require => [Service["mysql"], Exec["create-${name}-db"]]
    }
}

