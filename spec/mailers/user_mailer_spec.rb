require "spec_helper"

describe UserMailer do
  context 'auction_buyer_email' do
    it 'should add email to queue' do
      recipient = Factory(:user)
      auction = Factory(:auction, :buyer => Factory(:ebayer))
      lambda do
        UserMailer.auction_buyer_email(recipient, auction).deliver
      end.should change(ActionMailer::Base.deliveries, :size).by(1)
    end
  end
end
