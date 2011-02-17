class Notifications < ActionMailer::Base
  def invalid_ipn(ipn)
    @ipn = ipn
    mail(:to => MAIL_CONFIG[:admin_email], :from => MAIL_CONFIG[:admin_email], :subject => "Sketch Lab: Invalid IPN")
  end
end
