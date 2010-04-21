Feature:
  In order to be effective at moderating comments
  As a moderator
  I need to be able to find recent comments

  Scenario: Obtaining a list of recent comments
    Given I am identified as a moderator
    And I have created a page called "Test page 1"
    And I have added a comment of "Older comment" on "Test page 1"
    And I have created a page called "Test page 2"
    And I have added a comment of "Newer comment" on "Test page 2"
    When I go to the recent comments page
    Then I should see the comment "Older comment" after comment "Newer comment"