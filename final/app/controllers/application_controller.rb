# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :find_authorized_user, :require_login

  def find_authorized_user
    @current_user = session[:current_user]
  end

  def require_login
    unless @current_user
      redirect_to '/login'
      nil
    end
  end

  def require_admin
    unless @current_user['name'] == 'admin'
      redirect_to '/'
      nil
    end
  end
end
