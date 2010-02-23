Feature:
  In order to clarify meanings and highlight documentation problems
  As a commenter
  I need to be able to comment on existing documentation

  @wip
  Scenario: Add a comment on a documentation page as an identified user
    Given I am identified
    And I have created a page
    When I go to the document page
    And I follow "Add comment"
    And I enter a comment
    And I press "Submit comment"
    Then I should be on the document page
    And I should see "Comment added"
    And I should see my comment