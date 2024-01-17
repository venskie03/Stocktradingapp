Rails.application.routes.draw do
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
 end

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    passwords: 'users/passwords'
  }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"

  root 'pages#home'
  get '/home',          to: 'home#index'
  get '/dashboard',     to: 'dashboard#index'
  get '/transactions',  to: 'transaction_records#index'
  get 'pages/users'

  get 'dashboard/approve/:id', to: 'dashboard#approve', as: 'approve_user'
  get '/new_user', to: 'users#new', as: 'create_new_user'
  post '/new_user' => "users#create"
  get '/edit/:id', to: "users#edit", as: 'edit_users'
  post '/edit/:id', to: "users#update"
  get '/delete/:id', to: "users#destroy", as: 'delete_user'



  resources :stocks do
    resources :orders
  end
end
