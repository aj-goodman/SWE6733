# frozen_string_literal: true

Rails.application.routes.draw do
  root    'matches#index'
  # Users
  match   'users/new',    to: 'users#new',     via: %i[get post],   as: 'new_user'

  # Sessions
  match   'login',        to: 'sessions#new',  via: %i[get post],   as: 'login'
  delete  'logout',       to: 'sessions#destroy'
end
