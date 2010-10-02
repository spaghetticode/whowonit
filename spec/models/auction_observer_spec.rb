require 'spec_helper'

describe AuctionObserver do
  before { @auction = Factory(:auction) }
  
  context 'updating auction' do
    context 'when it ended recently' do
      before { @auction.update_attribute(:end_time, 1.hour.ago) }
    
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
end