ActionController::Routing::Routes.draw do |map|
  map.resource :session
  map.signout '/login', :controller => 'sessions', :action => 'new'
  map.signout '/logout', :controller => 'sessions', :action => 'destroy'
end
