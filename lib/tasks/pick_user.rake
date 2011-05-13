desc 'Pick a random user'
task :pick_user => :environment do
  # Pick a random user
  # Note: the function "RANDOM()" should be changed to "RAND()" for MySQL.
  winner = User.find(:first, :order => 'RANDOM()')
  puts winner.to_yaml
end
