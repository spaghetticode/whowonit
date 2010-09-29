Feature: Manage Auctions
  In order to manage my auctions
  As an application registered user
  I want to list, add, remove auctions to my auctions list
    
  Scenario: List Auctions
    Given I am logged in
    And   I added a few auctions to my list
    When  I go to the auctions list page
    Then  I should see all my visible auctions title field
    And   I should see all my visible auctions seller_name field
  
  Scenario: Add Auction
    Given I am logged in
    And   I add a new auction to my list
    When  I go to the auctions list page
    Then  I should see the new auction details
  
  Scenario: Remove Auction
    Given I am logged in
    And   I added a few auctions to my list
    When  I remove the last auction from my list
    Then  I should see "Auction was successfully removed"
    And   I should be on the auctions list page
    And   I should not see the old last auction details