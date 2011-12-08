# features/dotclear-loader.feature
Feature: Dotclear installation with dotclear2-loader
  In order to install dotclear, 
  We can use the script dotclear2-loader.php 
  which will download and start the installation procedure

  Scenario: Test that the script dotclear2-loader.php is ok
    Given I am on "/dotclear2-loader.php"
    When I fill in "destination" with ""
    And I press "Retrieve and unzip Dotclear 2"
    Then the response should not contain "Not Found"
    And the response should contain "Everything went fine. You are now ready to start the installation procedure."

  Scenario: 
    Given I am on "/"
    When I reload the page
    Then the url should match "/admin/install/wizard.php"

