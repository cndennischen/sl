class User < ActiveRecord::Base
  has_many :sketches, :dependent => :destroy
  has_many :ipns
  
  validates_presence_of :provider, :uid, :name, :email
  validates_uniqueness_of :uid, :email
  
  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.name = auth["user_info"]["name"]
      user.email = auth["user_info"]["email"]
    end
  end
end
