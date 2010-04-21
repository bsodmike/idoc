Feature:
  In order to find documentation quickly
  I need to be able to search the documentation for keywords and phrases

  Scenario: Search should find pages by title
    Given there is no documentation
    And I have created a page called "Test page 1"
    And I have created a page called "Test page 2"
    And I am on the home page
    When I enter "test" in the search field
    And I press "Search"
    Then I should be on the search results page
    And I should see "Search results for test"
    And I should see "Test page 1"
    And I should see "Test page 2"