# frozen_string_literal: true

require 'test_helper'

class UsersLogicControllerTest < ActionDispatch::IntegrationTest
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
      email: 'email@ex.ru',
      name: 'User',
      password: '555',
      another_password: '555'
    }
    assert_response :redirect

    get '/logout'
    assert_response :redirect

    post '/auth', params: {
      email: 'email@ex.ru',
      password: '555'
    }
    assert_response :redirect
  end
end
