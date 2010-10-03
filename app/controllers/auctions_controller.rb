class AuctionsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @auctions = current_user.visible_auctions.ordered
  end

  def new
    @auction = Auction.new
  end

  def create
    @auction = Auction.new(params[:auction].merge(:user_ids => [current_user.id]))
    if @auction.save
      redirect_to auctions_path, :notice => 'Auction was successfully added.'
    else
      render :action => "new"
    end
  end

  def destroy
    @auction = Auction.find(params[:id])
    if @auction.user_ids.size > 1
      current_user.auctions.delete(@auction)
    else
      @auction.destroy
    end
    redirect_to auctions_path, :notice => 'Auction was successfully removed.'
  end
end
