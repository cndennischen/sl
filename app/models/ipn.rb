class Ipn < ActiveRecord::Base
  belongs_to :user
  serialize :params
  after_create :process_ipn
  
  private
  
  def process_ipn
    # process the Instant Payment Notification (IPN)
  end
  
end
