Feature:
  In order to build useful documentation
  As a user
  I need to add new documentation pages

  @wip
  Scenario: Create the first documentation page
    Given there is no documentation
    And I am on the home page
    When I enter documentation
    And I press "Save"
    Then I should see "Page added"
    And I should see the documentation page
    And I should see the menu item for the page

  @wip
  Scenario: Create more documentation
    Given I have created a page
    When I go to the create documentation page
    And I enter documentation
    And I press "Save"
    Then I should see "Page added"
    And I should see the documentation page
    And I should see the menu item for the page
