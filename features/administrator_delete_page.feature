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