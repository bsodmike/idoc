Feature:
  In order to clarify meanings and highlight documentation problems
  As a commenter
  I need to be able to comment on existing documentation

  Scenario: Add a comment on a documentation page as an identified user
    Given I am identified
    And I have created a page
    When I go to the document page
    And I enter a comment
    And I press "Submit comment"
    Then I should be on the document page
    And I should see "Comment added"
    And I should see my comment
    And I should see my display name

  Scenario: Attempt to add a comment on a documentation page when not identified
    Given I am not identified
    And I have created a page
    When I go to the document page
    Then I should see "You need to log in to add a comment"
    When I go to the add comment page
    Then I should be on the account logon page
    And I should see "You must be logged on to add a comment"

  Scenario: Attempt to add a comment without a comment body as an identified user
    Given I am identified
    And I have created a page
    When I go to the document page
    And I enter a comment without a body
    And I press "Submit comment"
    Then I should be on the comment page
    And I should see "Comment cannot be blank"
