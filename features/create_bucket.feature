Feature: bucket
  As a google storage api user
  I want to create a bucket
  So that I can perform other operation  on the bucket

  Scenario: create, list and delete an empty bucket
    Given the bucket name according the current time
    When I create the bucket
    Then I can list the bucket
    And the list include the bucket
    When I delete the bucket
    Then I can list the bucket
    And the list doesn't include the bucket

  Scenario: create a bucket with predefined acl
    Given the bucket name according the current time
    When I create the bucket with public acl
    Then I can list the bucket
    And the list include the bucket
    Then I get the public acl of bucket
    When I delete the bucket
    Then I can list the bucket
    And the list doesn't include the bucket




