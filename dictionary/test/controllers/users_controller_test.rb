# frozen_string_literal: true

require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  test 'should get login' do
    get login_url
    assert_response :success
  end

  test 'should get register' do
    get register_url
    assert_response :success
  end

  test 'should create a new user and exit and login' do
    post register_url, params: {
      email: 'email@mail.ru',
      name: 'User',
      password: '12345',
      another_password: '12345'
    }
    assert_response :redirect

    get logout_url
    assert_response :redirect

    post login_url, params: {
      email: 'email@mail.ru',
      password: '12345'
    }
    assert_response :redirect
  end
end
