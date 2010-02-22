Feature:
  (Constraint)
  In order to track the author of documentation and comments
  I need to provide a way to identify users

  Scenario: An anonymous user requests an iDoc identity with valid details
  	Given I am not identified
  	When I go to the new account page
  	And I enter the required account details
  	And I press "Register"
  	Then I should see "Sign-up successful"
  	And I should receive an email

  Scenario: A registered user confirms their email address
  	Given I have created an account
  	Then I should receive an email
  	When I open the email
    Then I should see "confirm" in the email body
  	When I follow "confirm" in the email
  	Then I should see "Account activated"

  @wip
  Scenario: An unidentified user identifies with credentials for an activated account
    Given I have created an account
    And I have activated my account
    When I go to the account logon page
    And I enter my account details
    And I press "Log in"
    Then I should be on the home page
    And I should see "Logged in successfully"

  @wip
  Scenario: An unidentified user identifies with credentials for an inactive account
    Given I have created an account
    And I have not activated my account
    When I go to the account logon page
    And I enter my account details
    And I press "Log in"
    Then I should be on the account logon page
    And I should see "Your account is not activated"
  
  @proposed
  Scenario: An unidentified user identifies with credentials for an unknown account
  
  @proposed
  Scenario: An anonymous user requests an iDoc identity with invalid details

  @proposed
  Scenario: An identified user request an iDoc identity

  @proposed
  Scenario: An identified user attempts to re-identify