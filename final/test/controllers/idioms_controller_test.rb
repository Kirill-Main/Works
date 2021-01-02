# frozen_string_literal: true

require 'test_helper'

class IdiomsControllerTest < ActionDispatch::IntegrationTest
  test 'should not get add' do
    get '/add'
    assert_response :redirect
  end

  test 'should not get show_all' do
    get '/show_all'
  end

  test 'should not get show_saved' do
    get '/show_saved'
  end

  test 'should find a result' do
    get '/find', params: {
      idiom_from: 'быть', language_from: 'ru',
      language_to: 'en', format: 'json'
    }
    assert_response :success
    assert_equal assigns[:result],
                 'К сожалению, идиома не найдена. Попробуйте повторить ввод или сообщить об этом на почту admin@yandex.ru'
    assert_includes @response.headers['Content-Type'], 'application/json'
  end

  test 'should not save a new idiom' do
    post '/new', params: {
      str_from: 'быть маленьким',
      str_to: 'to be a shrimp'
    }
    assert_response :redirect
  end
end
