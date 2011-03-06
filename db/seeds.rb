# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

# Create the FAQ questions
Faq.create(:question => 'Can I upgrade and downgrade my account at any time',
           :answer => 'Of course you can! Go to the <a href="/account">account</a> page for more details.')

Faq.create(:question => 'Do you offer free student accounts',
           :answer => 'We sure do. Please <a href="http://sketchlab.mojohelpdesk.com/mytickets/create">submit a support ticket</a> to request one.')

Faq.create(:question => 'Can I cancel my account',
           :answer => 'You can cancel your account by going to the <a href="/account">account</a> page and clicking "Delete Account". If you are on the paid plan, you will need to downgrade to the free plan first.')

Faq.create(:question => 'How can I help improve Sketch Lab',
           :answer => 'Thank you for your interest in Sketch Lab! Please see the <a href="/contributing">Contributing</a> page for instructions.')

# Create an Admin to edit database records. Make sure to change the password later
Admin.create!(:email => "admin@sketchlabhq.com", :password => "password", :password_confirmation => "password" )
