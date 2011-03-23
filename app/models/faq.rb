class Faq < ActiveRecord::Base
  validates_presence_of :question, :answer
  validates_uniqueness_of :question, :answer

  def self.search(search)
    if search
      where({:question.matches => "%#{search}%"} | {:answer.matches => "%#{search}%"})
    else
      scoped
    end
  end
end
