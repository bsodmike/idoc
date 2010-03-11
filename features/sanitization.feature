Feature:
  (Constraint)
  In order to protect users from potentially malicious content added by a document author
  I need to sanitize content when it is output and only allow certain tags to be displayed

  Scenario: Adding a non-youtube or vimeo embed
    Given I am identified
    When I go to the add documentation page
    And I enter a title
    And I enter a non youtube video
    And I press "Save"
    Then I should see "Page added"
    And I should not see an object element in the content

