class CreateAuctionsUsers < ActiveRecord::Migration
  def self.up
    create_table :auctions_users, :id => false do |t|
      t.integer :user_id, :auction_id
    end
    add_index :auctions_users,  [:user_id, :auction_id], :unique => true
    add_index :auctions_users,  [:auction_id, :user_id], :unique => true
  end

  def self.down
    drop_table :auctions_users
  end
end
