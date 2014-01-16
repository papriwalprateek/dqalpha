Blog::Application.routes.draw do 

 

  
  match 'user_verifications/:id' => 'user_verifications_controller#show'

  resources :polls
    #get "pages/home"
  match '/vinay' => 'algorithms#show'
  match '/' => 'algorithms#show', :constraints => { :subdomain => "algorithm" }
  match '/search' => 'algorithms#show', :constraints => { :subdomain => "algorithm" }
  match '' => 'pages#home'
  match '/leave_quest' => 'pages#leave_quest'   
  match '/join_quest' => 'pages#join_quest' 
  match "/wiki/:search" => redirect("/wik?ad=%{search}&commit=Wiki")
  match "/so/:search" => redirect("/wik?ad=%{search}&commit=so")
  match "/scilab/:search" => redirect("/scilab?ad=%{search}&commit=scilab")
  match "/bugzilla/:search" => redirect("/bugzilla?ad=%{search}&commit=Bugzilla")
     #get "pages/search"
  match '/search' => 'pages#search'
  match '/wik' => 'pages#wik'
  match '/a' => 'pages#read_notification'
  match '/clear_notification' => 'pages#clear_notification'
 
  match '/so' => 'pages#so'
  match '/notifications' => 'pages#notifications'
  match '/scilab' => 'pages#scilab'
  match '/bugzilla' => 'pages#bugzilla'
  match '/geeks-link' => 'pages#geek'
  match '/feedback_submit' => 'pages#feedback_submit'
#get "users/new"
  match 'users/:id/quests/:id' => 'quests#show', :via => [:get, :post]
  match 'quests/:id/qs/:id' => 'qs#show', :via => [:get, :post]
  match 'qs/:id/qmails/:id/update' => 'qmails#update', :via => [:get, :post]
  match '/quests/:id/search' => 'quests#search', :via => [:get, :post]
  match 'users/:id/quests/:id/search' => 'quests#search', :via => [:get, :post]
  match 'create_user' => 'users#create', :via => [ :post]

  resources :users do
    resources :quests
  
  end
   resources :users do
      resources :gists
    end

    resources :quests do
      resources :qs
    end

  
   resources :qs do
      resources :qmails
    end
  resources :user_sessions, :only => [ :create]
  match 'signin' => 'user_sessions#new', :as => :signin
  match 'signout' => 'user_sessions#destroy', :as => :signout
  match '/signup' => 'users#new'  
#get "pages/about"
    match '/about' => 'pages#about'
   match '/team'  => 'pages#team'
   match '/blogs'  => 'pages#blogs'
   match '/scilab_extract'  => 'pages#scilab_extract'
   match '/google885d2aab83a9c566' => 'pages#google885d2aab83a9c566'
    # get "pages/contact"
    match '/contact' => 'pages#contact'  
  resources :posts

    # get "home/index"

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
    root :to => 'page#home'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end