# frozen_string_literal: true

Rails.application.routes.draw do
  root    'matches#index'
  # Users
  match   'users/new',            to: 'users#new', via: %i[get post], as: 'new_user'

  # Sessions
  match   'login',                to: 'sessions#new', via: %i[get post], as: 'login'
  delete  'logout',               to: 'sessions#destroy'

  # Profiles
  get     '/profile/edit',        to: 'profiles#edit'
  resource :profile,              only: [:update]

  # Adventures
  post    '/adventures/search',   to: 'adventures#search'
end
