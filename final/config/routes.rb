# frozen_string_literal: true

Rails.application.routes.draw do
  root 'base#index'
  get '/about' => 'base#about'

  get '/show_saved' => 'idioms#show_saved'
  get '/add' => 'idioms#add'
  get '/save' => 'idioms#save'
  get '/find' => 'idioms#find'
  get '/remove_from_saved/:idiom_id' => 'idioms#remove_from_saved'
  get '/show_all' => 'idioms#show_all'
  post '/new' => 'idioms#new'

  get '/login' => 'users#login'
  get '/logout' => 'users#logout'
  get '/register' => 'users#register'
  post '/auth' => 'users#auth'
  post '/create' => 'users#create'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
