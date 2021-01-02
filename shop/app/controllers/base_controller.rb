# frozen_string_literal: true

class BaseController < ApplicationController
  def index
    @products = Product.all
    conversation = Conversation.find_by(id: 1)
  end
end
