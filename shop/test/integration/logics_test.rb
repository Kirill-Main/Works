# frozen_string_literal: true

require 'test_helper'

class LogicsTest < ActionDispatch::IntegrationTest
  test 'should register 2 new users and add a new product and open it and add a quesstion' do
    post '/create', params: {
      email: 'user@yandex.ru',
      name: 'user',
      phone: '89150051550',
      password: '12345',
      another_password: '12345'
    }
    assert_response :redirect

    post '/new', params: {
      name: 'Test',
      main: 'Test main',
      price: 5000
    }
    assert_response :redirect

    get '/logout'
    assert_response :redirect

    post '/create', params: {
      email: 'user1@yandex.ru',
      name: 'user1',
      phone: '89150051555',
      password: '000',
      another_password: '000'
    }
    assert_response :redirect

    get "/show/#{Product.last.id}"
    assert_response :success

    get '/add_quesstion', params: {
      id: Product.last.id,
      quesstion: 'Interesting!',
      format: 'json'
    }
    assert_response :success
    assert_includes @response.headers['Content-Type'], 'application/json'
  end
end
