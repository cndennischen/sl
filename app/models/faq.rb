class Faq < ActiveRecord::Base
  validates_presence_of :question, :answer
  
  def self.search(search)
    if search
      where('question LIKE ?', "%#{search}%")
    else
      scoped
    end
  end
end
