class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessible :email, :password, :password_confirmation, :remember_me
  
  has_and_belongs_to_many :auctions
  
  def visible_auctions
    auctions.visible
  end
end
