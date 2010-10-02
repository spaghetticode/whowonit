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
    
    it 'set_buyer should create an ebayer with given name, if it doesnt exist yet' do
      lambda do
        @auction.set_buyer('superfiko')
      end.should change(Ebayer, :count).by(1)
    end
    
    context 'when auction ended decently' do
      before { @auction.update_attribute(:end_time, 1.hour.ago) }
      
      it { @auction.should be_closed }
      
      context 'when auction has at least one associated user' do
        before do
          @user = Factory(:user)
          @auction.users << @user
        end
        
        context 'when buyer info is added' do
          it 'should deliver an informative email' do
            lambda do
              @auction.update_attribute(:buyer, Factory(:ebayer))
            end.should change(ActionMailer::Base.deliveries, :size).by(1)
          end
          
          it 'should not deliver informative email if buyer is changed' do
            @auction.update_attribute(:buyer, Factory(:ebayer))
            lambda do
              @auction.update_attribute(:buyer, Factory(:ebayer))
            end.should_not change(ActionMailer::Base.deliveries, :size)
          end
        end
      end
      
      context 'when auction has no associated users' do
        it 'should deliver no email when buyer info is added' do
          lambda do
            @auction.update_attribute(:buyer, Factory(:ebayer))
          end.should_not change(ActionMailer::Base.deliveries, :size)
        end
      end
    end
    
    context 'when auction ended more than 90 days ago' do
      before { @auction.end_time = 91.days.ago }
      
      it 'should not be visible' do
        @auction.should_not be_visible
      end
      
      it 'it should never deliver email' do
        @auction.users << Factory(:user)
        lambda do
          @auction.update_attribute(:buyer, Factory(:ebayer))
        end.should_not change(ActionMailer::Base.deliveries, :size)
      end
    end
    
    context 'when auction is not closed' do
      it 'should never deliver email' do
        @auction.users << Factory(:user)
        lambda do
          @auction.update_attribute(:buyer, Factory(:ebayer))
        end.should_not change(ActionMailer::Base.deliveries, :size)
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
  end
end
