class CreateEbayers < ActiveRecord::Migration
  def self.up
    create_table :ebayers do |t|
      t.string :name, :null => false
      t.timestamps
    end
    add_index :ebayers, :name, :unique => true
  end

  def self.down
    drop_table :ebayers
  end
end
