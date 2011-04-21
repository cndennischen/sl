# Create an admin user
Admin.create!(
  :email => "admin@sketchlabhq.com",
  :password => APP_CONFIG[:admin_pass],
  :password_confirmation => APP_CONFIG[:admin_pass]
)

# Create the faqs from JSON
JSON.parse(File.read("#{Rails.root}/config/faq.json")).each do |key, value|
  Faq.create(:question => value['q'], :answer => value['a'])
end
