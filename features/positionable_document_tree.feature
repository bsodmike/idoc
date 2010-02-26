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
    