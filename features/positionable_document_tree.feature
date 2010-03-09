Feature:
  In order to provide easily navigatable documentation
  As a Document Author
  I need to be able to organise documentation pages into a document tree

  Scenario: Can move an existing page under another page
    Given I am identified
    And I have created two document pages
    When I go to the edit document page
    And I set the parent to the other document
    And I press "Save changes"
    Then I should be on the document page
    And I should see "Page successfully updated"
    And I should see the menu list in a nested list

  Scenario: Can create a new page underneath an existing page
    Given I am identified
    And I have created a page called "Test page"
    When I go to the add documentation page
    And I set the parent to "Test page"
    And I enter a new page called "Test page 2"
    And I press "Save"
    Then I should see "Page added"
    And I should see the documentation page called "Test page 2"
    And I should see the menu item "Test page 2" underneath "Test page"

  Scenario: Can change the position of a page within the same sub-menu
    Given I am identified
    And I have created a page called "Test page"
    And I have created a page called "Test subpage"
    And I have created a page called "Test subpage 2"
    When I go to the edit document page for "Test subpage"
    And I set the parent to "Test page"
    And I set the position to 2
    And I press "Save changes"
    And I go to the edit document page for "Test subpage 2"
    And I set the parent to "Test page"
    And I set the position to 1
    And I press "Save changes"
    Then I should see "Page successfully updated"
    And I should see "Test subpage 2" before "Test subpage" underneath "Test page"

  Scenario: Can set the position of a page on creation
    Given I am identified
    And I have created a page called "Test page"
    And I have created a subpage of "Test page" called "Test subpage" with position 2
    When I go to the add documentation page
    And I set the parent to "Test page"
    And I enter a new page called "Test subpage 2"
    And I set the position to 1
    And I press "Save"
    Then I should see "Page added"
    And I should see the documentation page called "Test subpage 2"
    And I should see "Test subpage 2" before "Test subpage" underneath "Test page"

  Scenario: Not setting a position on page creation puts the page at the bottom of the list
    Given I am identified
    And I have created a page called "Test page"
    And I have created a subpage of "Test page" called "Test subpage" with position 1
    When I go to the add documentation page
    And I set the parent to "Test page"
    And I enter a new page called "Test subpage 2"
    And I press "Save"
    Then I should see "Page added"
    And I should see "Test subpage 2" before "Test subpage" underneath "Test page"
    When I go to the edit document page for "Test subpage 2"
    Then I should see the position set to 2

    