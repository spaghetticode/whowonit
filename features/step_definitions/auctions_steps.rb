Given /^the following auctions?:$/ do |auctions|
  Auction.create!(auctions.hashes)
end

When /^I delete the (\d+)(?:st|nd|rd|th) auctions$/ do |pos|
  visit auctions_path
  within("table tr:nth-child(#{pos.to_i+1})") do
    click_link "Destroy"
  end
end

Then /^I should see the following auctions:$/ do |expected_auctions_table|
  expected_auctions_table.diff!(tableish('table tr', 'td,th'))
end

Given /^I added a few auctions to my list$/ do
  2.times do
    And 'I add a new auction to my list'
  end
end

Then /^I should see all my visible auctions (\w+) field$/ do |field|
  @user.visible_auctions.each do |auction|
    And %(I should see "#{auction.send(field)}" within an auction row)
  end
end

When /^I add a new auction to my list$/ do
  @auction = Factory(:auction, :user_ids => [@user.id])
end

Then /^I should see the new auction details$/ do
  And %(I should see "#{@auction.title}" within an auction row)
end

Then /^I should not see the old last auction details$/ do
  And %(I should not see "#{@destroyed.title}" within an auction row)
end

When /^I remove the last auction from my list$/ do
  Given 'I added a few auctions to my list'
  @destroyed = @user.auctions.last
  When 'I go to the auctions list page'
  And  %(I press "remove" within the auction row with id #{@destroyed.id})
end
