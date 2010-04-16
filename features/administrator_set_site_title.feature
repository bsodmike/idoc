Feature:
  In order to allow iDoc installations to be customised
  As an administrator
  I want to be able to set a global value for the site title.

  Scenario: An administrator sets the site title on the admin config page
    Given I am identified as an administrator
    When I go to the edit site configuration page
    And I fill in "Site Title" with "Testing site title"
    And I press "Save configuration"
    Then I should be on the site configuration page
    And I should see "Configuration saved"
    And I should see the title set to "Testing site title" 