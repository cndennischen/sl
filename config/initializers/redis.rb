if ENV['REDISTOGO_URL']
  # Set up Redis
  uri = URI.parse(ENV['REDISTOGO_URL'])
  REDIS = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)
  # Update last deployed time (we're assuming the app is (re)starting because something changed)
  REDIS.set('last_deployed', Time.now.getutc)
end
