class Faq < ActiveRecord::Base
  validates_presence_of :question, :answer
  validates_uniqueness_of :question, :answer

  # Uncaches the Faqs
  def self.uncache
    Rails.cache.delete 'faqs'
  end

  # Returns true if either the question or answer contains the passed in string
  def include?(string)
    question.include?(string) || answer.include?(string)
  end
end
