# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

# Create the FAQ questions
Faq.create(:question => 'Can I upgrade and downgrade my account at any time',
           :answer => 'Of course you can! Just go to the <a href="/account">account</a> page.');
           
Faq.create(:question => 'Do you offer free student accounts',
           :answer => 'We sure do. Please <a href="http://support.sketchlabhq.com">submit a support ticket</a> to request one.');
