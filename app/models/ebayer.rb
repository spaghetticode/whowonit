class Ebayer < ActiveRecord::Base
  has_many :auctions
  
  validates :name, :presence => true, :uniqueness => true
  
  PROFILE_URL = 'http://myworld.ebay.it/'
  
  def profile_url
    [PROFILE_URL, name].join
  end
end
