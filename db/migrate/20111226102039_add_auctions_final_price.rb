class AddAuctionsFinalPrice < ActiveRecord::Migration
  def self.up
    add_column :auctions, :final_price, :string
  end

  def self.down
    remove_column :auctions, :final_price
  end
end
