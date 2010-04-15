Feature:
  In order to remove unneeded or malicious posts
  As an administrator
  I need to be able to delete pages from the documentation hierarchy

  Scenario: Delete a page as an administrator
    Given I am identified as an administrator
    And I have created a page called "Test page 1"
    And I have created a page called "Test page 2"
    And I am on the document page for "Test page 1"
    When I press "Delete page"
    Then I should be on the home page
    And I should see "Page deleted"
    And I should not see "Test page 1"

  Scenario: Attempt to delete a page with children as an administrator
    Given I am identified as an administrator
    And I have created a page called "Test page"
    And I have created a subpage of "Test page" called "Test subpage"
    When I go to the document page for "Test page"
    Then I should not see a button for "Delete page"
    When I attempt to delete "Test page"
    Then I should get a "403" status code

  Scenario: Attempt to delete a page as a non-administrator
    Given I am not identified
    And I have created a page called "Test page 1"
    When I am on the document page for "Test page 1"
    Then I should not see a button for "Delete page"