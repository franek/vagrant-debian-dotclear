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
