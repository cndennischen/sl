# Create an admin user
Admin.create!(
  :email => "admin@sketchlabhq.com",
  :password => APP_CONFIG[:admin_pass],
  :password_confirmation => APP_CONFIG[:admin_pass]
)

# Setup the faqs
system 'rake reload_faqs'
