if ENV['REDISTOGO_URL']
  # Set up Redis
  uri = URI.parse(ENV['REDISTOGO_URL'])
  REDIS = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)
end
