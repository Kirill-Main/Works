# frozen_string_literal: true

class ProductsController < ApplicationController
  def add; end

  def new
    name = params[:name]
    main = params[:main]
    price = params[:price].to_i

    product = Product.new(name: name, main: main, price: price, user_id: @user['id'])
    product.save

    redirect_to '/'
  end

  def show
    product_id = params[:product_id].to_i
    if @user
      @conversations = Conversation.where(product_id: product_id)
      @user_conversations = Conversation.where(product_id: product_id, user_id: @user['id']).reject do |conversation|
        conversation.answer == ''
      end
      @users = User.all
    end
    @product = Product.find_by(id: product_id)
    @seller = User.find_by(id: @product.user_id)
  end

  def add_quesstion
    product_id = params[:id].to_i
    quesstion = params[:quesstion]

    conversation = Conversation.new(
      user_id: @user['id'], answer: '', quesstion: quesstion,
      product_id: product_id
    )
    result = conversation.save

    respond_to do |format|
      format.json do
        render json:
            { result: result }
      end
    end
  end

  def add_answer
    answer = params[:answer]
    id = params[:id].to_i
    conversation = Conversation.find_by(id: id)
    conversation.answer = answer
    result = conversation.save

    respond_to do |format|
      format.json do
        render json:
            { result: result }
      end
    end
  end
end
