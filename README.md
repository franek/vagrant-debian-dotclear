debian-dotclear
---------------

Ce dépôt contient des fichiers de configuration Vagrant et puppet permettant de lancer rapidement une VM contenant : 

 * apache2
 * php5
 * mysql
 * dotclear (non configuré, présence du script dotclear2-loader.php)
 * [behat] [4]

L'objectif de cette VM est de créer rapidement un environnement de tests de dotclear afin de pouvoir recharcher un backup ou lancer des tests fonctionnels.

Cette VM propose quelques tests fonctionnels s'appuyant sur Behat permettant par exemple de lancer l'installation de dotclear de manière automatique à partir du script dotclear-loader.php

Pré-requis : 
--

 - [vagrant] [1]
 - [virtualbox] [2]
 - quelques plugins pour vagrant : 
   - vagrant-cachier : permettant de mettre en cache les fichiers d'installation de la VM afin de réduire le temps de la construction de la VM
   - vagrant-vbguest : permet de mettre à jour les VirtualBox Guests
   
Pour installer les plugins vagrant : 

        host > vagrant plugin install <nom du plugin>   

Usage :
--
 0. Installer les pré-requis
 1. Cloner le dépôt
 2. Lancer la machine virtuelle : 
 
        host > cd vagrant-debian-dotclear
        host > vagrant up (cette commande prend environ 5-10 minutes selon votre connexion)
    
 3. Modifier le fichier /etc/hosts (sous Linux) ou c:\Windows\System32\drivers\etc\hosts (sous Windows)
 
        33.33.33.10 dotclear.local
    
 4. Depuis un navigateur, vous devriez accéder à l'interface d'installation de dotclear ([http://dotclear.local/dotclear2-loader.php]). 
 
 
Installation de dotclear dans VM :
--------------------------------

 Vous pouvez suivre la procédure d'installation (par défaut, la base de données créée se nomme dotclear, user mysql = dotclear, mot de passe mysql = dotclear) depuis [http://dotclear.local/dotclear2-loader.php] ou automatiquement via behat : 
 
         host > vagrant ssh
         guest > cd behat-dotclear
         guest > ../bin/behat
         # puis dirigez vous à l'adresse [http://dotclear.local] où dotclear devrait être installé.


Recréer complétement l'environnement :
--------------------------------------

A tout moment, vous pouvez recréer la VM, vous avez simplement à faire : 

        host > vagrant destroy
        host > vagrant up

Mettre en pause, votre VM  :
----------------------------

        host > vagrant suspend

Pour redémarrer la VM :
-----------------------

        host > vagrant resume
        host > vagrant up --no-provision

Arrêter complètement la VM :
----------------------------

         host > vagrant halt


Lancer les tests behat : 
------------------------

 - se connecter sur la VM : 

        host > vagrant ssh

 - lancer les tests : 

        guest > cd behat-dotclear
        guest > ../bin/behat

Réinitialiser la VM (installation de dotclear) :
------------------------------------------------

Pour réinitialiser l'environnement (suppression de la base de données, suppression de l'installation de dotclear, ...), il est possible de demander à puppet de réexécuter le "provisonning) (commande à éxécuter depuis la machine hôte) :

        host > vagrant provision


A faire : 
--
 - Récupérer Dotclear depuis Mercurial
 - Charger automatiquement un backup de dotclear si celui-ci a été placé dans un répertoire bien défini.
 - améliorer le Virtual Host de apache :
   * ajouter les rewriting rules
   * ajouter la compression gzip sur les fichiers statiques
   * ajouter les entêtes HTTP
 - améliorer la configuration de PHP
 - ajouter xhprof, xdebug ...
 

[1]: http://vagrantup.com/
[2]: https://www.virtualbox.org/
[4]: http://behat.org/
