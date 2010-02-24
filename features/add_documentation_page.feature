Feature:
  In order to build useful documentation
  As a Document Author
  I need to add new documentation pages

  Scenario: Create the first documentation page when identified
    Given I am identified
    And there is no documentation
    And I am on the home page
    When I enter documentation
    And I press "Save"
    Then I should see "Page added"
    And I should see the documentation page
    And I should see the menu item for the page

  Scenario: Create more documentation when identified
    Given I am identified
    And I have created a page
    When I go to the add documentation page
    And I enter documentation
    And I press "Save"
    Then I should see "Page added"
    And I should see the documentation page
    And I should see the menu item for the page

  Scenario: Attempt to create a documentation page without a title
    Given I am identified
    When I go to the add documentation page
    And I enter documentation without a title
    And I press "Save"
    Then I should be on the documentation page
    And I should see "Title can't be blank"
    And I should see the page body

  Scenario: Attempt to create a documentation page without any content
    Given I am identified
    When I go to the add documentation page
    And I enter documentation without page content
    And I press "Save"
    Then I should be on the documentation page
    And I should see "Content can't be blank"

  Scenario: Attempt to create a completely blank documentation page
    Given I am identified
    When I go to the add documentation page
    And I press "Save"
    Then I should be on the documentation page
    And I should see "Title can't be blank"
    And I should see "Content can't be blank"

  Scenario: Attempt to create the first documentation page without identifying
    Given I am not identified
    And there is no documentation
    When I go to the home page
    Then I should be on the account logon page
    And I should see "You must be logged on to add documentation"

  Scenario: Attempt to create a documentation page without identifying
    Given I am not identified
    And I have created a page
    When I go to the add documentation page
    Then I should be on the account logon page
    And I should see "You must be logged on to add documentation"