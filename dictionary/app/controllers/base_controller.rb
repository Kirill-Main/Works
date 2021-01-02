# frozen_string_literal: true

class BaseController < ApplicationController
  def index
    @translations = Translation.where(user_id: @current_user['id'], is_hidden: false)
  end
end
