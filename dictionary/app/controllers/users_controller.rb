# frozen_string_literal: true

class UsersController < ApplicationController
  skip_before_action :require_login

  def login
    return unless request.post?

    email = params[:email]
    password = Digest::SHA1.hexdigest params[:password]

    if session[:current_user] = User.find_by(email: email, password: password)
      redirect_to root_url
    else
      flash.now[:error] = 'Неправильно указан email и/или пароль'
    end
  end

  def register
    return unless request.post?

    email = params[:email]
    name = params[:name]
    password = params[:password]
    another_password = params[:another_password]

    unless password == another_password
      flash.now[:error] = 'Введенные пароли не совпадают'
      return
    end

    if User.find_by(email: email) || User.find_by(name: name)
      flash.now[:error] = 'Пользователь с email и/или имененм уже существует'
      return
    end

    password = Digest::SHA1.hexdigest password
    user = User.new(email: email, name: name, password: password)

    unless user.save
      flash.now[:error] = 'Проверьте правильность введенных данных'
      return
    end

    session[:current_user] = user
    redirect_to root_url
  end

  def logout
    session.delete :current_user
    redirect_to login_url
  end
end
