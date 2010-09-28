Feature: Manage authentications
  In order to enjoy the site in full privacy
  As an application user
  I want to manange my account
  
  Scenario: Successful Authentication
    Given I am a registered user
    When  I go to the login page
    And   I fill in my credentials within the login form
    And   I submit the login form
    Then  I should see "Signed in successfully" within the notification area
    
  Scenario: Failed Authentication
    Given I am a registered user
    When  I go to the login page
    And   I fill in invalid credentials within the login form
    And   I submit the login form
    Then  I should see "Invalid email or password" within the notification area
    
  Scenario: Successful Register
    Given I go to the registration page
    And   I fill in my data within the registration form
    And   I submit the registration form
    Then  I should see "You have signed up successfully" within the notification area
    And   an email should have been sent
  
  Scenario: Failed Register
    Given I go to the registration page
    And   I fill in invalid data within the registration form
    And   I submit the registration form
    Then  I should see "Password doesn't match" within the error notification area
  
  Scenario: Account Activation
    Given I follow the registration process
    When  I try to confirm my account
    Then  I should see "Your account was successfully confirmed" within the notification area
  
  Scenario: Password Forgotten
    Given  I am a registered user
    When   I go to the password recovery page
    And    I fill in my email within the password recovery form
    And    I submit the password recovery form
    Then   I should see "You will receive an email with instructions" within the notification area
    And    an email should have been sent
    
  Scenario: Change Password
    Given I requested to reset my password
    When  I open the email
    And   I follow "Change my password" in the email
    Then  I should be on the edit password page
    When  I fill in my password within the edit password form
    And   I submit the edit password form
    Then  I should see "Your password was changed successfully" within the notification area
  
  Scenario: Resend Confirmation Instructions
    Given I am a registered user
    But   I did not receive my confirmation instructions
    When  I go to the resend confirmation instructions page
    And   I fill in my email within the resend confirmation form
    And   I submit the resend confirmation form
    Then  I should see "You will receive an email with instructions" within the notification area
    And   an email should have been sent