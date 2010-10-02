require 'spec_helper'

describe Auction do
  context 'a new blank instance' do
    it { should_not be_valid }
    it { should have(1).error_on(:title) }
    it { should have(1).error_on(:url) }
    it { should have(1).error_on(:item_id) }
    it { should have(1).error_on(:seller) }
    it { should have(1).error_on(:end_time)}
  end
  
  context 'a factory auction' do
    before { @auction = Factory(:auction) }
    
    it { @auction.should be_valid }
    it { @auction.users.should be_empty }
    it { @auction.seller.should_not be_nil }
    it { @auction.buyer.should be_nil }
    it { @auction.should be_visible }
    it { @auction.should_not be_closed }
    it { @auction.got_buyer?.should be_false }
    
    it 'url should be unique' do
      invalid = Factory.build(:auction, :url => @auction.url)
      invalid.should have(1).error_on(:url)
    end
    
    it 'item_id should be unique' do
      invalid = Factory.build(:auction, :item_id => @auction.item_id)
      invalid.should have(1).error_on(:item_id)
    end
    
    it { @auction.seller.should_not be_nil }
    
    it 'should be closed if ended recently' do
      @auction.end_time = 1.day.ago
      @auction.should be_closed
    end
    
    it 'should not be visible if ended more than 90 days go' do
      @auction.end_time = 91.days.ago
      @auction.should_not be_visible
    end
    
    it 'seller_name should return the seller name' do
      @auction.seller_name.should == @auction.seller.name
    end
    
    it 'buyer_name should be nil if there is no buyer' do
      @auction.buyer_name.should be_nil
    end
    
    it 'buyer_name should return the buyer name if available' do
      @auction.buyer = buyer = Factory(:ebayer)
      @auction.buyer_name.should == buyer.name
    end
    
    it 'got_buyer? should be true when buyer has just been added' do
      @auction.buyer = Factory(:ebayer)
      @auction.got_buyer?.should be_true
    end
    
    context 'SET_BUYER' do
      before do
        @auction.should_receive(:scrape_buyer_name).and_return('Bubba')
      end
      
      it 'should associate existing ebayer' do
        ebayer = Factory(:ebayer, :name => 'Bubba')
        @auction.set_buyer
        @auction.buyer.should == ebayer
      end
      
      it 'should create the ebayer when necessary' do
        lambda do
          @auction.set_buyer
        end.should change(Ebayer, :count).by(1)
      end
    end
  end
  
  context 'scopes' do
    before { 3.times { Factory(:auction) } }
  
    context 'VISIBLE SCOPE' do
      before do
        @invisible = Auction.last
        @invisible.update_attribute(:end_time, 91.days.ago)
      end
    
      it { Auction.visible.should_not include(@invisible) }
      it { Auction.visible.size.should == 2 }
    end
  
    context 'PENDING SCOPE' do
      before do
        @unpending = Auction.last
        @unpending.update_attribute(:buyer, Factory(:ebayer))
      end
    
      it { Auction.pending.should_not include(@unpending) }
      it { Auction.pending.size.should == 2 }
    end
    
    context 'CLOSED SCOPE' do
      before do
        @closed = Auction.last
        @closed.update_attribute(:end_time, 1.hour.ago)
      end
    
      it { Auction.closed.should include(@closed) }
      it { Auction.closed.size.should == 1 }
    end
    
    context 'closed.visible.pending' do
      before do
        @open = Factory(:auction)
        @pending =   Factory(:auction, :end_time => 1.day.ago)
        @invisible = Factory(:auction, :end_time => 91.days.ago)
        @unpending = Factory(:auction, :end_time => 1.day.ago, :buyer => Factory(:ebayer))
      end
      
      it 'should include @pending' do
        Auction.closed.visible.pending.should include(@pending)
      end
      
      it 'should return only 1 auction' do
        Auction.closed.visible.pending.count.should == 1
      end
    end
  end
end
