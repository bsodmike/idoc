Feature:
  In order to maintain order in a comment list
  As a moderator
  I need to be able to delete comments that are outdated or contain unsuitable language

  Scenario: Moderator deletes a comment on a documentation page
    Given I am identified as a moderator
    And I have created a page called "Test page"
    And I have added a comment on "Test page"
    When I go to the document page for "Test page"
    And I press "Delete comment"
    Then I should see "Comment deleted"
    And I should not see a comment
    
  @proposed
  Scenario: Non-moderator attempts to delete a comment