require 'factory_girl'
require File.join(Rails.root, 'spec/factories')

[User, Ebayer, Auction].each do |model|
  model.delete_all
end

user = Factory(:user, :email => 'andrea@spaghetticode.it', :confirmed_at => Time.now)
seller = Factory(:ebayer, :name => 'old.comp')
buyer = Factory(:ebayer, :name => 'superfiko')
auction = Factory(:auction, :seller => seller, :buyer => buyer)
auction.users << user