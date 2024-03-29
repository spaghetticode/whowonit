# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20111226102039) do

  create_table "auctions", :force => true do |t|
    t.string    "url",         :null => false
    t.timestamp "end_time",    :null => false
    t.string    "title",       :null => false
    t.string    "item_id",     :null => false
    t.integer   "seller_id",   :null => false
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.integer   "buyer_id"
    t.string    "final_price"
  end

  create_table "auctions_users", :id => false, :force => true do |t|
    t.integer "user_id"
    t.integer "auction_id"
  end

  add_index "auctions_users", ["auction_id", "user_id"], :name => "index_auctions_users_on_auction_id_and_user_id", :unique => true
  add_index "auctions_users", ["user_id", "auction_id"], :name => "index_auctions_users_on_user_id_and_auction_id", :unique => true

  create_table "ebayers", :force => true do |t|
    t.string    "name",       :null => false
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  add_index "ebayers", ["name"], :name => "index_ebayers_on_name", :unique => true

  create_table "users", :force => true do |t|
    t.string    "email",                               :default => "", :null => false
    t.string    "encrypted_password",   :limit => 128, :default => "", :null => false
    t.string    "password_salt",                       :default => "", :null => false
    t.string    "reset_password_token"
    t.string    "remember_token"
    t.timestamp "remember_created_at"
    t.integer   "sign_in_count",                       :default => 0
    t.timestamp "current_sign_in_at"
    t.timestamp "last_sign_in_at"
    t.string    "current_sign_in_ip"
    t.string    "last_sign_in_ip"
    t.string    "confirmation_token"
    t.timestamp "confirmed_at"
    t.timestamp "confirmation_sent_at"
    t.string    "authentication_token"
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.string    "time_zone"
  end

  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
