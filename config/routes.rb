Rails.application.routes.draw do
  devise_for :users

  root to: 'pages#home'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  scope "(:locale)", locale: /en|fr/ do
    get '/dashboard', to: 'pages#dashboard', as: 'pages_dashboard'
    resources :accessories
    resources :extractions
    resources :tastings
    resources :flavors, only: [:index, :show]
    resources :user_coffees
    resources :coffees
    resources :varieties, only: [:index, :show]
  end
  # Add other routes if necessary

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
