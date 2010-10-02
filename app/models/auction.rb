class Auction < ActiveRecord::Base
  belongs_to :seller, :class_name => 'Ebayer'
  belongs_to :buyer,  :class_name => 'Ebayer'
  
  has_and_belongs_to_many :users
  
  validates_presence_of :title, :url, :end_time, :item_id, :seller
  validates_uniqueness_of :url, :item_id
  
  VISIBILITY_DAYS = 90
  scope :pending, where(:buyer_id => nil)
  scope :closed,  lambda { where('end_time < ?', Time.now) }
  scope :visible, lambda { where('end_time >= ?', VISIBILITY_DAYS.send(:days).ago) }
  
  def seller_name
    seller.name
  end
  
  def buyer_name
    buyer.try(:name)
  end
  
  def visible?
    end_time >= VISIBILITY_DAYS.send(:days).ago
  end
  
  def closed?
    end_time < Time.now
  end
  
  def got_buyer?
    buyer and buyer_id_changed? and buyer_id_was.nil?
  end

  def find_buyer
    response = Nokogiri.HTML(open(seller.feedback_url))
    feedback = response.css('.bot td:nth-child(2)').find{|t| t.text =~ /#{item_id}/}
    if feedback
      name = feedback.parent.previous_sibling.children[2].children.css(".mbg").children.css("a").first[:title].match(/Member id (\w+)/)[1]
      set_buyer(name)
    end
  end
  
  def set_buyer(name)
    update_attribute :buyer, Ebayer.find_or_create_by_name(name)
  end
end
