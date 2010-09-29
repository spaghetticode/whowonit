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
  3.times do
    And 'I add an auction to my list'
  end
end

Then /^I should see my auctions details$/ do
  Auction.all.each do |auction|
    And %(I should see "#{auction.title}" within an auction row)
  end
end

When /^I add an auction to my list$/ do
  Factory(:auction)
end

Then /^I should see the new auction details$/ do
  And %(I should see "#{Auction.last.title} within an auction row")
end

When /^I remove an auctions from my list$/ do
  pending # express the regexp above with the code you wish you had
end

Then /^I should not see the old auction details$/ do
  pending # express the regexp above with the code you wish you had
end
