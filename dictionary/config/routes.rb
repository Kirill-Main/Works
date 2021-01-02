# frozen_string_literal: true

Rails.application.routes.draw do
  root 'base#index'

  match '/login' => 'users#login', :via => %i[get post]
  match '/register' => 'users#register', :via => %i[get post]
  get '/logout' => 'users#logout'

  post '/add' => 'logics#add'
  post '/remove' => 'logics#remove'
  post '/change' => 'logics#change'
  post '/remove_all' => 'logics#remove_all'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
