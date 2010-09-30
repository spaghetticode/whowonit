Feature: Manage User Mailer
  In order to get the desired information
  As an application user
  I want to receive email notifications when a buyer is disclosed
  
  Scenario: Receive Email when Buyer is Disclosed
    Given I am logged in
    And   I added a few auctions to my list
    When  one of my auctions get updated with the buyer information
    Then  I should receive an email notification
    
  Scenario: View Buyer Information when Buyer is Disclosed
    Given I am logged in
    And   I added a few auctions to my list
    And   one of my auctions get updated with the buyer information
    When  I go to the auctions list page
    Then  I should see the auction with the buyer information
    