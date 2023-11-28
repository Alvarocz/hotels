Rails.application.routes.draw do
  devise_for :agents
  root to: "home#index"
  resources :rooms
  resources :room_types
  resources :passengers
  resources :hotels
  resources :contacts
  resources :bookings
end
