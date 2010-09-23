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

