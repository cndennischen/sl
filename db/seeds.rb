Admin.create!(
  :email => "admin@sketchlabhq.com",
  :password => APP_CONFIG[:admin_pass],
  :password_confirmation => APP_CONFIG[:admin_pass]
)
