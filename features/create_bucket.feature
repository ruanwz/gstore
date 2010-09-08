Feature: bucket
  As a google storeage api user
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

  Scenario: change the acl of an empty bucket
    Given the bucket name according the current time
    When I create the bucket
    Then I can list the bucket
    And the list include the bucket
    When I change the acl of the bucket
    When I get the acl of the bucket
    Then the acl of bucket is changed
    When I delete the bucket
    Then I can list the bucket
    And the list doesn't include the bucket




