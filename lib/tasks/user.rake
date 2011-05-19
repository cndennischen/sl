desc 'Pick a random user'
namespace :user do
  desc 'Displays the number of users'
  task :count => :environment do
    puts User.count
  end

  desc 'Picks a random user'
  task :pick => :environment do
    # Pick a random user
    # Note: the function "RANDOM()" should be changed to "RAND()" for MySQL.
    winner = User.find(:first, :order => 'RANDOM()')
    puts winner.to_yaml
  end
end
