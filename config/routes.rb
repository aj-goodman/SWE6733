# frozen_string_literal: true

Rails.application.routes.draw do
  root    'matches#index'
  # Users
  match   'users/new',              to: 'users#new',            via: %i[get post], as: 'new_user'

  # Sessions
  match   'login',                  to: 'sessions#new',         via: %i[get post], as: 'login'
  delete  'logout',                 to: 'sessions#destroy'

  # Profiles
  get     '/profile/edit',          to: 'profiles#edit'
  resource :profile,                only: %i[update]

  # Adventures
  post    '/adventures/search',     to: 'adventures#search'

  # Matches
  get     '/matches',               to: 'matches#index'
  post    '/matches/reject',        to: 'matches#reject'
  post    '/matches/accept',        to: 'matches#accept'

  # Chats
  resources :chats do
    post '/', to: 'chats#new_message'
    post '/retrieve', to: 'chats#retrieve'
  end
end
