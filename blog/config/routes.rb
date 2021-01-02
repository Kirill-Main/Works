# frozen_string_literal: true

Rails.application.routes.draw do
  root 'main#index'

  get '/add' => 'posts_logic#add'
  get '/show/:post_id' => 'posts_logic#show'
  get '/add_comment' => 'posts_logic#add_comment'
  get '/add_rating' => 'posts_logic#add_rating'
  post '/new' => 'posts_logic#new'

  get '/login' => 'users_logic#login'
  get '/logout' => 'users_logic#logout'
  get '/register' => 'users_logic#register'
  post '/auth' => 'users_logic#auth'
  post '/create' => 'users_logic#create'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
