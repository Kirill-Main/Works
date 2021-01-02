# frozen_string_literal: true

class BaseController < ApplicationController
  skip_before_action :require_login

  def index; end

  def about
    @count = Idiom.all.length
  end
end
