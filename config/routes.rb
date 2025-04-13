Rails.application.routes.draw do
  get "bookings/index"
  get "bookings/create"
  get "ticket_types/index"
  get "ticket_types/create"
  get "ticket_types/update"
  get "ticket_types/destroy"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  post "auth/login", to: "auth#login"
  post "auth/logout", to: "auth#logout"
  post "auth/register", to: "auth#register"

  get "profile", to: "user#profile"

  resources :events do
    resources :ticket_types, only: [ :index, :create, :update, :destroy ]
  end

  resources :bookings, only: [ :index, :create ]

  # Defines the root path route ("/")
  # root "posts#index"
end
