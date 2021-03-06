Feature: bucket list
  As a google storage api user
  I want to create a bucket
  So that I can perform other operation  on the bucket

  Scenario: list bucket list
    Given the access info
    Then I can list the bucket list

  Scenario: Create a bucket
    Given the access info
    And the bucket name according the current time
    When I create the bucket
    Then I can list the bucket
    Then the list include the bucket
    When I delete the bucket
    Then I can list the bucket
    And the list doesn't include the bucket

  Scenario: create a bucket with predefined acl
    Given the access info
    And the bucket name according the current time
    When I create the bucket with public acl
    Then I can list the bucket
    Then the list include the bucket
    Then I get the public acl of bucket
    When I delete the bucket
    Then I can list the bucket
    And the list doesn't include the bucket

  Scenario: list the objects in a bucket
    Given the access info
    And the bucket name according the current time
    And the object name according the current time
    When I create the bucket
    And I put the object
    Then I can list the bucket
    And the list include the bucket
    Then I can list the objects
    And the list include the object
    When I delete the object
    When I delete the bucket
    Then I can list the bucket
    And the list doesn't include the bucket


