# frozen_string_literal: true

require 'test_helper'

class BaseControllerTest < ActionDispatch::IntegrationTest
  test 'should redirect from index' do
    get root_url
    assert_response :redirect
  end
end
