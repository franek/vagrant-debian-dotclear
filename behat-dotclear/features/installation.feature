# language: fr
# C'est du franglais... ;-)
# features/installation.feature
Fonctionnalité: Installation de dotclear 
  Afin d'installer dotclear, 
  En tant qu'utilisateur du site
  je dois pouvoir valider les différents formulaires

  Scénario: Redirection sur le wizard
    Etant donné I am on "/"
    Quand I reload the page
    Alors the url should match "/admin/install/wizard.php"

  Scénario: Erreur sur le wizard si les champs ne sont pas remplis
    Etant donné I am on "/admin/install/wizard.php"
    Quand je presse "Continue"
    Alors l'élement "div.error" devrait contenir "<p><strong>Errors:</strong></p><p>Unable to connect to database</p>"

  Scénario: Installation réussie
    Etant donné I am on "/admin/install/wizard.php"
    Quand I fill in the following:
    | DBDRIVER | mysql |
    | DBHOST | localhost |
    | DBNAME | dotclear |
    | DBUSER | dotclear |
    | DBPASSWORD | dotclear |
    | DBPREFIX | dc_ |
    Et je presse "Continue"
    Alors l'élement "p.message" devrait contenir "Configuration file has been successfully created."
    Etant donné I am on "/admin/install/index.php?wiz=1"
    Quand I fill in the following:
    | u_firstname | Super |
    | u_name | admin |
    | u_email | admin@dotclear.local |
    | u_login | admin |
    | u_pwd | admin23 |
    | u_pwd2 | admin23 |
    Et je presse "Save"
    Alors l'élement "#main h2" devrait contenir "All done!"
    Etant donné I am on "/admin/auth.php"
    Quand I fill in the following:
    | user_id | admin |
    | user_pwd | admin23 |
    Et je presse "log in"
    Alors I should be on "/admin/index.php"
