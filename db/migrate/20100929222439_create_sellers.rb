class CreateSellers < ActiveRecord::Migration
  def self.up
    create_table :sellers do |t|
      t.string :name, :null => false

      t.timestamps
    end
    add_index :sellers, :name, :unique => true
  end

  def self.down
    drop_table :sellers
  end
end
