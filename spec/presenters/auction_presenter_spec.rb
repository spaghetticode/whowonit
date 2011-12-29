require 'spec_helper'

describe AuctionPresenter do
  include ActionView::TestCase::Behavior

  before do
    @auction = Factory.stub(:auction)
    @presenter = AuctionPresenter.new(@auction, view)
  end

    it 'should delegate id and final_price to auction' do
      %w[id final_price].each do |method|
      @presenter.send(method).should == @auction.send(method)
    end
  end

  describe '#thumbnail_image' do
    it 'should return an image tag' do
      @presenter.thumbnail_image.should =~ %r[^<img.+/>$]
    end

    it 'should include expected string' do
      expected = "http://thumbs3.ebaystatic.com/pict/#{@auction.item_id}.jpg"
      @presenter.thumbnail_image.should include(expected)
    end
  end

  describe '#color' do
    it 'should return green if auction is not closed' do
      @presenter.color.should == 'green'
    end

    it 'should return black if auction is closed' do
      @auction.end_time = 1.week.ago
      @presenter.color.should == 'black'
    end
  end
end