# This URL Rewrite rule removes trailing slashes for SEO
Rails.application.config.middleware.use Rack::Rewrite do
  r301 %r{^/(.*)/$}, '/$1'
end
