# frozen_string_literal: true

Rails.application.routes.draw do
  root 'base#index'

  get '/login' => 'sessions#login'
  get '/logout' => 'sessions#logout'
  get '/register' => 'sessions#register'
  post '/auth' => 'sessions#auth'
  post '/create' => 'sessions#create'

  get '/add' => 'products#add'
  get '/show/:product_id' => 'products#show'
  get '/add_quesstion' => 'products#add_quesstion'
  get '/add_answer' => 'products#add_answer'
  post '/new' => 'products#new'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
