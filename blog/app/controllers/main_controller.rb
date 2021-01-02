# frozen_string_literal: true

class MainController < ApplicationController
  def index
    if Post.all.length.positive?
      @posts = Post.all.group_by(&:user_id)
      @users = User.all
    else
      @posts = []
    end
  end
end
