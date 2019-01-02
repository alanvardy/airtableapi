# frozen_string_literal: true

Rails.application.routes.draw do
  resources :connections
  resources :permissions
  get 'login', to: 'user_session#new'
  post 'login', to: 'user_session#create'
  get 'logout', to: 'user_session#destroy'
  get 'user_session/new'
  get 'user_session/create'
  get 'user_session/destroy'
  resources :users
  get 'static/index'
  get 'session/new'
  post 'session/create'
  get 'session/destroy'
  get 'sites/index'
  get 'sites/show'
  get 'sites/:id', to: 'sites#show'
  root 'static#index'
  get 'equipment/index'
  get 'equipment/:id', to: 'equipment#show'

  get '/check.txt', to: proc { [200, {}, ['it_works']] }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
