class Ipn < ActiveRecord::Base
  attr_accessible :params, :user_id, :status, :transaction_id
  validates_presence_of :user_id
  belongs_to :user
  serialize :params
  after_create :process_ipn
  
  private
  
  def process_ipn
    # set the user's email address
    user.email = params[:payer_email]
    user.save
  end
  
end
