class Sketch < ActiveRecord::Base
  belongs_to :user
  
  def self.create
    create! do |sketch|
      sketch.name = "Untitled Sketch"
      sketch.content = "{}"
			sketch.user_id = current_user.id
    end
  end
end
