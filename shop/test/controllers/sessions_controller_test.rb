# frozen_string_literal: true

require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  test 'should get login' do
    get '/login'
    assert_response :success
  end

  test 'should get register' do
    get '/register'
    assert_response :success
  end

  test 'should create a new user' do
    post '/create',
         params: { name: 'Example Name', email: 'user@example.com', phone: '89150051550', password: '12345',
                   another_password: '12345' }
    assert_response :redirect
  end
end
