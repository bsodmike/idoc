Feature:
  In order to build useful documentation
  As a Document Author
  I need to edit existing documentation

  Scenario: Edit an existing documentation page as an identified user
    Given I am identified
    And I have created a page
    When I go to the document page
    And I follow "Edit page"
    And I change the document title
    And I press "Save changes"
    Then I should be on the document page
    And I should see the new title
    And I should see "Page successfully updated"
    And I should see the page body

  @wip
  Scenario: 