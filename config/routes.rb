CMS::Application.routes.draw do

  resources :macro_processes

  resources :user_sessions
  match '/login' => "user_sessions#new", :as => :login
  match '/logout' => "user_sessions#destroy", :as => :logout

  resources :users do
    resources :messages
  end

  get "review/show"

  get "review/edit"

  post "review/update"

  resources :comments

 # devise_for :users

  resources :key_terms

  resources :critical_processes do
    member do
      post :key_term_add
      post :key_term_remove
      get :all_versions
      get :cp_members
    end
  end

  match "/dynamic_create" => "key_terms#dynamic_create", :as => :dynamic_create

  root :to => "macro_processes#index"

  resources :review, :only => [:show, :update]

  match "/usernames" => 'messages#query'
  match '/review_cps' => 'critical_processes#review_cps'


 # match 'review/:id' => 'review#show'
#  match 'review/update/:id' => 'review#update'


  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:                 ß
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
  # root :to => "welcome#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
