module AuctionsHelper
  def gallery_image_tag(auction)
    image_tag "http://thumbs3.ebaystatic.com/pict/#{auction.item_id}.jpg"
  end

  def color_for(auction)
    auction.closed? ? 'black' : 'green'
  end

  def profile_for(ebayer)
    return '-' unless ebayer
    link_to ebayer.name, ebayer.profile_url
  end
end
