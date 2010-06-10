Feature:
  In order to easily restructure documentation
  As a document author
  I need to be able to edit the entire document tree in a single action

  Scenario: Editing a documentation tree
    Given I am identified
    And I have created a page called "Test page 1" with position 1
    And I have created a page called "Test page 2" with position 2
    And I have created a subpage of "Test page 1" called "Test page 3" with position 1
    When I go to the edit documentation tree page
    And I set the parent of "Test page 1" to "Test page 2"
    And I set the position of "Test page 1" to 1
    And I set the parent of "Test page 3" to "Test page 2"
    And I set the position of "Test page 3" to 2
    And I press "Update tree"
    Then I should be on the home page
    And I should see "Test page 1" before "Test page 3"
    And I should see the menu item "Test page 1" underneath "Test page 2"
    And I should see the menu item "Test page 3" underneath "Test page 2"

  Scenario: Editing documentation tree and move a subtree
    Given I am identified
    And I have created a page called "Test page 1" with position 1
    And I have created a page called "Test page 2" with position 2
    And I have created a subpage of "Test page 2" called "Test page 3" with position 1
    When I go to the edit documentation tree page
    And I set the position of "Test page 2" to 1
    And I press "Update tree"
    Then I should be on the home page
    And I should see "Test page 2" before "Test page 1"
    And I should see the menu item "Test page 3" underneath "Test page 2"