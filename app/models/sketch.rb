class Sketch < ActiveRecord::Base
  #belongs_to :user
  validates_presence_of :name, :message => "Please enter a name"
end
