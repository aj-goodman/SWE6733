Rails.application.routes.draw do
  root "users#new"
  # Users
  match "users/new",    to: "users#new",     via: [:get, :post],   as: "new_user"

  # Sessions
  match "login",        to: "sessions#new",  via: [:get, :post],   as: "login"
end
