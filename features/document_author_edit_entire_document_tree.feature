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

  Scenario: Editing a complicated documentation tree
    Given I am identified
    And I have created a page called "Home page" with position 1
    And I have created a page called "Page 1" with position 2
    And I have created a page called "Page 2" with position 3
    And I have created a page called "Page 3" with position 4
    And I have created a page called "Page 4" with position 5
    And I have created a page called "Page 5" with position 6
    And I have created a page called "Page 6" with position 7
    And I have created a page called "Page 7" with position 8
    And I have created a page called "Page 8" with position 9
    And I have created a page called "Page 9" with position 10
    And I have created a subpage of "Page 1" called "Subpage 1" with position 1
    And I have created a subpage of "Page 1" called "Subpage 2" with position 2
    And I have created a subpage of "Page 1" called "Subpage 3" with position 3
    And I have created a subpage of "Page 1" called "Subpage 4" with position 4
    And I have created a subpage of "Page 1" called "Subpage 5" with position 5
    And I have created a subpage of "Page 2" called "Subpage 6" with position 1
    And I have created a subpage of "Page 2" called "Subpage 7" with position 2
    And I have created a subpage of "Page 2" called "Subpage 8" with position 3
    And I have created a subpage of "Page 2" called "Subpage 9" with position 4
    And I have created a subpage of "Subpage 3" called "SubSubpage 1" with position 1
    And I have created a subpage of "Subpage 3" called "SubSubpage 2" with position 2
    And I have created a subpage of "Subpage 3" called "SubSubpage 3" with position 3
    And I have created a subpage of "Subpage 8" called "SubSubpage 4" with position 1
    And I have created a subpage of "Subpage 8" called "SubSubpage 5" with position 2
    And I have created a subpage of "Subpage 8" called "SubSubpage 6" with position 3
    And I have created a subpage of "Subpage 9" called "SubSubpage 7" with position 1
    And I have created a subpage of "Subpage 9" called "SubSubpage 8" with position 2
    And I have created a subpage of "Subpage 9" called "SubSubpage 9" with position 3
    When I go to the edit documentation tree page
    And I set the position of "Page 2" to 2
    And I set the position of "Page 1" to 3
    And I set the position of "Page 9" to 4
    And I set the position of "Subpage 1" to 3
    And I press "Update tree"
    Then I should be on the home page
    And I should see "Page 2" before "Page 1"
    And I should see "Page 9" before "Page 3"
    And I should see "Subpage 2" before "Subpage 1"
