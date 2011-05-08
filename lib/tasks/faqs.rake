desc 'Reload the faqs'
task :reload_faqs => :environment do
  # First delete all the faqs from the database
  Faq.delete_all
  # Create the faqs from JSON
  JSON.parse(File.read("#{Rails.root}/config/faq.json")).each do |key, value|
    Faq.create(:question => value['q'], :answer => value['a'])
  end
end
