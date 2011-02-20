class Ipn < ActiveRecord::Base
  validates_presence_of :params, :user_id
  belongs_to :user
  serialize :params
  after_create :process_ipn
  
  private
  
  def process_ipn
    if validate_ipn
      # set the user's email address
      user.update_attributes(:email => params[:payer_email])
      # process different types of events
      user.update_attributes(:plan => "paid") if params[:txn_type] == "subscr_signup"
      user.update_attributes(:plan => "free") if params[:txn_type] == "subscr_cancel"
    end
  end
  
  def validate_ipn
    # send a postback to paypal
    @query = 'cmd=_notify-validate'
    params.each_pair {|key, value| @query = @query + '&' + key + '=' + value}
    http = Net::HTTP.new(APP_CONFIG[:paypal_domain], 80)
    response = http.post("/cgi-bin/webscr", @query)
    # check if it is valid
    if response.body == "VERIFIED"
      # check params
      if params[:receiver_email] == APP_CONFIG[:seller_email] &&
          params[:secret] == APP_CONFIG[:paypal_secret] &&
          params[:receiver_email] == APP_CONFIG[:seller_email]
        okay = true
      else
        okay = false
      end
    else
      okay = false
    end
    
    if okay == true
      return true
    else
      # send email notification
      Notifications.invalid_ipn(self).deliver
      return false
    end
    
  end
  
end
