module EbayersHelper
  def profile_for(ebayer)
    return '-' unless ebayer
    link_to ebayer.name, ebayer.profile_url
  end
end
