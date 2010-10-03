task :cron => :environment do
  # try to associate buyer to all closed and pending and visible auctions
  Auction.closed.visible.pending.find_each do |auction|
    auction.set_buyer
  end
end