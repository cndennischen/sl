SketchLab::Application.routes.draw do
  devise_for :admins, :controllers => { :sessions => 'admin/sessions' }

  match 'auth/:provider/callback' => 'sessions#create'
  match 'auth/failure' => 'sessions#auth_error'

  get 'signout' => 'sessions#destroy', :as => 'signout'
  get 'signin' => 'home#signin', :as => 'signin'

  get 'account' => 'account#index'
  post 'plan/refresh' => 'account#refresh_plan', :as => 'refresh_plan'
  post 'account/update', :as => 'update_account'
  get 'account/delete', :as => 'delete_account'
  post 'account/destroy', :as => 'destroy_account'

  get 'users/current' => 'account#current'

  post 'new' => 'sketch#new'
  get 'edit/:id' => 'sketch#edit', :constraints => { :id => /\d+/ }
  get 'canvas' => 'sketch#canvas'
  post 'save' => 'sketch#save', :constraints => { :id => /\d+/ }
  post 'rename' => 'sketch#rename', :constraints => { :id => /\d+/ }
  post 'sharing' => 'sketch#sharing', :constraints => { :id => /\d+/ }
  post 'delete' => 'sketch#delete', :constraints => { :id => /\d+/ }
  get 'export/:id/:format' => 'sketch#export', :constraints => { :id => /\d+/ }

  get 'public' => 'public#index'
  get 'public/:id' => 'public#show'

  get 'help' => 'help#index'
  get 'help/:article' => 'help#kb'

  get 'contributing' => 'home#contributing'

  get 'tos' => 'home#tos'
  get 'privacy' => 'home#privacy'

  match 'sitemap.xml.gz' => redirect('/sitemap_index.xml.gz')

  root :to => 'home#index'
end
