class Seller < ActiveRecord::Base
  has_many :auctions
  
  validates :name, :presence => true, :uniqueness => true
end
