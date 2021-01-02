# frozen_string_literal: true

require 'test_helper'

class PostTest < ActiveSupport::TestCase
  def setup
    user = User.new(name: 'Example', email: 'user@ex.com', password: '12345')
    user.save
    @post = Post.new(title: 'Example', summary: 'Something', main: 'Main stuff', user_id: user.id)
  end

  test 'should be valid' do
    assert @post.valid?
  end

  test 'should not save duplicate' do
    another_post = @post.dup
    assert @post.save
    assert_not another_post.save
  end

  test 'title should not be long' do
    @post.title = 'a' * 21
    assert_not @post.valid?
  end

  test 'summary should not be long' do
    @post.summary = 'a' * 51
    assert_not @post.valid?
  end

  test 'main should not be long' do
    @post.main = 'a' * 201
    assert_not @post.valid?
  end
end
