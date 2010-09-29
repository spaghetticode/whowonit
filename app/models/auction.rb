class Auction < ActiveRecord::Base
  validates_presence_of :title, :url, :end_time, :item_id
  validates_uniqueness_of :url, :item_id
  
  scope :visible, lambda {where('end_time >=?', 90.days.ago)}
  scope :pending, where(:buyer_id => nil)
  
  has_and_belongs_to_many :users
end
