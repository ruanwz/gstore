Feature: create a bucket
  As a google storeage api user
  I want to create a bucket
  So that I can perform other operation  on the bucket

  Scenario: create an empty bucket
    Given the bucket name according the current time
    When I create the bucket
    Then I can list the bucket


