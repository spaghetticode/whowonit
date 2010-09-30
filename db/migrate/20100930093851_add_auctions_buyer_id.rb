class AddAuctionsBuyerId < ActiveRecord::Migration
  def self.up
    add_column :auctions, :buyer_id, :integer
  end

  def self.down
    remove_column :auctions, :buyer_id
  end
end
