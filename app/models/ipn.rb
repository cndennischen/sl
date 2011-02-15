class Ipn < ActiveRecord::Base
  attr_accessible :params, :user_id, :status, :transaction_id
  belongs_to :user
  serialize :params
  after_create :process_ipn
  
  private
  
  def process_ipn
    
  end
  
end
