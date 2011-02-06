class User < ActiveRecord::Base
  validates_presence_of :userId
  has_many :sketches
end
