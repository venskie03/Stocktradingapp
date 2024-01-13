Rails.application.routes.draw do
  get 'transaction/index'
  root 'pages#home'
  devise_for :users, controllers: {registrations: 'users/registrations'}
  resources :dashboard, only: [:index] do
    post 'approve_user/:id', to: 'dashboard#approve_user', on: :collection, as: :approve_user
  end
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
