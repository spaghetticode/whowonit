class UserMailer < ActionMailer::Base
  default :from => Devise.mailer_sender
  
  def auction_buyer_email(user, auction)
    @auction = auction
    @buyer = auction.buyer
    mail(
      :to      => user.email,
      :subject => "Buyer id for auction #{auction.item_id}"
    )
  end
end