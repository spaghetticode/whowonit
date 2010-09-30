Given /^one of my ended auctions gets updated with the buyer information$/ do
  @buyer = Factory(:buyer)
  @auction = @user.auctions.first
  @auction.update_attribute(:end_time, 1.day.ago)
  @auction.update_attribute(:buyer, @buyer)
end

Then /^I should receive an email notification$/ do
  pending # express the regexp above with the code you wish you had
end

Then /^I should see the auction with the buyer information$/ do
  And %(I should see "#{@buyer.name}" within the auction row with id #{@auction.id})
end