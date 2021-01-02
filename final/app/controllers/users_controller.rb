# frozen_string_literal: true

class UsersController < ApplicationController
  skip_before_action :require_login

  def login; end

  def register; end

  def auth
    email = params[:email]
    password = Digest::SHA1.hexdigest params[:password]

    if session[:current_user] = User.find_by(email: email, password: password)
      redirect_to '/'
    else
      @error = 'Неправильно указан email и/или пароль'
      render :login
    end
  end

  def create
    email = params[:email]
    name = params[:name]
    password = params[:password]
    another_password = params[:another_password]

    unless password == another_password
      @error = 'Введенные пароли не совпадают'
      render :register
      return
    end

    if session[:current_user] = User.find_by(email: email, name: name)
      @error = 'Пользователь с email и/или имененм уже существует'
      render :register
      return
    end

    password = Digest::SHA1.hexdigest password
    user = User.new(email: email, name: name, password: password)
    unless user.save
      @error = 'Проверьте правильность введенных данных'
      render :register
      return
    end
    session[:current_user] = user
    redirect_to '/'
  end

  def logout
    session[:current_user] = nil
    redirect_to '/'
  end
end
