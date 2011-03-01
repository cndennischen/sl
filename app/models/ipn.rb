class Ipn < ActiveRecord::Base
  validates_presence_of :params, :user_id
  belongs_to :user
  serialize :params
  after_create :process_ipn

  private

  def process_ipn
    if validate_ipn
      # process different types of events
      user.update_attributes(:plan => "paid") if params[:txn_type] == "subscr_signup"
      user.update_attributes(:plan => "free") if params[:txn_type] == "subscr_cancel"
    end
  end

  def validate_ipn
    # check params
    if params[:receiver_email] == APP_CONFIG[:seller_email] &&
        params[:secret] == APP_CONFIG[:paypal_secret]
      return true;
    else
      # send email notification
      Notifications.invalid_ipn(self).deliver
      return false
    end
  end

end
