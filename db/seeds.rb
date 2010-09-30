require 'factory_girl'
require File.join(Rails.root, 'spec/factories')

user = Factory(:user, :email => 'andrea@spaghetticode.it', :confirmed_at => Time.now)
seller = Factory(:seller, :name => 'old.comp')
buyer = Factory(:buyer, :name => 'superfiko')
auction = Factory(:auction, :seller => seller, :buyer => buyer)
auction.users << user