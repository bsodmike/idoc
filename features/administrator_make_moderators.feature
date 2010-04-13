Feature:
  In order to delegate the management of a documentation community
  As an administrator
  I need to be able to designate members of the community as moderators

  Scenario: Add a user to the moderator list
    Given I am identified as an administrator
    And there is a non-moderator user called "Harry" with email "harry@test.host"
    When I go to the edit moderator list page
    And I select "harry@test.host" from "Add moderators"
    And I press "Update moderators"
    Then I should see "Moderator added"
    And I should see "Harry" in the moderator list

  @proposed
  Scenario: Remove a moderator from the moderator list

  @proposed
  Scenario: Add several users to the moderator list

  @proposed
  Scenario: Remove several users from the moderator list

  @proposed
  Scenario: Non administrator attempts to alter the moderator list

  @proposed
  Scenario: Anonymous user attempts to alter the moderator list