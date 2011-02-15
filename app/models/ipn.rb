class Ipn < ActiveRecord::Base
  attr_accessible :params, :user_id, :status, :transaction_id
  validates_presence_of :user_id
  belongs_to :user
  serialize :params
  after_create :process_ipn
  
  private
  
  def process_ipn
    # set the user's email address
    user.update_attributes(:email => params[:payer_email])
    # process different types of events
    user.update_attributes(:plan => "paid") if params[:txn_type] == "subscr_signup"
    user.update_attributes(:plan => "free") if params[:txn_type] == "subscr_cancel" || "subscr_eot"
  end
  
end
