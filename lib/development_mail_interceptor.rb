# This class intercepts all outgoing email in development mode and sends it to the admin's email address.
class DevelopmentMailInterceptor
  def self.delivering_email(message)
    message.subject = "#{message.to} #{message.subject}"
    message.to = MAIL_CONFIG[:admin_email]
  end
end
