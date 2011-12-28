Given /^I am a registered user$/ do
  @user = Factory(:user)
end

When /^I submit the (registration|login|password recovery|edit password|resend confirmation) form$/ do |type|
  button = case type
  when 'login'
    'Sign in'
  when 'password recovery'
    'Send me reset password instructions'
  when 'edit password'
    'Change my password'
  when 'registration'
    'Sign up'
  when 'resend confirmation'
    'Resend confirmation instructions'
  end
  click_button button
end

When /^I fill in my credentials$/ do
  fill_in "Email", :with => @user.email
  fill_in "Password", :with => @user.password
end

When /^I fill in invalid credentials$/ do
  fill_in "Email", :with => @user.email
  fill_in "Password", :with => @user.password[0..-2]
end

Given /^I fill in my data$/ do
  user = Factory.build(:user)
  fill_in "Email", :with => user.email
  fill_in "Password", :with => user.password
  fill_in "Password confirmation", :with => user.password
end

Given /^I fill in invalid data$/ do
  user = Factory.build(:user)
  fill_in "Email", :with => user.email
  fill_in "Password", :with => user.password
  fill_in "Password confirmation", :with => user.password[0..-2]
end

When /^I fill in my email$/ do
  fill_in "Email", :with => @user.email
end

When /^I fill in my password$/ do
  fill_in "Password", :with => @user.password.upcase
  fill_in "Password confirmation", :with => @user.password.upcase
end

Given /^I follow the registration process$/ do
  step 'I go to the registration page'
  step 'I fill in my data within the registration form'
  step 'I submit the registration form'
end

When /^I try to confirm my account$/ do
  step 'I open the email with subject "Confirmation instructions"'
  step 'I follow "Confirm my account" in the email'
end

Given /^I requested to reset my password$/ do
  step 'I am a registered user'
  step 'I go to the password recovery page'
  step 'I fill in my email within the password recovery form'
  step 'I submit the password recovery form'
end

Given /^I did not receive my confirmation instructions$/ do
  ActionMailer::Base.deliveries.clear
  @user.update_attribute(:confirmed_at, nil)
end

Given /^I am logged in$/ do
  step 'I am a registered user'
  step 'I go to the login page'
  step 'I fill in my credentials within the login form'
  step 'I submit the login form'
end

Given /^I should see my email/ do
  step %(I should see "#{@user.email}")
end