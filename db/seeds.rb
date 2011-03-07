# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

# Create an Admin to edit database records. Make sure to change the password later
Admin.create!(:email => "admin@sketchlabhq.com", :password => "password", :password_confirmation => "password" )
