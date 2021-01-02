# frozen_string_literal: true

require 'test_helper'

class PostsLogicControllerTest < ActionDispatch::IntegrationTest
  test 'should get add' do
    get '/add'
    assert_response :success
  end
end
