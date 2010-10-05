class AuctionsController < ApplicationController
  before_filter :authenticate_user!, :except => :index

  def index
    if current_user
      @auctions = current_user.visible_auctions.ordered
    else
      @user = User.new
      render :action => 'home'
    end
  end

  def new
    @auction = Auction.new
  end

  def create
    @auction = Auction.from_params(params[:auction], current_user.id)
    respond_to do |f|
      if @auction.save
        flash[:notice] = 'Auction was successfully added to your list.'
        f.html { redirect_to auctions_path }
        f.js
      else
        f.html { render :action => "new" }
        f.js
      end
    end
  end

  def destroy
    @auction = Auction.find(params[:id])
    @auction.destroyable? ? @auction.destroy : current_user.auctions.delete(@auction)
    flash[:notice] = 'Auction was successfully removed from your list.'
    respond_to do |f|
      f.html { redirect_to auctions_path }
      f.js # destroy.erb.js
    end
  end
end
