class User < ActiveRecord::Base
  validate_presence_of :identity_url
  has_many :sketches
end
