Rails.application.routes.draw do
  get 'transaction/index'
  root 'pages#home'
  get 'pages/users'
  patch 'dashboard/approve/:id', to: 'dashboard#approve', as: :approve_user
  get '/new_user', to: 'users#new', as: 'create_new_user'
  post '/new_user' => "users#create"
  get '/users/:id/edit', to: "users#edit", as: 'edit_users'
  post '/users/:id/edit', to: "users#update"
  patch '/delete/:id', to: 'users#destroy', as: :delete_user

  devise_for :users, controllers: {registrations: 'users/registrations'}


  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
