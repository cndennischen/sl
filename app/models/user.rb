class User < ActiveRecord::Base
  has_many :sketches
end
