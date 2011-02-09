class Sketch < ActiveRecord::Base
  belongs_to :user
  # validations
  validates_presence_of :name
  validates_format_of :name, :with => /^[a-zA-Z0-9_-]+$/, :message => "Only letters, numbers, hyphens and underscores are allowed"
end
