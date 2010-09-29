require 'spec_helper'

describe User do
  context 'a new blank instance' do
    it { should_not be_valid }
    it { should have(1).error_on(:email) }
    it { should have(1).error_on(:password) }
  end
  
  context 'a factory user' do
    before { @user = Factory(:user) }
    
    it { @user.should be_valid }
    it { @user.auctions.should be_empty }
    
    describe 'VISIBLE_AUCTIONS' do
      before do
        @included = Factory(:auction)
        @excluded = Factory(:auction, :end_time => 91.days.ago)
        Auction.find_each {|a| a.users << @user}
      end

      it 'should include @included' do
        @user.visible_auctions.should include(@included)
      end

      it 'should not include @excluded' do
        @user.visible_auctions.should_not include(@excluded)
      end
    end
  end
end