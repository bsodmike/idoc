
    context "The document author list is in use" do
      before(:each) do
        @config = mock_model(SiteConfig, :use_document_author_list => true)
        SiteConfig.stub!(:find_or_create_default!).and_return(@config)
        @ability = Ability.new(@user)
      endFeature:
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

  Scenario: Remove a moderator from the moderator list
    Given I am identified as an administrator
    And there is a moderator user called "Harry" with email "harry@test.host"
    When I go to the edit moderator list page
    And I select "harry@test.host" from "Remove moderators"
    And I press "Update moderators"
    Then I should see "Moderator removed"
    And I should not see "Harry" in the moderator list

  Scenario: Add several users to the moderator list
    Given I am identified as an administrator
    And there is a non-moderator user called "Harry" with email "harry@test.host"
    And there is a non-moderator user called "Paul" with email "paul@test.host"
    When I go to the edit moderator list page
    And I select "harry@test.host" from "Add moderators"
    And I select "paul@test.host" from "Add moderators"
    And I press "Update moderators"
    Then I should see "Harry" in the moderator list
    And I should see "Paul" in the moderator list
    And I should see "Moderators added"

  Scenario: Remove several users from the moderator list
    Given I am identified as an administrator
    And there is a moderator user called "Harry" with email "harry@test.host"
    And there is a moderator user called "Paul" with email "paul@test.host"
    When I go to the edit moderator list page
    And I select "harry@test.host" from "Remove moderators"
    And I select "paul@test.host" from "Remove moderators"
    And I press "Update moderators"
    Then I should not see "Harry" in the moderator list
    And I should not see "Paul" in the moderator list
    And I should see "Moderators removed"

  Scenario: Non administrator attempts to alter the moderator list
    Given I am identified
    When I go to the edit moderator list page
    Then I should get a "403" status code

  Scenario: Anonymous user attempts to alter the moderator list
    Given I am not identified
    When I go to the edit moderator list page
    Then I should be on the account logon page
    And I should see "You must be logged in to access this area"