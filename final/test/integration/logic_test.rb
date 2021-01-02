# frozen_string_literal: true

require 'test_helper'

class LogicTest < ActionDispatch::IntegrationTest
  test 'should register a new user and add new idiom and save it and can see saved idioms' do
    post '/create', params: {
      email: 'admin@yandex.ru',
      name: 'admin',
      password: 'admin',
      another_password: 'admin'
    }
    assert_response :redirect

    post '/new', params: {
      str_from: 'быть маленьким',
      str_to: 'the world is your oyster'
    }
    assert_response :redirect

    get '/find', params: {
      idiom_from: 'быть маленьким',
      language_from: 'ru',
      idiom_to: 'the world is your oyster',
      language_to: 'en',
      format: 'json'
    }
    assert_response :success
    assert_includes @response.headers['Content-Type'], 'application/json'

    get '/save', params: {
      str_from: 'быть маленьким',
      str_to: 'the world is your oyster',
      format: 'json'
    }
    assert_response :success
    assert_includes @response.headers['Content-Type'], 'application/json'

    get '/show_saved'
    assert assigns[:idioms].length.positive?
  end
end
