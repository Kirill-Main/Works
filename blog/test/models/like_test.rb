# frozen_string_literal: true

require 'test_helper'

class LikeTest < ActiveSupport::TestCase
  def setup
    user = User.new(name: 'Example', email: 'user@ex.com', password: '12345')
    user.save
    post = Post.new(title: 'Example', summary: 'Something', main: 'Main stuff', user_id: user.id)
    post.save
    @like = Like.new(user_id: user.id, post_id: post.id)
  end

  test 'should be valid' do
    assert @like.valid?
  end
end
