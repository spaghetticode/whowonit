class Ebayer < ActiveRecord::Base
  has_many :auctions
  
  validates :name, :presence => true, :uniqueness => true
  
  PROFILE_URL = 'http://myworld.ebay.it/'
  
  def profile_url
    [PROFILE_URL, name].join
  end
  
  def feedback_url
    "http://feedback.ebay.com/ws/eBayISAPI.dll?ViewFeedback2&userid=#{name}&items=200&ftab=FeedbackAsSeller&interval=30"
  end
end
