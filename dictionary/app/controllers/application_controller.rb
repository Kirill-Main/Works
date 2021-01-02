# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :require_login

  def require_login
    redirect_to login_url unless @current_user = session[:current_user]
  end
end
