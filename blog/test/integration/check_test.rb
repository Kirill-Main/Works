# frozen_string_literal: true

require 'test_helper'

class CheckTest < ActionDispatch::IntegrationTest
  test 'should register a new user and create a new post and open it and add a comment and like post' do
    post '/create', params: {
      email: 'admin@yandex.ru',
      name: 'admin',
      password: 'admin',
      another_password: 'admin'
    }
    assert_response :redirect

    post '/new', params: {
      title: 'Example',
      summary: 'Something',
      main: "Look! It's here"
    }
    assert_response :redirect

    get "/show/#{Post.last.id}"
    assert_response :success

    get '/add_comment', params: {
      post_id: Post.last.id,
      main: 'Interesting!',
      format: 'json'
    }
    assert_response :success
    assert_includes @response.headers['Content-Type'], 'application/json'

    get '/add_rating', params: {
      post_id: Post.last.id,
      format: 'json'
    }
    assert_response :success
    assert_includes @response.headers['Content-Type'], 'application/json'
  end
end
