namespace :db do
  desc "Erase and fill database"
  task :populate => :environment do
    print 'Erasing... '
    [User, Sketch, Faq].each(&:delete_all)
    puts 'Done'

    print 'Filling... '
    100.times do
      Factory(:user)
      Factory(:sketch, :public => rand_bool)
      Factory(:faq)
    end
    puts 'Done'
  end

  # Returns a random boolean value
  def rand_bool
    rand(2) == 1
  end
end
