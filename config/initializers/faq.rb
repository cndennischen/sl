# This initializer sets up the faq table

if Faq.table_exists?
  # First destroy all records
  Faq.delete_all

  # Now create the FAQs from JSON
  JSON.parse(File.read("#{Rails.root}/config/faq.json")).each do |key, value|
    Faq.create(:question => value['q'], :answer => value['a'])
  end
end
