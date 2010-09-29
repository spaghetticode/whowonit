class Auction < ActiveRecord::Base
  belongs_to :seller
  has_and_belongs_to_many :users
  
  validates_presence_of :title, :url, :end_time, :item_id, :seller
  validates_uniqueness_of :url, :item_id
  
  scope :visible, lambda {where('end_time >=?', 90.days.ago)}
  scope :pending, where(:buyer_id => nil)
  
  def seller_name
    seller.name
  end
end
