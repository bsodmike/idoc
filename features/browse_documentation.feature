Feature:
  In order to learn about a documented subject
  As a browser
  I need to be able to view and navigate documentation pages

  Scenario: View a documentation page using the menu
    Given I am not identified
    And I have created a page called "Test page 1"
    When I go to the home page
    And I follow "Test page 1"
    Then I should be on the document page for "Test page 1"
    And I should not see "Page added"

  Scenario: Viewing the next documentation page using the next link in a single level documentation layout
    Given I am not identified
    And I have created a page called "Test page 1"
    And I have created a page called "Test page 2"
    And I am on the document page for "Test page 1"
    When I follow "Next"
    Then I should be on the document page for "Test page 2"

  Scenario: Viewing the next documentation page using the next link in a 2 level documentation layout
    Given I am not identified
    And I have created a page called "Test page 1"
    And I have created a page called "Test page 2"
    And I have created a subpage of "Test page 1" called "Test subpage 1"
    And I am on the document page for "Test page 1"
    When I follow "Next"
    Then I should be on the document page for "Test subpage 1"

  Scenario: Viewing the previous document page using the previous link in a single level documentation layout
    Given I am not identified
    And I have created a page called "Test page 1"
    And I have created a page called "Test page 2"
    And I am on the document page for "Test page 2"
    When I follow "Previous"
    Then I should be on the document page for "Test page 1"