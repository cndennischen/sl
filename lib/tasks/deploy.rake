desc 'Update the "last deployed" time'
task :update_last_deployed do
  if defined?(REDIS)
    REDIS.set('last_deployed', Time.now)
  else
    puts 'Redis not set up'
  end
end
