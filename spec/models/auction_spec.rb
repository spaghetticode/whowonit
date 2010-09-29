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
    
    it 'url should be unique' do
      invalid = Factory.build(:auction, :url => @auction.url)
      invalid.should have(1).error_on(:url)
    end
    
    it 'item_id should be unique' do
      invalid = Factory.build(:auction, :item_id => @auction.item_id)
      invalid.should have(1).error_on(:item_id)
    end
  end
  
  context 'VISIBLE SCOPE' do
    before do
      3.times { Factory(:auction) }
      @invisible = Auction.last
      @invisible.update_attribute(:end_time, 91.days.ago)
    end
    
    it { Auction.visible.should_not include(@invisible) }
    it { Auction.visible.size.should == 2 }
  end
  
  context 'PENDING SCOPE' do
    before do
      3.times { Factory(:auction) }
      @unpending = Auction.last
      @unpending.update_attribute(:buyer, Factory(:buyer))
    end
    
    it { Auction.pending.should_not include(@unpending) }
    it { Auction.pending.size.should == 2 }
  end
end
