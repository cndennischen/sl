=begin
config.middleware.insert_before(Rack::Lock, Rack::Rewrite) do
 r301 %r{^/(.*)/$}, '/$1'
end
=end
Rails.application.config.middleware.use Rack::Rewrite do
  r301 %r{^/(.*)/$}, '/$1'
end
