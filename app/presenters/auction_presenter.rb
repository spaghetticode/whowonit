class AuctionPresenter < Presenter
  delegate :id, :final_price, :to => :auction

  def thumbnail_image
    image_tag "http://thumbs3.ebaystatic.com/pict/#{auction.item_id}.jpg"
  end

  def link
    link_to auction.title, auction.url
  end

  def color
    auction.closed? ? 'black' : 'green'
  end

  def end_time
    auction.end_time.to_s(:auction_end)
  end

  def seller_profile
    profile_for auction.seller
  end

  def buyer_profile
    profile_for auction.buyer
  end

  def remove_button
    button_to 'remove', auction, :confirm => 'Are you sure?', :method => :delete
  end
end