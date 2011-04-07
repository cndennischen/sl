SketchLab::Application.routes.draw do
  devise_for :admins

  match "/auth/:provider/callback" => "sessions#create"
  match "/auth/failure" => "sessions#auth_error"
  get "/signout" => "sessions#destroy", :as => 'signout'
  get "/signin" => "home#signin", :as => 'signin'
  get "/account" => "home#account"
  post "/account/update" => "home#update_account", :as => "update_account"
  get "/account/delete", :as => "delete_account"
  post "/account/destroy", :as => "destroy_account"
  post "/new" => "sketch#new"
  get "/edit/:sketchID" => "sketch#edit", :constraints => { :sketchID => /\d+/ }
  get "/canvas" => "sketch#canvas"
  post "/save" => "sketch#save", :constraints => { :id => /\d+/ }
  post "/rename" => "sketch#rename", :constraints => { :id => /\d+/ }
  post "/delete" => "sketch#delete", :constraints => { :id => /\d+/ }
  get "/export/:id/:format" => "sketch#export", :constraints => { :id => /\d+/ }
  get "/help" => "help#index"
  get "/help/:article" => "help#kb"
  get "/contributing" => "home#contributing"
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => "home#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
