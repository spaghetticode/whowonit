class AuctionsController < ApplicationController
  before_filter :authenticate_user!, :except => :index

  def index
    if current_user
      @auctions = current_user.visible_auctions.ordered
    else
      render :action => 'home'
    end
  end

  def new
    @auction = Auction.new
  end

  def create
    @auction = Auction.from_params(params[:auction], current_user.id)
    if @auction.save
      redirect_to auctions_path, :notice => 'Auction was successfully added.'
    else
      render :action => "new"
    end
  end

  def destroy
    @auction = Auction.find(params[:id])
    @auction.destroyable? ? @auction.destroy : current_user.auctions.delete(@auction)
    respond_to do |f|
      f.html { redirect_to auctions_path, :notice => 'Auction was successfully removed.' }
      f.js # destroy.erb.js
    end
  end
end
