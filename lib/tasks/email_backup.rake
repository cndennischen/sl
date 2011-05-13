desc 'Back up the database and email it to the backup email address'
task :email_backup => :environment do
  puts "[#{Time.now}] Heroku backup started"
  # Gather the necessary information
  name = "#{ENV['APP_NAME']}-#{Time.now.strftime('%Y-%m-%d-%H%M%S')}.dump"
  db = ENV['DATABASE_URL'].match(/postgres:\/\/([^:]+):([^@]+)@([^\/]+)\/(.+)/)
  # Dump the database to the tmp directory
  puts "Dumping the database to tmp/#{name}"
  system "PGPASSWORD=#{db[2]} pg_dump -Fc --username=#{db[1]} --host=#{db[3]} #{db[4]} > tmp/#{name}"
  # Email the backup
  puts 'Emailing database'
  Backups.backup("tmp/#{name}").deliver
  # Delete the backup from the filesystem
  system "rm tmp/#{name}"
  puts "[#{Time.now}] Heroku backup completed"
end
