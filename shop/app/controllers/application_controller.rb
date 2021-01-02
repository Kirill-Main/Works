# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :find_user

  def find_user
    @user = session[:user]
  end
end
