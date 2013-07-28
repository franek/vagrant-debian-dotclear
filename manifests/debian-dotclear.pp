# mot de passe root utilisé par la classe mysql
$mysql_root_password = "admin"

# paramètres utilisées par la classe dotclear
# - db_user : identifiant mysql
# - db_password : mot de passe mysql
# - name : nom de la base de données
$dotclear_db_user = "dotclear"
$dotclear_db_password = "dotclear"
$dotclear_db_name = "dotclear"

#
# Puppet
# 
group { "puppet":
    ensure => "present",
}

#
# Définition des droits par défaut sur les fichiers
#
File { owner => 0, group => 0, mode => 0644 }


#
# Permet de vérifier que puppet fonctionne
#
file { '/etc/motd':
        content => "Welcome to your Vagrant-built virtual machine!
                Managed by Puppet.\n"
}

define line($file, $line, $ensure = 'present') {
    case $ensure {
        default : { err ( "unknown ensure value ${ensure}" ) }
        present: {
            exec { "/bin/echo '${line}' >> '${file}'":
                unless => "/bin/grep -qFx '${line}' '${file}'"
            }
        }
        absent: {
            exec { "/bin/grep -vFx '${line}' '${file}' | /usr/bin/tee '${file}' > /dev/null 2>&1":
              onlyif => "/bin/grep -qFx '${line}' '${file}'"
            }

            # Use this resource instead if your platform's grep doesn't support -vFx;
            # note that this command has been known to have problems with lines containing quotes.
            # exec { "/usr/bin/perl -ni -e 'print unless /^\\Q${line}\\E\$/' '${file}'":
            #     onlyif => "/bin/grep -qFx '${line}' '${file}'"
            # }
        }
    }
}

#
# Vérifie que le fichier /etc/hosts a bien été modifié
#
line { "modify /etc/hosts" : 
   file => "/etc/hosts",
   line => "33.33.33.10 dotclear.local",
   ensure => "present"
}


# Run apt-get update when anything beneath /etc/apt/ changes
# source http://blog.kumina.nl/2010/11/puppet-tipstricks-running-apt-get-update-only-when-needed/
exec { "apt-get update":
    command => "/usr/bin/apt-get update",
    onlyif => "/bin/sh -c '[ ! -f /var/cache/apt/pkgcache.bin ] || /usr/bin/find /etc/apt/* -cnewer /var/cache/apt/pkgcache.bin | /bin/grep . > /dev/null'",
}

package { "libaugeas-ruby":
        ensure => present;
    }


#
# Installation de mysql et initialisation du compte root
#
include mysql::server

#
# Installation de apache et php5
#
include apache

#
# Installation de phpmyadmin
#
include phpmyadmin

#
# Installation de behat (pear, phpunit, behat)
#
include behat

#
# Installation de dotclear
#  - création de la base de données
#  - récupération du script d'installation
#
include dotclear
