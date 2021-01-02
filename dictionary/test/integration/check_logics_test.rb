# frozen_string_literal: true

require 'test_helper'

class CheckLogicsTest < ActionDispatch::IntegrationTest
  test 'should register a new user and add new word and change it and then delete it' do
    post '/register', params: {
      email: 'admin@yandex.ru',
      name: 'admin',
      password: 'admin',
      another_password: 'admin'
    }
    assert_response :redirect

    post '/add', params: {
      str_from: 'дом',
      str_to: 'house',
      format: 'json'
    }
    assert_response :success
    assert_includes @response.headers['Content-Type'], 'application/json'

    post '/change', params: {
      change_str_from: 'дом1',
      change_str_to: 'house',
      id_field: Translation.last.id,
      format: 'json'
    }
    assert_response :success
    assert_includes @response.headers['Content-Type'], 'application/json'

    post '/remove', params: {
      id: Translation.last.id,
      format: 'json'
    }
    assert_response :success
    assert_includes @response.headers['Content-Type'], 'application/json'
  end
end
