Feature: Manage Auctions
  In order to manage my auctions
  As an application registered user
  I want to list, add, remove auctions to my auctions list
  
  Scenario: List Auctions
    Given I am logged in
    When  I go to the auctions list page
    Then  I should see "Auctions List"
    
  Scenario: List some Auctions
    Given I am logged in
    And   I added a few auctions to my list
    When  I go to the auctions list page
    Then  I should see my auctions details
  
  Scenario: Add Auction
    Given I am logged in
    When  I add an auction to my list
    Then  I should see "Auction was successfully added"
    And   I should be on the auctions list page
    And   I should see the new auction details
  
  Scenario: Remove Auction
    Given I am logged in
    When  I remove an auctions from my list
    Then  I should see "Auction was successfully removed"
    And   I should be on the auctions list page
    And   I should not see the old auction details