class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessible :email, :password, :password_confirmation, :remember_me, :time_zone
  
  has_and_belongs_to_many :auctions
  
  validates_presence_of :time_zone
  
  def visible_auctions
    auctions.visible
  end
end
