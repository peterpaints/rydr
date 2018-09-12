# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'sessions#new'

  resources :users
  get '/register', to: 'users#new'
  post '/register', to: 'users#create'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'

  get '/rides/:id/book', to: 'rides#book', as: 'book_ride'
  get '/rides/:id/cancel', to: 'rides#cancel', as: 'cancel_ride'

  get '/notifications/mark_as_read', to: 'notifications#mark_as_read', as: 'mark_as_read'

  resources :vehicles
  resources :rides
  resources :notifications
end
