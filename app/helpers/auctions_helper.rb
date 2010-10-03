module AuctionsHelper
  def gallery_image_tag(auction)
    image_tag "http://thumbs3.ebaystatic.com/pict/#{auction.item_id}.jpg"
  end
end
