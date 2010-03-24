Feature:
  (Constraint)
  In order to provide users with a way to add richer content and formatting to their posts and comments
  I need to provide the ability to enter Markdown formatted text and transform it into HTML

  Scenario: Adding a document page with some formatted text
    Given I am identified
    When I go to the add documentation page
    And I enter a title
    And I enter content with bold and italic markdown elements
    And I press "Save"
    Then I should see "Page added"
    And I should see a strong element in the content
    And I should see an em element in the content