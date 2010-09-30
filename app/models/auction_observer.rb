class AuctionObserver < ActiveRecord::Observer
  def after_update(auction)
    return if !auction.visible? || !auction.closed?
    if auction.got_buyer?
      auction.users.find_each do |user|
        UserMailer.auction_buyer_email(user, auction).deliver
      end
    end
  end
end
