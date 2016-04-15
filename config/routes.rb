Rails.application.routes.draw do

# This defines a route so that when we receive a GET request wiht url: /home, Rails will invoke the WelcomeController with 'index' action.
# get({"/home" => "welcome#{index}"})
# if a helper name is not specified it will default in to:
# 'home_path' and 'home_url'

  get "/home" => "welcome#index"

# For this route we will have helper methods: about_path and about_url
  get "/about" => "about#about", as: :about

  get "/contact" => "contact#new"

# The below will have the same helper method as the route above because they share the same url "/contact"

  post "/contact" => "contact#create"

  resources :users, only: [:new, :create]

  resources :sessions, only: [:new, :create] do
    delete :destroy, on: :collection
  end



  resources :questions do
    # get :search, on: :collection
    # get :search, on: :member
    # get :search

# The answers routes will be the standard ones prefixed with /questions/:question_id. This way when, for instance, we wish to create an answer we know the question that it references. All the helpers will be the same as before, but prefixed with 'question'

    resources :answers, only: [:create, :destroy]
  end

  # 'resources :questions' will generate, in rails, the below:

  # get "/questions/new" => "questions#new", as: :new_question
  # post "/questions" => "questions#create", as: :questions
  # get "/questions/:id" => "questions#show", as: :question
  # get "/questions" => "questions#index"
  # get "/questions/:id/edit" => "questions#edit", as: :edit_question
  # patch "/questions/:id" => "questions#update"
  # delete "/questions/:id" => "questions#destroy"


# This defines the 'root' or homepage of our application and will direct it to the WelcomeController with 'index' action. We will have access to the helper methods: root_path and root_url
  root "welcome#index"


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
