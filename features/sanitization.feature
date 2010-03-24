Feature:
  (Constraint)
  In order to protect users from potentially malicious content added by a document author
  I need to sanitize content when it is output and only allow certain tags to be displayed

  Scenario Outline: Adding a video embed
    Given I am identified
    When I go to the add documentation page
    And I enter a title
    And I enter a <video_source> video
    And I press "Save"
    Then I should see "Page added"
    And I should <result>

    Examples:
      | video_source | result                                   |
      | non youtube  | not see an object element in the content |
      | youtube      | see a youtube video                      |
      | vimeo        | see a vimeo video                        |

