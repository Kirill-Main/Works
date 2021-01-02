# frozen_string_literal: true

require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  def setup
    user = User.new(name: 'Example', email: 'user@ex.com', password: '12345')
    user.save
    post = Post.new(title: 'Example', summary: 'Something', main: 'Main stuff', user_id: user.id)
    post.save
    @comment = Comment.new(user_id: user.id, post_id: post.id, main: 'Comment')
  end

  test 'should be valid' do
    assert @comment.valid?
  end

  test 'main should not be long' do
    @comment.main = 'a' * 201
    assert_not @comment.valid?
  end
end
