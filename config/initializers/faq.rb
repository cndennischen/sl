# This initializer sets up the faq table

# First destroy all records
Faq.delete_all

# Now create the FAQs from JSON
JSON.parse(File.read("#{Rails.root}/config/faq.json")).each do |key, value|
  Faq.create(:question => value['q'], :answer => value['a'])
end
=begin
Faq.create(:question => 'Can I upgrade and downgrade my account at any time',
           :answer => 'Of course you can! Go to the <a href="/account">account</a> page for more details.')

Faq.create(:question => 'Do you offer free student accounts',
           :answer => 'We sure do. Please <a href="http://sketchlab.mojohelpdesk.com/mytickets/create">submit a support ticket</a> to request one.')

Faq.create(:question => 'Can I cancel my account',
           :answer => 'You can cancel your account by going to the <a href="/account">account</a> page and clicking "Delete Account". If you are on the paid plan, you will need to downgrade to the free plan first.')

Faq.create(:question => 'How can I help improve Sketch Lab',
           :answer => 'Thank you for your interest in Sketch Lab! Please see the <a href="/contributing">Contributing</a> page for instructions.')
=end
