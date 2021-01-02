# frozen_string_literal: true

class PostsLogicController < ApplicationController
  def add; end

  def new
    title = params[:title]
    summary = params[:summary]
    main = params[:main]

    post = Post.new(title: title, summary: summary, main: main, user_id: @user['id'], rating: 0)
    unless post.save
      redirect_to action: 'add', error: 'Проверьте правильность введенных данных'
      return
    end
    redirect_to '/'
  end

  def add_comment
    post_id = params[:post_id].to_i
    main = params[:main]

    comment = Comment.new(user_id: @user['id'], post_id: post_id, main: main)
    comment.save

    respond_to do |format|
      format.json do
        render json:
            { name: @user['name'] }
      end
    end
  end

  def add_rating
    post_id = params[:post_id].to_i

    post = Post.find_by(id: post_id)

    if Like.find_by(user_id: @user['id'], post_id: post_id)
      respond_to do |format|
        format.json do
          render json:
              { rating: post.rating }
        end
      end
      return
    end
    post.rating += 1
    post.save
    like = Like.new(user_id: @user['id'], post_id: post_id)
    like.save

    respond_to do |format|
      format.json do
        render json:
            { rating: post.rating }
      end
    end
  end

  def show
    post_id = params[:post_id].to_i
    @post = Post.find_by(id: post_id)
    @comments = Comment.where(post_id: @post.id).sort_by { |comment| -comment.created_at.to_i }
    @users = User.all
  end
end
