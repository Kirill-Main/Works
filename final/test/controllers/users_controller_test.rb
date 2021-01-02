# frozen_string_literal: true

require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  test 'should get login' do
    get '/login'
    assert_response :success
  end

  test 'should get register' do
    get '/register'
    assert_response :success
  end

  test 'should create a new user and exit and login' do
    post '/create', params: {
      email: 'email@yandex.ru',
      name: 'User',
      password: '123',
      another_password: '123'
    }
    assert_response :redirect

    get '/logout'
    assert_response :redirect

    post '/auth', params: {
      email: 'email@yandex.ru',
      password: '123'
    }
    assert_response :redirect
  end
end
