# language: fr
# features/dotclear-loader.feature
Fonctionnalité: Installation de dotclear via le script de téléchargement
  Afin d'installer dotclear, 
  En tant qu'utilisateur du site
  je dois pouvoir télécharger dotclear afin de l'installer

  Scénario: Test du téléchargement via dotclear2-loader
    Etant donné I am on "/dotclear2-loader.php"
    Quand je remplis "destination" avec ""
    Et je presse "Retrieve and unzip Dotclear 2"
    Alors the response should not contain "Not Found"
    Et the response should contain "Everything went fine. You are now ready to start the installation procedure."

  Scénario: 
    Etant donné I am on "/"
    Quand I reload the page
    Alors the url should match "/admin/install/wizard.php"

