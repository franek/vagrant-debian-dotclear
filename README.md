debian-dotclear
---------------

Ce dépôt contient des fichiers de configuration Vagrant et puppet permettant de lancer rapidement une VM contenant : 

 * apache2
 * php5
 * mysql
 * dotclear (non configuré, présence du script dotclear2-loader.php)
 * [behat] [4]

L'objectif de cette VM est de disposer d'un environnement de tests de dotclear.

Cette VM propose quelques tests fonctionnels s'appuyant sur Behat.

Pré-requis : 
--

 - [vagrant] [1]
 - [virtualbox] [2]
 - [veewee] [3]
 - une "basebox" debian-6.0.3

Pour créer une basebox debian-6.0.3 à jour, vous pouvez utiliser [veewee] [3] et les commandes suivantes (à éxécuter qu'une seule fois) : 

 - création du template permettant de créer une nouvelle VM debian (merci veewee) :

        vagrant basebox define debian-6.0.3 Debian-6.0.3-i386-netboot
 
 - construction de la VM (va lancer Virtualbox, installer l'OS selon les templates pré-définis par veewee) :

        vagrant basebox build debian-6.0.3

 - valider que la VM fonctionne correctement :

        vagrant basebox validate debian-6.0.3

 - exporter la VM pour vagrant :

        vagrant basebox export debian-6.0.3

 - ajouter la VM à la liste des VM disponibles par vagrant :

        vagrant box add 'debian-6.0.3' 'debian-6.0.3.box'

 - vérifier que vagrant a bien pris en compte cette nouvelle vox :
        
        vagrant box list


Usage :
--
 1. Cloner le dépôt
 2. Lancer la machine virtuelle : vagrant up
 3. Modifier le fichier /etc/hosts 
33.33.33.10 dotclear.local
 4. Depuis un navigateur, vous devriez accéder à l'interface d'installation de dotclear ([http://dotclear.local]). Vous pouvez ensuite suivre la procédure d'installation (par défaut, la base de données créée se nomme dotclear, user mysql = dotclear, mot de passe mysql = dotclear)

Si vous souhaitez recréer la VM, vous avez simplement à faire : 

 1. vagrant destroy
 2. vagrant up

Pour mettre en pause, votre VM  :

        vagrant suspend

Pour redémarrer la VM : 

        vagrant resume

Pour arrêter complètement la VM :

         vagrant halt

Pour lancer les tests behat : 

 - se connecter sur la VM : 

        vagrant ssh

 - lancer les tests : 

        cd behat-dotclear
        behat

Pour réinitialiser l'environnement (suppression de la base, suppression des fichiers, ...), il est possible de demander à puppet de réexécuter le "provisonning) (commande à éxécuter depuis la machine hôte) :

        vagrant provision


A propos de Behat
--

Les tests behat sont écrits en français (/franglais). Il serait plus pertinent de les écrire en anglais.

A faire : 
--
 - Récupérer Dotclear depuis Mercurial
 - améliorer le Virtual Host de apache :
   * ajouter les rewriting rules
   * ajouter la compression gzip sur les fichiers statiques
   * ajouter les entêtes HTTP
 - améliorer la configuration de PHP
 - ajouter xhprof, xdebug ...
 - ajouter des tests fonctionnels (behat) permettant de valider la procédure d'installation

[1]: http://vagrantup.com/
[2]: https://www.virtualbox.org/
[3]: https://github.com/jedi4ever/veewee
[4]: http://behat.org/
