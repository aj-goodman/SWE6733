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
  post    '/profile/edit/auth/',    to: 'profiles#auth', as: 'instagram_auth'
  post    '/profile/edit/deauth/',  to: 'profiles#deauth'

  # Adventures
  post    '/adventures/search',     to: 'adventures#search'

  # Matches
  get     '/matches',               to: 'matches#index'
  post    '/matches',               to: 'matches#decide'
end
