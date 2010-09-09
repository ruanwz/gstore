Feature: object
  As a google storeage api user
  I want to create objects in a bucket
  So that I can perform other operation on the objects

  Scenario: create an object in an empty bucket
    Given the bucket name according the current time
    Given the object name according the current time
    When I create the bucket
    And I put the object
    Then I can get the object
    When I delete the object
    When I delete the bucket
    Then I can list the bucket
    And the list doesn't include the bucket


