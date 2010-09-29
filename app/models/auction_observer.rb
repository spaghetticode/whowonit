class AuctionObserver < ActiveRecord::Observer
  def after_update(auction)
    # if buyer data is available
    # sends an email to all users associated to this auction
  end
end
