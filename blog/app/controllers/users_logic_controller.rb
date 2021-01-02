# frozen_string_literal: true

class UsersLogicController < ApplicationController
  def login
    @error = params[:error]
  end

  def register
    @error = params[:error]
  end

  def auth
    email = params[:email]
    password = Digest::SHA1.hexdigest params[:password]

    if session[:user] = User.find_by(email: email, password: password)
      redirect_to '/'
    else
      redirect_to action: 'login', error: 'Неправильно указан email и/или пароль'
    end
  end

  def create
    email = params[:email]
    name = params[:name]
    password = params[:password]
    another_password = params[:another_password]

    unless password == another_password
      redirect_to action: 'register', error: 'Введенные пароли не совпадают'
      return
    end

    if User.find_by(email: email) || User.find_by(name: name)
      redirect_to action: 'register', error: 'Пользователь с email и/или имененм уже существует'
      return
    end

    password = Digest::SHA1.hexdigest password
    user = User.new(email: email, name: name, password: password)
    unless user.save
      redirect_to action: 'register', error: 'Проверьте правильность введенных данных'
      return
    end
    session[:user] = user
    redirect_to '/'
  end

  def logout
    session[:user] = nil
    redirect_to '/'
  end
end
