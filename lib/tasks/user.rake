desc 'Pick a random user'
namespace :user do
  desc 'Picks a random user'
  task :pick => :environment do
    # Pick a random user
    # Note: the function "RANDOM()" should be changed to "RAND()" for MySQL.
    winner = User.find(:first, :order => 'RANDOM()')
    puts "Name: #{winner.name}"
    puts "Email: #{winner.email}"
  end
end
