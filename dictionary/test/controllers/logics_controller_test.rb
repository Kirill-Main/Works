# frozen_string_literal: true

require 'test_helper'

class LogicsControllerTest < ActionDispatch::IntegrationTest
  test 'should redirect from add' do
    post add_url
    assert_response :redirect
  end

  test 'should redirect from remove' do
    post remove_url
    assert_response :redirect
  end

  test 'should redirect from remove_all' do
    post remove_all_url
    assert_response :redirect
  end

  test 'should redirect from change' do
    post change_url
    assert_response :redirect
  end
end
