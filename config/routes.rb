Rails.application.routes.draw do
  resources :users
  resources :products
  post '/auth/login', to: 'authentication#login'
  post '/product', to: 'products#create'

  # Additional routes for editing and updating products
  get '/products/:id/edit', to: 'products#edit', as: 'edit_product'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  #get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
end
