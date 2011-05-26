if defined?(NewRelic)
  # Tell NewRelic to ignore the admin controllers
  Admin::SessionsController.send(newrelic_ignore)
  RailsAdmin::ApplicationController.send(newrelic_ignore)
end
