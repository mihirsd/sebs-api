require "sidekiq/web"

Rails.application.routes.draw do
  # Sidekiq Web UI
  mount Sidekiq::Web => "/sidekiq"

  # Health check
  get "up" => "rails/health#show", as: :rails_health_check

  # Auth routes
  post "auth/login", to: "auth#login"
  post "auth/logout", to: "auth#logout"
  post "auth/register", to: "auth#register"

  # User profile
  get "profile", to: "user#profile"

  # Nested ticket_types inside events
  resources :events do
    resources :ticket_types, only: [ :index, :create, :update, :destroy ]
  end

  # Bookings routes
  resources :bookings, only: [ :index, :create ]

  # root route (optional)
  # root "home#index"
end
