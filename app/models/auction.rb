class Auction < ActiveRecord::Base
  belongs_to :seller, :class_name => 'Ebayer'
  belongs_to :buyer,  :class_name => 'Ebayer'

  has_and_belongs_to_many :users

  validates_presence_of :title, :url, :end_time, :item_id, :seller
  validates_uniqueness_of :url, :item_id

  serialize :final_price, TradingApi::Money

  VISIBILITY_DAYS = 90
  scope :ordered, order('end_time DESC')
  scope :pending, where(:buyer_id => nil)
  scope :closed,  lambda { where('end_time < ?', Time.now) }
  scope :visible, lambda { where('end_time >= ?', VISIBILITY_DAYS.days.ago) }

  def self.from_params(params, current_user_id)
    Auction.find_or_initialize_by_item_id(params[:item_id]).tap do |auction|
      if auction.new_record?
        auction.set_external_attributes
        auction.user_ids = [current_user_id]
      else
        auction.user_ids << current_user_id
      end
    end
  end

  def set_external_attributes
    item = TradingApi::GetItem.new(item_id)
    %w[title url end_time final_price].each do |field|
      send "#{field}=", item.send(field)
    end
    self.seller = Ebayer.find_or_create_by_name(item.seller_ebay_id)
    rescue TradingApi::RequestError # TODO should we do something? Should we keep the error rescue more general?
  end

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

  def set_buyer
    name = scrape_buyer_name
    update_attribute(:buyer, Ebayer.find_or_create_by_name(name)) if name
  end

  def destroyable?
    user_ids.size < 2
  end

  private

  def scrape_buyer_name
    html = Nokogiri.HTML(seller.feedback_html)
    feedback = html.css('.bot td:nth-child(2)').find {|t| t.text =~ /#{item_id}/}
    feedback && feedback.parent.previous_sibling.children[2].children.css('.mbg').children.css('a').first[:title].match(/Member id (\w+)/)[1]
  end
end
