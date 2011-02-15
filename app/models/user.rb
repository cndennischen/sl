class User < ActiveRecord::Base
  has_many :sketches, :dependent => :destroy
  has_many :ipns
  
  validates_presence_of :provider, :uid, :name
  validates_uniqueness_of :uid
  
  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.name = auth["user_info"]["name"]
      user.email = nil
    end
  end

end
