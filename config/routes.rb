Rails.application.routes.draw do
  root    "matches#index"
  # Users
  match   "users/new",    to: "users#new",     via: [:get, :post],   as: "new_user"

  # Sessions
  match   "login",        to: "sessions#new",  via: [:get, :post],   as: "login"
  delete  "logout",       to: "sessions#destroy"
end
