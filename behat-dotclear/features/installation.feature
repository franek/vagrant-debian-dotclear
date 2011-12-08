# features/installation.feature
Feature: Dotclear installation with the wizard
  In order to install Dotclear, 
  En tant qu'utilisateur du site
  We need to be able to validate each form of the wizard

  Scenario: Wizard redirection
    Given I am on "/"
    When I reload the page
    Then the url should match "/admin/install/wizard.php"

  Scenario: The wizard should send an error message if fields are empty
    Given I am on "/admin/install/wizard.php"
    When I press "Continue"
    Then the "div.error" element should contain "<p><strong>Errors:</strong></p><p>Unable to connect to database</p>"

  Scenario: Proceed installation
    Given I am on "/admin/install/wizard.php"
    When I fill in the following:
    | DBDRIVER | mysql |
    | DBHOST | localhost |
    | DBNAME | dotclear |
    | DBUSER | dotclear |
    | DBPASSWORD | dotclear |
    | DBPREFIX | dc_ |
    And I press "Continue"
    Then the "p.message" element should contain "Configuration file has been successfully created."
    Given  I am on "/admin/install/index.php?wiz=1"
    Then I fill in the following:
    | u_firstname | Super |
    | u_name | admin |
    | u_email | admin@dotclear.local |
    | u_login | admin |
    | u_pwd | admin23 |
    | u_pwd2 | admin23 |
    And I press "Save"
    Then the "#main h2" element should contain "All done!"
    Given I am on "/admin/auth.php"
    Then I fill in the following:
    | user_id | admin |
    | user_pwd | admin23 |
    And I press "log in"
    Then I should be on "/admin/index.php"
