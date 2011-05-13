# Since this is for admins, password recovery, registration and "Remember Me" functionality is disabled.
class Admin < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation
end

class Admin::SessionsController < Devise::SessionsController
  # Override the create action to check the CAPTCHA
  def create
    # Check if the CAPTCHA was correct
    if verify_recaptcha
      super
    else
      build_resource
      clean_up_passwords(resource)
      flash[:error] = "There was an error with the recaptcha code below. Please re-enter the code and click submit."
      render_with_scope :new
    end
  end
end
