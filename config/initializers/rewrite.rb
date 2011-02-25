Rails.application.config.middleware.use Rack::Rewrite do
  r301 %r{^/(.*)/$}, '/$1'
end
