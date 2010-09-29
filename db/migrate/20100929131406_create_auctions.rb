class CreateAuctions < ActiveRecord::Migration
  def self.up
    create_table :auctions do |t|
      t.string :url,        :null => false
      t.datetime :end_time, :null => false
      t.string :title,      :null => false
      t.string :item_id,    :null => false
      t.timestamps
    end
  end

  def self.down
    drop_table :auctions
  end
end
