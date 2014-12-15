Amt::Application.routes.draw do

  resources :authentications

  #devise_for :users

  devise_for :users, :controllers => {:registrations => 'users/registrations', :omniauth_callbacks => "users/omniauth_callbacks"}

  get '/auth/:provider/callback' => 'authentications#create'

  get 'coursera/:coursera_id/new' => 'courseras#new', as: 'coursera'

  get 'myProfile' => 'users#show'

  patch 'myProfile' => 'users#edit_image'

  get 'weeklyplan' => 'planification#weekly'

  post 'getdeadlines' => 'planification#get_deadlines'

  root 'welcome#index'

  get 'dashboard' => 'courses#index'

  get 'my_courses' => "courses#my_courses"

  get 'all_courses' => "courses#all_courses"

  get 'tools' => "tools#index"

  post 'add_time' => "tasks#add_time"

  post 'setChart' => "tasks#set_chart"

  resources :courses do 
    resources :tasks
  end
  
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
