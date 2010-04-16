Feature:
  In order to allow more control over the users who can edit documentation
  As an administrator
  I need to be able to set that not every logged in user is a document author

  Scenario: An administrator sets the site to restrict document authors to a document author list
    Given I am identified as an administrator
    When I go to the edit site configuration page
    And I check "Use document author list"
    And I press "Save configuration"
    Then I should see "Configuration saved"
    And I should see "Use document author list: true"
    And I should see "Edit document author list"

  Scenario: An administrator adds a user to the document authors
    Given I am identified as an administrator
    And there is a non-document-author user called "Harry" with email "harry@test.host"
    And the site is using the document author list
    When I go to the edit document authors list page
    And I select "harry@test.host" from "Add document authors"
    And I press "Update document authors"
    Then I should be on the document authors list page
    And I should see "Document author added"
    And I should see "Harry" in the document author list
